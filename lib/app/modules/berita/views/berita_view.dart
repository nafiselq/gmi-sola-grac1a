import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:gmi_sola_gracia_apps/app/modules/berita/views/widget/card_berita_berita.dart';
import 'package:gmi_sola_gracia_apps/app/modules/utils/adaptive_text.dart';
import 'package:gmi_sola_gracia_apps/app/modules/utils/theme.dart';

import '../../custom_widget/custom_bottom_navigation.dart';
import '../controllers/berita_controller.dart';

class BeritaView extends GetView<BeritaController> {
  const BeritaView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Daftar Berita',
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
      body: Obx(
        () => ListView(
          padding: const EdgeInsets.all(24),
          controller: controller.scrollController,
          children: [
            for (var item in controller.listBerita)
              CardBeritaBerita(listDataBerita: item)
          ],
        ),
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
                icon:
                    controller.pageIndexController.pageIndexController.value ==
                            1
                        ? "assets/ic-ibadah-on.png"
                        : "assets/ic-ibadah-off.png",
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
                icon:
                    controller.pageIndexController.pageIndexController.value ==
                            2
                        ? "assets/ic-anggota-off.png"
                        : "assets/ic-anggota-off.png",
                isActive:
                    controller.pageIndexController.pageIndexController.value ==
                            2
                        ? true
                        : false,
                onTap: () {
                  controller.pageIndexController.changePage(2);
                },
              ),
              CustomBottomNavigation(
                nameBar: "Berita",
                icon:
                    controller.pageIndexController.pageIndexController.value ==
                            3
                        ? "assets/ic-berita-on.png"
                        : "assets/ic-berita-off.png",
                isActive:
                    controller.pageIndexController.pageIndexController.value ==
                            3
                        ? true
                        : false,
                onTap: () {
                  // controller.pageIndexController.changePage(3);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
