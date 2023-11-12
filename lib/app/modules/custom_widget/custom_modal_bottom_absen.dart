import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gmi_sola_gracia_apps/app/modules/custom_widget/custom_widget_button.dart';
import 'package:gmi_sola_gracia_apps/app/modules/home/controllers/home_controller.dart';
import 'package:gmi_sola_gracia_apps/app/modules/utils/adaptive_text.dart';
import 'package:gmi_sola_gracia_apps/app/modules/utils/theme.dart';

import '../../data/models/response_models/home/now_ibadah_home_model.dart';
import '../utils/global_helper.dart';

class CustomModalBottomAbsen extends StatelessWidget {
  const CustomModalBottomAbsen({super.key, required this.ibadah});

  final Ibadah? ibadah;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 18),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(),
                  const SizedBox(width: 40),
                  Text(
                    "Detail Ibadah",
                    style: blackTextStyle.copyWith(
                      fontSize:
                          AdaptiveTextSize().getAdaptiveTextSize(context, 14),
                      fontWeight: black,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(Icons.close, size: 25)),
                  const SizedBox(width: 20),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                final homeC = Get.find<HomeController>();
                homeC.redirectLink("${ibadah?.youtube}");
              },
              child: Stack(
                children: [
                  Image.network("${ibadah?.thumbnail}"),
                  Container(
                    margin: const EdgeInsets.only(top: 80),
                    child: Center(
                      child: Image.asset("assets/ic-play.png", width: 50),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${ibadah?.title}",
                    style: blackTextStyle.copyWith(
                      fontSize:
                          AdaptiveTextSize().getAdaptiveTextSize(context, 20),
                      fontWeight: black,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "${GlobalHelper().formatDateFromJson("${ibadah?.date}")}, ${ibadah?.startAt} sd. ${ibadah?.endAt}",
                    style: greyTextStyle.copyWith(
                      fontSize:
                          AdaptiveTextSize().getAdaptiveTextSize(context, 14),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 23),
              child: CustomWidgetButton(
                  onPress: () {
                    final homeC = Get.find<HomeController>();
                    homeC.submitPresence();
                  },
                  text: 'Absen sekarang'),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
