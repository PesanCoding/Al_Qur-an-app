import 'package:alquran/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(
    GetMaterialApp(
      title: "My Al-Qur'an",
      initialRoute: Routes.INTRODUCTION,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    ),
  );
}
