import 'package:app_settings/app_settings.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class ErrorPageController extends GetxController {
  //TODO: Implement ErrorPageController

  final count = 0.obs;

  openGPSServices() {
    // Layanan GPS dinonaktifkan, mendorong pengguna untuk mengaktifkannya.
    SystemNavigator.pop();
    AppSettings.openAppSettings(type: AppSettingsType.location);
  }

  next() {}

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
