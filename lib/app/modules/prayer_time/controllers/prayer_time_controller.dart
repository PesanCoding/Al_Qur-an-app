import 'package:adhan/adhan.dart';
import 'package:alquran/app/data/models/prayer_time.dart';
import 'package:alquran/formater/result_formatter.dart';
import 'package:alquran/widgets/app_permission_status.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:unicons/unicons.dart';
import 'dart:developer';

const api = "https://waktusholat.org/api/docs/today";

class _CurrentLocation {
  double latitude;
  double longitude;
  _CurrentLocation({this.latitude = 0, this.longitude = 0});
}

abstract class PrayerTimeController extends GetxController {
  Future<LocationResultFormatter> handleLocationPermission();
  Future<bool> openAppSetting();
  Future<void> getLocation();
  void getPrayerTimesToday(double latitude, double longitude);
  void getAddressLocationDetail(double latitude, double longitude);
}

class PrayerTimeControllerImpl extends PrayerTimeController {
  var currentLocation = _CurrentLocation().obs;
  var prayerTimesToday = PrayerTime().obs;
  var nextPrayer = Prayer.none.obs;
  var currentPrayer = Prayer.none.obs;
  var currentAddress = Placemark().obs;
  var leftOver = 0.obs;
  var sensorIsSupported = false.obs;
  var qiblahDirection = 0.0.obs;
  var isLoadLocation = false.obs;
  final cT = CountDownController();

  @override
  Future<LocationResultFormatter> handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return LocationResultFormatter(false, 'Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return LocationResultFormatter(false, 'Permission denied.');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return LocationResultFormatter(false,
          "Please, enable this app's location permission in settings to use this feature.");
    }
    return LocationResultFormatter(true, 'Permission granted.');
  }

  @override
  Future<bool> openAppSetting() async {
    final opened = await Geolocator.openAppSettings();
    if (opened) {
      log("Opened location setting");
    } else {
      log("Error opening location setting");
    }
    return opened;
  }

  @override
  Future<void> getLocation() async {
    isLoadLocation.value = true;
    final handlePermission = await handleLocationPermission();
    if (!handlePermission.result) {
      Get.bottomSheet(
        AppPermissionStatus(
          icon: UniconsLine.map_marker_slash,
          title: "Allow Access Location",
          message: handlePermission.error.toString(),
          onPressed: () {
            final prayerC = Get.find<PrayerTimeControllerImpl>();
            prayerC.openAppSetting().then((value) {
              if (!value) {
                Get.snackbar("Opps", "Cannot open setting");
              }
            });
          },
        ),
      );
    } else {
      final location = await Geolocator.getCurrentPosition();
      var loc = _CurrentLocation(
        latitude: location.latitude,
        longitude: location.longitude,
      );
      currentLocation(loc);
      getPrayerTimesToday(location.latitude, location.longitude);
      getAddressLocationDetail(location.latitude, location.longitude);

      isLoadLocation.value = false;
    }
  }

  @override
  void getPrayerTimesToday(double latitude, double longitude) {
    log(latitude.toString());
    log(longitude.toString());
    final myCoordinates = Coordinates(latitude, longitude);
    final params = CalculationMethod.singapore.getParameters();
    params.madhab = Madhab.shafi;
    final prayerTimes = PrayerTimes.today(myCoordinates, params);
    final sunnahTimes = SunnahTimes(prayerTimes);

    log(prayerTimes.fajr.toString());
    log(prayerTimes.sunrise.toString());
    log(prayerTimes.dhuhr.toString());
    log(prayerTimes.asr.toString());
    log(prayerTimes.maghrib.toString());
    log(prayerTimes.isha.toString());
    log(sunnahTimes.middleOfTheNight.toString());
    log(sunnahTimes.lastThirdOfTheNight.toString());

    var result = PrayerTime(
      shubuh: prayerTimes.fajr,
      sunrise: prayerTimes.sunrise,
      dhuhur: prayerTimes.dhuhr,
      ashar: prayerTimes.asr,
      maghrib: prayerTimes.maghrib,
      isya: prayerTimes.isha,
      middleOfTheNight: sunnahTimes.middleOfTheNight,
      lastThirdOfTheNight: sunnahTimes.lastThirdOfTheNight,
    );
    currentPrayer(prayerTimes.currentPrayer());
    log("Current prayer: ${prayerTimes.currentPrayer()}");

    nextPrayer(prayerTimes.nextPrayer());
    log("Next prayer: ${prayerTimes.nextPrayer()}");
    prayerTimesToday(result);
    prayerTimesToday.value = result;
  }

  @override
  void getAddressLocationDetail(double latitude, double longitude) async {
    List<Placemark> placeMarks;
    try {
      log("$latitude");
      log("$longitude");
      placeMarks = await placemarkFromCoordinates(
        latitude,
        longitude,
      );

      var address = placeMarks[0];

      log("$address");
      currentAddress(address);
    } on PlatformException catch (e) {
      log(e.toString());
      await Future.delayed(const Duration(milliseconds: 300));
      try {
        placeMarks = await placemarkFromCoordinates(latitude, longitude);
        var address = placeMarks[0];

        log("$address");
        currentAddress(address);
      } catch (e) {
        Get.snackbar(
            "Opps", 'Address was not retrieved, please fill out manually');
      }
    }
  }

  var isQiblahLoaded = false.obs;
  void getQiblah(double latitude, double longitude) {
    final myCoordinates = Coordinates(latitude, longitude);
    final qiblah = Qibla(myCoordinates);
    print("Qiblah: ${qiblah.direction}");
    qiblahDirection.value = qiblah.direction;
  }

  @override
  void onInit() async {
    super.onInit();
    await getLocation();
    // await Future.delayed(1.seconds);
  }
}
