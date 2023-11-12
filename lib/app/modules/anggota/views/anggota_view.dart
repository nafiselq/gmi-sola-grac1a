import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:gmi_sola_gracia_apps/app/modules/anggota/views/widget/widget_card_anggota.dart';

import '../../custom_widget/custom_bottom_navigation.dart';
import '../../utils/adaptive_text.dart';
import '../../utils/theme.dart';
import '../controllers/anggota_controller.dart';

class AnggotaView extends GetView<AnggotaController> {
  const AnggotaView({Key? key}) : super(key: key);
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
                for (var item in controller.listAnggota)
                  WidgetCardAnggota(anggota: item)
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: Obx(
        () => Container(
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          child: Row(
            children: [
              CustomBottomNavigation(
                nameBar: "Beranda",
                icon:
                    controller.pageIndexController.pageIndexController.value ==
                            0
                        ? "assets/ic-home-on.png"
                        : "assets/ic-home-off.png",
                isActive:
                    controller.pageIndexController.pageIndexController.value ==
                            0
                        ? true
                        : false,
                onTap: () {
                  controller.pageIndexController.changePage(0);
                },
              ),
              CustomBottomNavigation(
                nameBar: "Ibadah",
                icon: "assets/ic-ibadah-off.png",
                isActive:
                    controller.pageIndexController.pageIndexController.value ==
                            1
                        ? true
                        : false,
                onTap: () {
                  controller.pageIndexController.changePage(1);
                },
              ),
              CustomBottomNavigation(
                nameBar: "Anggota",
                icon: "assets/ic-anggota-off.png",
                isActive:
                    controller.pageIndexController.pageIndexController.value ==
                            2
                        ? true
                        : false,
                onTap: () {
                  // controller.pageIndexController.changePage(2);
                },
              ),
              CustomBottomNavigation(
                nameBar: "Berita",
                icon: "assets/ic-berita-off.png",
                isActive:
                    controller.pageIndexController.pageIndexController.value ==
                            3
                        ? true
                        : false,
                onTap: () {
                  controller.pageIndexController.changePage(3);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
