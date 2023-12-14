import 'package:alquran/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alquran/app/data/models/surah.dart';
import '../controllers/quran_controller.dart';

class QuranView extends GetView<QuranController> {
  QuranView({Key? key}) : super(key: key);
  final controller = Get.put(QuranController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Surah>>(
        future: controller.getAllSurah(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData) {
            return Center(
              child: Text("Tidak ada data."),
            );
          }
          return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Surah surah = snapshot.data![index];
                return ListTile(
                  onTap: () {
                    Get.toNamed(Routes.DETAIL_SURAH, arguments: surah);
                  },
                  leading: CircleAvatar(
                    child: Text("${surah.number}"),
                  ),
                  title:
                      Text("${surah.name?.transliteration?.id ?? 'Erorr..'}"),
                  subtitle: Text(
                      "${surah.numberOfVerses} Ayat | ${surah.revelation?.id ?? 'Erorr..'}"),
                  trailing: Text("${surah.name?.short ?? 'Erorr..'}"),
                );
              });
        },
      ),
    );
  }
}
