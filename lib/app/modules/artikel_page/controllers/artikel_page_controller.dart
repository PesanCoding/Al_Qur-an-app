import 'dart:developer';

import 'package:alquran/app/modules/artikel_page/controllers/repository/artikel_repo.dart';
import 'package:get/get.dart';
import 'package:alquran/app/modules/artikel_page/controllers/entities/artikel.dart';

const resFeeds = <String, String>{
  "mutiaraIslam": "https://mutiaraislam.net/feed/",
  "aboutIslamSpirituality": "https://aboutislam.net/spirituality/feed/",
};

class ArtikelPageController extends GetxController {
  var articles = <Article>{}.obs;
  var articlesAtHome = <Article>{}.obs;
  var articleAtHomeIsLoading = false.obs;
  var articleIsLoading = false.obs;

  Future<void> loadArtikelForHome() async {
    articleAtHomeIsLoading.value = true;

    final feed = await ArticleRepository.fetchFeed(resFeeds.values.first);
    if (feed != null) {
      for (var item in feed.items) {
        Article _article = Article(logo: feed.feed.image);
        _article.title = item.title;
        _article.link = item.link;
        _article.thumbnail = item.thumbnail;
        _article.datePublished = item.pubDate;
        _article.categories = item.categories;
        _article.author = item.author;

        if (articlesAtHome.length <= 3) {
          articlesAtHome.add(_article);
          log(articlesAtHome.length.toString());
        }
        articleAtHomeIsLoading.value = false;
        await Future.delayed(800.milliseconds);
      }
    }
  }

  Future<void> loadArticle() async {
    articleIsLoading.value = true;

    resFeeds.forEach((key, value) async {
      final feed = await ArticleRepository.fetchFeed(value);
      if (feed != null) {
        for (var item in feed.items) {
          Article _article = Article(logo: feed.feed.image);
          _article.title = item.title;
          _article.link = item.link;
          _article.thumbnail = item.thumbnail;
          _article.datePublished = item.pubDate;
          _article.categories = item.categories;
          _article.author = item.author;

          articles.add(_article);

          articleIsLoading.value = false;
          await Future.delayed(800.milliseconds);
        }
      }

      log(articles.length.toString());
    });

    articleIsLoading.value = false;
  }

  @override
  void onInit() {
    loadArtikelForHome();
    super.onInit();
  }
}
