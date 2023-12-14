import 'package:get/get.dart';

import '../modules/artikel_page/bindings/artikel_page_binding.dart';
import '../modules/artikel_page/views/artikel_page_view.dart';
import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/detail_surah/bindings/detail_surah_binding.dart';
import '../modules/detail_surah/views/detail_surah_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/introduction/bindings/introduction_binding.dart';
import '../modules/introduction/views/introduction_view.dart';
import '../modules/prayer_time/bindings/prayer_time_binding.dart';
import '../modules/prayer_time/views/prayer_time_view.dart';
import '../modules/profile_page/bindings/profile_page_binding.dart';
import '../modules/profile_page/views/profile_page_view.dart';
import '../modules/quran/bindings/quran_binding.dart';
import '../modules/quran/views/quran_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.INTRODUCTION,
      page: () => const IntroductionView(),
      binding: IntroductionBinding(),
    ),
    GetPage(
      name: _Paths.QURAN,
      page: () => QuranView(),
      binding: QuranBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_SURAH,
      page: () => DetailSurahView(),
      binding: DetailSurahBinding(),
    ),
    GetPage(
      name: _Paths.PRAYER_TIME,
      page: () => PrayerTimeView(),
      binding: PrayerTimeBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE_PAGE,
      page: () => const ProfilePageView(),
      binding: ProfilePageBinding(),
    ),
    GetPage(
      name: _Paths.ARTIKEL_PAGE,
      page: () => ArtikelPageView(),
      binding: ArtikelPageBinding(),
    ),
  ];
}
