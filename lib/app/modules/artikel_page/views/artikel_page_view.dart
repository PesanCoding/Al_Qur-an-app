import 'package:alquran/app/modules/artikel_page/widgets/article_card.dart';
import 'package:alquran/app/modules/artikel_page/widgets/article_card_shimmer.dart';
import 'package:alquran/widgets/constans.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:alquran/global.dart';
import '../controllers/artikel_page_controller.dart';

class ArtikelPageView extends StatelessWidget {
  ArtikelPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final articleC = Get.put(ArtikelPageController());
    articleC.loadArticle();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary.withOpacity(0.4),
        title: const Text(
          'ArtikelPageView',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        return articleC.articleIsLoading.value
            ? ListView.separated(
                scrollDirection: Axis.vertical,
                padding: const EdgeInsets.symmetric(vertical: 20),
                itemBuilder: (context, i) {
                  return const ArticleCardShimmer();
                },
                separatorBuilder: (context, i) {
                  return const SizedBox(height: 20);
                },
                itemCount: 3,
              )
            : ListView.separated(
                scrollDirection: Axis.vertical,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                itemBuilder: (context, i) {
                  return FadeInDown(
                    from: 50,
                    child: ArticleCard(
                        height: 450,
                        logoUrl: articleC.articles.toList()[i].logo!,
                        title: articleC.articles.toList()[i].title!,
                        pubDate: articleC.articles.toList()[i].datePublished!,
                        thumbnailUrl: articleC.articles.toList()[i].thumbnail!,
                        author: articleC.articles.toList()[i].author!,
                        onTap: () => Helper.launchURL(
                              articleC.articlesAtHome.toList()[i].link!,
                            )),
                  );
                },
                separatorBuilder: (context, i) {
                  return const SizedBox(height: 20);
                },
                itemCount: articleC.articles.length,
              );
      }),
    );
  }
}
