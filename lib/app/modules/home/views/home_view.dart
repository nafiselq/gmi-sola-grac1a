import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:gmi_sola_gracia_apps/app/modules/home/views/widget/card_berita_home.dart';
import 'package:gmi_sola_gracia_apps/app/modules/utils/adaptive_text.dart';
import 'package:gmi_sola_gracia_apps/app/modules/utils/theme.dart';
import 'package:gmi_sola_gracia_apps/app/routes/app_pages.dart';

import '../../custom_widget/custom_bottom_navigation.dart';
import '../../utils/global_helper.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => RefreshIndicator(
          onRefresh: () => controller.onRefresh(),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Stack(
                children: [
                  Image.asset(
                    "assets/bg-header-home.png",
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    margin: const EdgeInsets.symmetric(vertical: 30),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Image.asset(
                              "assets/logo.png",
                              width: 20,
                            ),
                            Container(
                              width: 100,
                              margin: const EdgeInsets.only(top: 10),
                              child: Text(
                                "GMI SOLA GRACIA TANGERANG",
                                style: whiteTextStyle.copyWith(
                                    fontSize: 9, fontWeight: black),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Selamat Datang",
                              style: whiteTextStyle.copyWith(
                                fontSize:
                                    AdaptiveTextSize().getAdaptiveTextSize(
                                  context,
                                  16,
                                ),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "${controller.user.value.biodataProfile?.name}",
                              style: whiteTextStyle.copyWith(
                                  fontSize: 12, fontWeight: black),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.PROFILE);
                          },
                          child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                // color: greyColor.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(50),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    "${controller.user.value.biodataProfile?.photo}",
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              )),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin:
                        const EdgeInsets.only(left: 23, right: 23, top: 110),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: controller.isFailedNowIbadah.value ||
                              controller.isLoadingNowIbadah.value
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
                            color: whiteColor,
                          ),
                          width: double.infinity,
                          padding: const EdgeInsets.only(
                            left: 20,
                            right: 20,
                            top: 10,
                          ),
                          child: Text(
                            "Jadwal Ibadah Hari Ini",
                            style: greyTextStyle.copyWith(
                              fontSize: AdaptiveTextSize()
                                  .getAdaptiveTextSize(context, 13),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: whiteColor,
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Row(
                            children: [
                              Image.asset(
                                "assets/ic-calendar.png",
                                width: 20,
                              ),
                              const SizedBox(width: 10),
                              controller.isLoadingNowIbadah.value
                                  ? Text(
                                      "Sedang mengambil data jadwal...",
                                      style: blackTextStyle.copyWith(
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
                                      style: blackTextStyle.copyWith(
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
                        GestureDetector(
                          onTap: () {
                            if (!controller.isFailedNowIbadah.value)
                              controller.show(context);
                          },
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 11.5),
                            child: Center(
                              child: Text(
                                "ABSEN SEKARANG",
                                style: whiteTextStyle.copyWith(
                                  fontSize: AdaptiveTextSize()
                                      .getAdaptiveTextSize(context, 12),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 26),
                padding: const EdgeInsets.symmetric(horizontal: 23),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Daftar Berita",
                          style: blackTextStyle.copyWith(
                            fontSize: AdaptiveTextSize().getAdaptiveTextSize(
                              context,
                              16,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.pageIndexController.pageIndexController
                                .value = 3;
                            Get.offAllNamed(Routes.BERITA);
                          },
                          child: Text(
                            "Lihat Semua",
                            style: greyTextStyle.copyWith(
                              fontSize: AdaptiveTextSize().getAdaptiveTextSize(
                                context,
                                14,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    for (var item in controller.listBerita)
                      CardBeritaHome(dataBerita: item)
                  ],
                ),
              ),
            ],
          ),
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
                onTap: () {},
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
