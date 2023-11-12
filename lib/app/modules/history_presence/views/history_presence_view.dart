import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:gmi_sola_gracia_apps/app/modules/history_presence/views/widget/widget_card_history.dart';

import '../../utils/adaptive_text.dart';
import '../../utils/theme.dart';
import '../controllers/history_presence_controller.dart';

class HistoryPresenceView extends GetView<HistoryPresenceController> {
  const HistoryPresenceView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          controller.textHeader,
          style: blackTextStyle.copyWith(
            fontSize: AdaptiveTextSize().getAdaptiveTextSize(context, 15),
            fontWeight: semiBold,
          ),
        ),
        backgroundColor: whiteColor,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: blackColor,
        ),
      ),
      body: Stack(
        children: [
          Image.asset(
            "assets/bg-header-home.png",
          ),
          Positioned(
            top: 40,
            left: 160,
            child: Image.asset(
              "assets/logo-with-text.png",
              width: 68,
            ),
          ),
          Obx(
            () => ListView(
              controller: controller.scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 21),
              children: [
                const SizedBox(height: 105),
                for (var item in controller.listHistoryPresence)
                  WidgetCardHistory(presence: item)
              ],
            ),
          )
        ],
      ),
    );
  }
}
