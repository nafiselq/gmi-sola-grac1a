import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routes/app_pages.dart';

class PageIndexController extends GetxController {
  //TODO: Implement PageIndexController

  //Variable
  final count = 0.obs;
  RxInt pageIndexController = 0.obs;

  //Function
  void changePage(i) async {
    debugPrint("ini i $i");
    switch (i) {
      case 1:
        pageIndexController.value = i;
        return Get.offAllNamed(Routes.IBADAH);
      case 2:
        pageIndexController.value = i;
        return Get.offAllNamed(Routes.ANGGOTA);
      case 3:
        pageIndexController.value = i;
        return Get.offAllNamed(Routes.BERITA);
      default:
        pageIndexController.value = i;
        return Get.offAllNamed(Routes.HOME);
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
