import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../routes/app_pages.dart';
import '../../utils/key_value.dart';

class SplashScreenController extends GetxController {
  //TODO: Implement SplashScreenController

  // Variable
  String? assetLogo = 'assets/logo.png';
  GetStorage box = GetStorage();

  final count = 0.obs;

  Future<void> requestLocationPermission() async {
    bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();

    if (isServiceEnabled) {
      LocationPermission permission = await Geolocator.requestPermission();
      debugPrint("ini permission : $permission");
      if (permission == LocationPermission.denied) {
        // The user denied access to their location
        return Get.offAllNamed(Routes.ERROR_PAGE);
      } else if (permission == LocationPermission.always) {
        // Permission granted with always access
        return nextPage();
      } else if (permission == LocationPermission.whileInUse) {
        // Permission granted with while in use access
        return nextPage();
      }
      // nextPage();
    } else {
      Get.offAllNamed(Routes.ERROR_PAGE);
    }
  }

  Future<LocationPermission> checkLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    return permission;
  }

  Future<void> handleLocationPermission() async {
    LocationPermission permission = await checkLocationPermission();
    bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();

    if (permission == LocationPermission.denied) {
      Get.offAllNamed(Routes.ERROR_PAGE);
    } else if (!isServiceEnabled) {
      Get.offAllNamed(Routes.ERROR_PAGE);
    }
  }

  //Hanlde Route Session Login
  nextPage() {
    if (box.read(KeyValue.keyToken) != null) {
      // fetchNewCurrentUser();
      return Get.offAllNamed(Routes.HOME);
    } else {
      return Get.offAllNamed(Routes.LOGIN);
    }
  }

  @override
  void onInit() {
    // handleLocationPermission();
    requestLocationPermission();
    // Timer(Duration(seconds: 2), () {
    //   nextPage();
    // });
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
