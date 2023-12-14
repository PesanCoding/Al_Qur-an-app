import 'package:get/get.dart';

import '../controllers/artikel_page_controller.dart';

class ArtikelPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ArtikelPageController>(
      () => ArtikelPageController(),
    );
  }
}
