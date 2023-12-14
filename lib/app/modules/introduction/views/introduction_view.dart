import 'package:alquran/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import '../controllers/introduction_controller.dart';

class IntroductionView extends GetView<IntroductionController> {
  const IntroductionView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "My Al-Qur'an",
              style: GoogleFonts.poppins(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF009595)),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                "Sesibuk itukah kamu sampai belum membaca Al - Qur'an",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(fontSize: 16),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: 370,
              height: 370,
              child: Lottie.asset("assets/svgs/screen_intro.json"),
            ),
            const SizedBox(height: 40),
            Positioned(
              left: 0,
              bottom: 20,
              right: 0,
              child: Center(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => Get.offAllNamed(Routes.HOME),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 14),
                    decoration: BoxDecoration(
                        color: const Color(0xFF009595),
                        borderRadius: BorderRadius.circular(30)),
                    child: Text(
                      'Get Started',
                      style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
