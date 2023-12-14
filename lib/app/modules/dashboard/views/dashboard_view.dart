import 'package:alquran/app/modules/artikel_page/controllers/artikel_page_controller.dart';
import 'package:alquran/app/modules/artikel_page/views/artikel_page_view.dart';
import 'package:alquran/app/modules/artikel_page/widgets/article_card.dart';
import 'package:alquran/app/modules/artikel_page/widgets/article_card_shimmer.dart';
import 'package:alquran/app/modules/prayer_time/controllers/prayer_time_controller.dart';
import 'package:alquran/app/modules/prayer_time/views/prayer_time_view.dart';
import 'package:alquran/app/modules/profile_page/views/profile_page_view.dart';
import 'package:alquran/global.dart';
import 'package:alquran/widgets/app_card.dart';
import 'package:alquran/widgets/constans.dart';
import 'package:alquran/widgets/prayer_time_card.dart';
import 'package:alquran/widgets/prayer_time_card_shimmer.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

import 'package:get/get.dart';

class DashboardView extends StatelessWidget {
  DashboardView({Key? key}) : super(key: key);

  final prayerTimeC = Get.put(PrayerTimeControllerImpl());
  final articleC = Get.put(ArtikelPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(milliseconds: 1500));
          prayerTimeC.getLocation().then((_) {
            prayerTimeC.cT.restart(duration: prayerTimeC.leftOver.value);
          });
        },
        backgroundColor: Theme.of(context).cardColor,
        color: Theme.of(context).primaryColor,
        strokeWidth: 3,
        triggerMode: RefreshIndicatorTriggerMode.onEdge,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Get.to(() => ProfilePageView()),
                      child: Hero(
                        tag: "Avatar",
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          height: 50,
                          width: 50,
                          child: Icon(
                            Icons.person,
                            color: primary,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Assalamu'alaikum,",
                          style: AppTextStyle.small.copyWith(
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "Hamba Allah",
                          style: AppTextStyle.title,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 30),
              FadeInRight(
                from: 50,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Obx(
                    () => prayerTimeC.isLoadLocation.value
                        ? const PrayerTimeCardShimmer()
                        : GestureDetector(
                            onTap: () => Get.to(
                              () => PrayerTimeView(),
                            ),
                            child: Hero(
                              tag: 'prayer_time_card',
                              child: PrayerTimeCard(prayerTimeC: prayerTimeC),
                            ),
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              FadeInLeft(
                from: 50,
                child: AppCard(
                  vPadding: 16,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      UniconsLine.book_open,
                                      size: 16,
                                      color: Colors.grey,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      "Last Read",
                                      style: AppTextStyle.small.copyWith(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  "Qur'an",
                                  style: AppTextStyle.bigTitle.copyWith(
                                    color: primary,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "Surah Al - Fatiha",
                                  style: AppTextStyle.normal,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(top: 16),
                          padding: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 10),
                          decoration: BoxDecoration(
                            color: primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [AppShadow.card],
                          ),
                          child: Center(
                            child: Text(
                              "Baca Lagi",
                              style: AppTextStyle.normal.copyWith(
                                color: primary,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Daily Articles",
                      style: AppTextStyle.bigTitle.copyWith(
                        fontSize: 18,
                      ),
                    ),
                    InkWell(
                      onTap: () => Get.to(() => ArtikelPageView()),
                      child: Text(
                        "See All",
                        style: AppTextStyle.small.copyWith(
                          color: primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Obx(() => articleC.articleAtHomeIsLoading.value
                  ? const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: ArticleCardShimmer(),
                    )
                  : SizedBox(
                      height: 300,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 16,
                        ),
                        itemBuilder: (context, i) {
                          return Row(
                            children: [
                              FadeInRight(
                                from: 50,
                                child: ArticleCard(
                                  logoUrl:
                                      articleC.articlesAtHome.toList()[i].logo!,
                                  title: articleC.articlesAtHome
                                      .toList()[i]
                                      .title!,
                                  pubDate: articleC.articlesAtHome
                                      .toList()[i]
                                      .datePublished!,
                                  thumbnailUrl: articleC.articlesAtHome
                                      .toList()[i]
                                      .thumbnail!,
                                  author: articleC.articlesAtHome
                                      .toList()[i]
                                      .author!,
                                  onTap: () => Helper.launchURL(
                                    articleC.articlesAtHome.toList()[i].link!,
                                  ),
                                ),
                              )
                            ],
                          );
                        },
                        separatorBuilder: (context, i) {
                          return const SizedBox(
                            width: 20,
                          );
                        },
                        itemCount: articleC.articlesAtHome.length,
                      ),
                    ))
            ],
          ),
        ),
      )),
    );
  }
}
