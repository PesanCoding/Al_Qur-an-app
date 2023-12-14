import 'package:alquran/app/data/models/detail_surah.dart' as detail;
import 'package:alquran/app/data/models/surah.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/detail_surah_controller.dart';

class DetailSurahView extends GetView<DetailSurahController> {
  DetailSurahView({Key? key}) : super(key: key);
  final Surah surah = Get.arguments;
  final controller = Get.put(DetailSurahController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF009595),
        title: Text(
            '${surah.name?.transliteration?.id?.toUpperCase() ?? 'Error...'}',
            style: GoogleFonts.poppins(fontSize: 20, color: Colors.white)),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(children: [
                Text(
                  '${surah.name?.transliteration?.id?.toUpperCase() ?? 'Error...'}',
                  style: GoogleFonts.poppins(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  '(${surah.name?.translation?.id ?? 'Error...'})',
                  style: GoogleFonts.poppins(fontSize: 18),
                ),
                const SizedBox(height: 10),
                Text(
                  '${surah.numberOfVerses ?? 'Error...'} Ayat | ${surah.revelation?.id ?? 'Error...'}',
                  style: GoogleFonts.poppins(fontSize: 16),
                ),
              ]),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: FutureBuilder<detail.DetailSurah>(
              future: controller.getDetailSurah(surah.number.toString()),
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
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data?.verses?.length ?? 0,
                    itemBuilder: (context, index) {
                      if (snapshot.data?.verses?.length == 0) {
                        return SizedBox();
                      }
                      detail.Verse? ayat = snapshot.data?.verses?[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CircleAvatar(
                                      child: Text("${index + 1}"),
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {},
                                          icon:
                                              Icon(Icons.bookmark_add_outlined),
                                        ),
                                        IconButton(
                                          onPressed: () {},
                                          icon: Icon(Icons.play_arrow),
                                        ),
                                      ],
                                    ),
                                  ]),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "${ayat!.text?.arab}",
                            textAlign: TextAlign.right,
                            style: GoogleFonts.amiri(
                              fontSize: 18,
                              height: 2.5,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "${ayat.text?.transliteration?.en}",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 15,
                                fontStyle: FontStyle.italic,
                                color: const Color(0xFF009595)),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "${ayat.translation?.id}",
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 15),
                          ),
                          const SizedBox(height: 10),
                        ],
                      );
                    });
              },
            ),
          ),
        ],
      ),
    );
  }
}
