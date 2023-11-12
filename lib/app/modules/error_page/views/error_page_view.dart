import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:gmi_sola_gracia_apps/app/modules/custom_widget/custom_widget_button.dart';
import 'package:gmi_sola_gracia_apps/app/modules/utils/adaptive_text.dart';
import 'package:gmi_sola_gracia_apps/app/modules/utils/theme.dart';
import 'package:gmi_sola_gracia_apps/app/routes/app_pages.dart';

import '../controllers/error_page_controller.dart';

class ErrorPageView extends GetView<ErrorPageController> {
  const ErrorPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/ic-failed.png",
              width: 100,
            ),
            const SizedBox(height: 20),
            Text(
              "Ooops!!!",
              style: blackTextStyle.copyWith(
                fontSize: AdaptiveTextSize().getAdaptiveTextSize(context, 20),
                fontWeight: black,
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                "Mohon aktifkan GPS kamu terlebih dahulu atau klik button dibawah untuk mengaktifkan gps kamu",
                textAlign: TextAlign.center,
                style: greyTextStyle.copyWith(
                  fontSize: AdaptiveTextSize().getAdaptiveTextSize(context, 12),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: CustomWidgetButton(
                onPress: () {
                  controller.openGPSServices();
                },
                text: 'Aktifkan GPS',
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: CustomWidgetButton(
                isValid: false,
                onPress: () {
                  controller.next();
                },
                text: 'Muat Ulang Halaman',
              ),
            )
          ],
        ),
      ),
    );
  }
}
