import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:gmi_sola_gracia_apps/app/modules/ibadah/views/widget/widget_card_ibadah.dart';

import '../../custom_widget/custom_bottom_navigation.dart';
import '../../utils/adaptive_text.dart';
import '../../utils/global_helper.dart';
import '../../utils/theme.dart';
import '../controllers/ibadah_controller.dart';

class IbadahView extends GetView<IbadahController> {
  const IbadahView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          controller.textAppBar,
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
          controller: controller.scrollController,
          children: [
            controller.isLoadingNowIbadah.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    margin: const EdgeInsets.only(left: 23, right: 23, top: 23),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: controller.isLoadingNowIbadah.value
                          ? greyColor
                          : primaryColor,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                          ),
                          width: double.infinity,
                          padding: const EdgeInsets.only(
                            left: 20,
                            right: 20,
                            top: 10,
                          ),
                          child: Text(
                            "Jadwal Ibadah Hari Ini",
                            style: whiteTextStyle.copyWith(
                              fontSize: AdaptiveTextSize()
                                  .getAdaptiveTextSize(context, 13),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Row(
                            children: [
                              Image.asset(
                                "assets/ic-calendar-white.png",
                                width: 20,
                              ),
                              const SizedBox(width: 10),
                              controller.isLoadingNowIbadah.value
                                  ? Text(
                                      "Sedang mengambil data jadwal...",
                                      style: whiteTextStyle.copyWith(
                                        fontSize: AdaptiveTextSize()
                                            .getAdaptiveTextSize(
                                          context,
                                          14,
                                        ),
                                      ),
                                    )
                                  : Text(
                                      controller.isFailedNowIbadah.value
                                          ? "${controller.textIbadahNull}"
                                          : "${GlobalHelper().formatDateFromJson("${controller.nowIbadah.value.data?.date}")} (${controller.nowIbadah.value.data?.startAt} - ${controller.nowIbadah.value.data?.endAt})",
                                      style: whiteTextStyle.copyWith(
                                        fontSize: AdaptiveTextSize()
                                            .getAdaptiveTextSize(
                                          context,
                                          12,
                                        ),
                                      ),
                                    )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 23),
              child: Text(
                "Jadwal Ibadah",
                style: blackTextStyle.copyWith(
                  fontSize: AdaptiveTextSize().getAdaptiveTextSize(context, 14),
                ),
              ),
            ),
            const SizedBox(height: 23),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 23),
              child: Column(
                children: [
                  for (var item in controller.listIbadah)
                    WidgetCardIbadah(ibadah: item),
                ],
              ),
            )
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
                  // controller.pageIndexController.changePage(1);
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
                  controller.pageIndexController.changePage(2);
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
