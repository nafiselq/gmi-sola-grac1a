import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:gmi_sola_gracia_apps/app/modules/anggota/views/widget/widget_card_anggota.dart';
import 'package:gmi_sola_gracia_apps/app/modules/informasi_pribadi/controllers/informasi_pribadi_controller.dart';
import 'package:gmi_sola_gracia_apps/app/modules/profile/views/widget/widget_card_profile.dart';
import 'package:gmi_sola_gracia_apps/app/routes/app_pages.dart';

import '../../edit_profile/controllers/edit_profile_controller.dart';
import '../../utils/adaptive_text.dart';
import '../../utils/theme.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
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
          ListView(
            children: [
              const SizedBox(height: 120),
              // WidgetCardAnggota(anggota: anggota)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 21),
                child: Obx(
                  () => controller.isLoadingProfile.value
                      ? const SizedBox()
                      : WidgetCardProfile(
                          dataProfile:
                              controller.profileResponse.value.dataProfile!,
                        ),
                ),
              ),
              const SizedBox(height: 45),
              GestureDetector(
                onTap: () {
                  final informasiPribadiC =
                      Get.put(InformasiPribadiController());
                  informasiPribadiC.dataProfile.value =
                      controller.profileResponse.value.dataProfile!;
                  Get.toNamed(Routes.INFORMASI_PRIBADI);
                },
                child: Container(
                  padding: const EdgeInsets.only(bottom: 26),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: blackColor.withOpacity(0.5)),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 21),
                    child: Row(
                      children: [
                        Image.asset("assets/ic-informasi-data.png", width: 25),
                        const SizedBox(width: 15),
                        Text("Informasi Data Pribadi"),
                        const Spacer(),
                        Icon(Icons.arrow_forward_ios, size: 20),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 26),
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.HISTORY_PRESENCE);
                },
                child: Container(
                  padding: const EdgeInsets.only(bottom: 26),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: blackColor.withOpacity(0.5)),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 21),
                    child: Row(
                      children: [
                        Image.asset("assets/ic-times.png", width: 25),
                        const SizedBox(width: 15),
                        Text("Riwayat Kehadiran"),
                        const Spacer(),
                        Icon(Icons.arrow_forward_ios, size: 20),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 26),
              GestureDetector(
                onTap: () {
                  final editProfileC = Get.put(EditProfileController());
                  editProfileC.dataProfile.value =
                      controller.profileResponse.value.dataProfile!;
                  Get.toNamed(Routes.EDIT_PROFILE);
                },
                child: Container(
                  padding: const EdgeInsets.only(bottom: 26),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: blackColor.withOpacity(0.5)),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 21),
                    child: Row(
                      children: [
                        Image.asset("assets/ic-akun.png", width: 25),
                        const SizedBox(width: 15),
                        Text("Informasi Akun"),
                        const Spacer(),
                        Icon(Icons.arrow_forward_ios, size: 20),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 26),
              GestureDetector(
                onTap: () {
                  controller.logout();
                },
                child: Container(
                  padding: const EdgeInsets.only(bottom: 26),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 21),
                    child: Row(
                      children: [
                        Image.asset("assets/ic-logout.png", width: 25),
                        const SizedBox(width: 15),
                        Text("Keluar"),
                        const Spacer(),
                        Icon(Icons.arrow_forward_ios, size: 20),
                      ],
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
