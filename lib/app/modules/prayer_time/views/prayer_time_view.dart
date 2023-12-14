import 'package:adhan/adhan.dart';
import 'package:alquran/global.dart';
import 'package:alquran/widgets/app_card.dart';
import 'package:alquran/widgets/prayer_time_card.dart';
import 'package:alquran/widgets/prayer_time_page_shimmer.dart';
import 'package:alquran/widgets/select_time.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:get/get.dart';
import 'package:group_button/group_button.dart';

import '../controllers/prayer_time_controller.dart';

class PrayerTimeView extends GetView<PrayerTimeController> {
  PrayerTimeView({Key? key}) : super(key: key);
  final prayerTimeC = Get.put(PrayerTimeControllerImpl());
  final groupBtnController = GroupButtonController(
      // selectedIndex: 0,
      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(const Duration(milliseconds: 1500));
        toNextPrayer();
      },
      backgroundColor: Colors.white,
      color: Theme.of(context).primaryColor,
      strokeWidth: 3,
      triggerMode: RefreshIndicatorTriggerMode.onEdge,
      child: Obx(() {
        return prayerTimeC.isLoadLocation.value
            ? const SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: PrayerTimePageShimmer(),
              )
            : SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: ListView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    Text(
                      "Hari ini",
                      style: AppTextStyle.title,
                    ),
                    const SizedBox(height: 10),
                    Hero(
                      tag: 'prayer_time_card',
                      child: PrayerTimeCard(prayerTimeC: prayerTimeC),
                    ),
                    const SizedBox(height: 20),
                    Obx(() {
                      var time = prayerTimeC.prayerTimesToday.value;
                      var shubuh = time.shubuh;
                      var sunrise = time.sunrise;
                      var dhuhur = time.dhuhur;
                      var ashar = time.ashar;
                      var maghrib = time.maghrib;
                      var isya = time.isya;
                      var lastThirdOfTheNight = time.lastThirdOfTheNight;

                      List<DateTime?> prayerTimes = [
                        shubuh,
                        sunrise,
                        dhuhur,
                        ashar,
                        maghrib,
                        isya,
                        lastThirdOfTheNight,
                      ];
                      List prayerNames = [
                        "Shubuh",
                        "Terbit",
                        "Dzuhur",
                        "Ashar",
                        "Maghrib",
                        "isya",
                        "Qiyam",
                      ];
                      return FadeInDown(
                        from: 40,
                        child: AppCard(
                          hMargin: 0,
                          child: SizedBox(
                            height: 440,
                            width: MediaQuery.of(context).size.width,
                            child: ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, i) {
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${prayerTimes[i]?.hour.toString().padLeft(2, '0') ?? "--"}:${prayerTimes[i]?.minute.toString().padLeft(2, '0') ?? "--"}",
                                          style: AppTextStyle.normal.copyWith(
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                          "${prayerNames[i]}",
                                          style: AppTextStyle.normal.copyWith(
                                              fontSize: 15,
                                              color: const Color(0xFF009595)),
                                        )
                                      ],
                                    ),
                                    const SizedBox(width: 20),
                                    const Spacer(),
                                    Text(
                                      "${prayerTimes[i]?.day.toString().padLeft(2, '0') ?? "--"}/${prayerTimes[i]?.month.toString().padLeft(2, '0') ?? "--"}/${prayerTimes[i]?.year ?? "--"}",
                                      style: AppTextStyle.small.copyWith(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons
                                            .notifications_active_outlined),
                                        color: const Color(0xFF009595))
                                  ],
                                );
                              },
                              separatorBuilder: (context, i) {
                                return const Divider();
                              },
                              itemCount: prayerTimes.length,
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              );
      }),
    ));
  }

  void toNextPrayer() {
    prayerTimeC.getLocation().then((_) {
      prayerTimeC.cT.restart(duration: prayerTimeC.leftOver.value);
    });
  }

  void showSetPrayerTime(
      {required DateTime prayerTime, required String prayerName}) {
    int? hour, minute;

    Get.bottomSheet(
      SelectTime(
        controller: groupBtnController,
        onSelected: (value, index, selected) {
          debugPrint("$value $index $selected");

          switch (index) {
            case 0:
              hour = 0;
              minute = 0; // in second
              break;
            case 1:
              hour = 0;
              minute = 300; // in second
              break;
            case 2:
              hour = 0;
              minute = 600; // in second
              break;
            case 3:
              hour = 0;
              minute = 900; // in second
              break;
            case 4:
              hour = 0;
              minute = 1200; // in second
              break;

            default:
          }
        },
      ),
    );
  }
}
