import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gmi_sola_gracia_apps/app/modules/utils/adaptive_text.dart';
import 'package:gmi_sola_gracia_apps/app/modules/utils/theme.dart';

class FullScreenDialogLoader {
  static void showDialog() {
    Get.dialog(
      WillPopScope(
        child: const Center(child: CircularProgressIndicator()),
        onWillPop: () => Future.value(false),
      ),
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.7),
      useSafeArea: true,
    );
  }

  static void showAlertDialog(bool isSuccess, String text) {
    Get.dialog(
      WillPopScope(
        child: Container(
          color: whiteColor,
          child: Column(
            children: [
              Image.asset(
                  isSuccess ? 'assets/ic-success.png' : 'assets/ic-failed.png'),
              const SizedBox(height: 30),
              Text(
                isSuccess ? 'Absen Berhasil' : 'Absen Gagagal',
                style: blackTextStyle.copyWith(
                  fontSize:
                      AdaptiveTextSize().getAdaptiveTextSize(Get.context!, 24),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                text,
                style: greyTextStyle.copyWith(
                  fontSize:
                      AdaptiveTextSize().getAdaptiveTextSize(Get.context!, 12),
                ),
              )
            ],
          ),
        ),
        onWillPop: () => Future.value(false),
      ),
    );
  }

  static void showDialogSuccess() {
    Get.dialog(
      WillPopScope(
        child: const Center(
          child: Icon(Icons.check),
        ),
        onWillPop: () => Future.value(false),
      ),
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.7),
      useSafeArea: true,
    );
  }

  static void cancelDialog() {
    if (Get.isDialogOpen!) {
      Get.back();
    }
  }
}
