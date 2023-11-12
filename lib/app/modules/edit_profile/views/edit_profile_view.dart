import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:gmi_sola_gracia_apps/app/modules/custom_widget/custom_widget_button.dart';

import '../../utils/adaptive_text.dart';
import '../../utils/theme.dart';
import '../controllers/edit_profile_controller.dart';

class EditProfileView extends GetView<EditProfileController> {
  const EditProfileView({Key? key}) : super(key: key);
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
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
        children: [
          Text(
            "Informasi Akun",
            style: blackTextStyle.copyWith(
              fontSize: AdaptiveTextSize().getAdaptiveTextSize(context, 16),
              fontWeight: black,
            ),
          ),
          const SizedBox(height: 20),
          Obx(
            () => Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      controller.dataProfile.value.biodataProfile?.photo == null
                          ? Image.asset(
                              "assets/ic-dummy-profile-anggota.png",
                              width: 50,
                            )
                          : controller.selectedImage.value != null
                              ? Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: greyColor,
                                    image:
                                        controller.selectedImage.value == null
                                            ? null
                                            : DecorationImage(
                                                image: FileImage(
                                                  File(controller.selectedImage
                                                      .value!.path),
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                  ),
                                  child: const SizedBox())
                              : Container(
                                  width: 60,
                                  height: 60,
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    // color: greyColor.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(50),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        "${controller.dataProfile.value.biodataProfile?.photo}",
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  )),
                      const SizedBox(width: 25),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              controller.changePicture();
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 9, vertical: 7),
                              decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Text(
                                "Upload Foto",
                                style: whiteTextStyle.copyWith(fontSize: 12),
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "Format JPG, PNG. Maks. 3 MB",
                            style: greyTextStyle.copyWith(
                              fontSize: AdaptiveTextSize()
                                  .getAdaptiveTextSize(context, 10),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 17),
                  Text(
                    "Username",
                    style: blackTextStyle.copyWith(
                      fontSize:
                          AdaptiveTextSize().getAdaptiveTextSize(context, 12),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 14),
                    margin: const EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: greyColor.withOpacity(0.2),
                    ),
                    child: TextFormField(
                      controller: controller.usernameC,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 17),
                  Text(
                    "Password",
                    style: blackTextStyle.copyWith(
                      fontSize:
                          AdaptiveTextSize().getAdaptiveTextSize(context, 12),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 14),
                    margin: const EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: greyColor.withOpacity(0.2),
                    ),
                    child: TextFormField(
                      controller: controller.passwordC,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: '**********',
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "*) Kosongkan jika tidak ingin mengubah",
                    style: blackTextStyle.copyWith(
                      fontSize:
                          AdaptiveTextSize().getAdaptiveTextSize(context, 10),
                    ),
                  ),
                  const SizedBox(height: 25),
                  CustomWidgetButton(
                    onPress: () {
                      controller.updateData();
                    },
                    text: 'Simpan',
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
