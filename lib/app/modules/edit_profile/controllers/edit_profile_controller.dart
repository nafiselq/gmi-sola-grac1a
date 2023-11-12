import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gmi_sola_gracia_apps/app/data/models/response_models/profile/profile_model.dart';
import 'package:gmi_sola_gracia_apps/app/data/services/profile_services.dart';
import 'package:gmi_sola_gracia_apps/app/modules/utils/fullscreen_dialog_loader.dart';
import 'package:gmi_sola_gracia_apps/app/routes/app_pages.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart' as dio;

import '../../utils/adaptive_text.dart';
import '../../utils/global_helper.dart';
import '../../utils/theme.dart';

class EditProfileController extends GetxController {
  //TODO: Implement EditProfileController

  final count = 0.obs;
  String textHeader = 'Edit Profile';
  Rx<DataProfile> dataProfile = DataProfile().obs;
  TextEditingController usernameC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  ProfileServices profileServices = ProfileServices();
  RxBool isloadingProfile = false.obs;
  RxBool isFailedProfile = false.obs;
  Rx<ProfileResponse> profileResponse = ProfileResponse().obs;

  Rx<XFile?> selectedImage = Rx<XFile?>(null);

  void changePicture() async {
    final image = await GlobalHelper().selectImage();
    selectedImage.value = XFile(image!.path);
    update();
  }

  void updateData() async {
    try {
      FullScreenDialogLoader.showDialog();
      String fileName = selectedImage.value!.path.split('/').last;
      final formData = dio.FormData.fromMap({
        "_method": "PUT",
        "username": usernameC.text,
        "password": passwordC.text,
        "photo": await dio.MultipartFile.fromFile(selectedImage.value!.path,
            filename: fileName)
      });

      final response = await profileServices.updateAccount(formData);

      response.fold((l) {
        FullScreenDialogLoader.cancelDialog();
        Get.snackbar("Oops", l.message.toString());
      }, (r) {
        FullScreenDialogLoader.cancelDialog();
        getDataProfile();
      });
    } catch (e) {
      FullScreenDialogLoader.cancelDialog();
      debugPrint("ini adalah catch e : $e");
      showModalAlert(
          Get.context!, false, "Kamu tidak merubah data informasi akun apapun");
    }
  }

  void getDataProfile() async {
    FullScreenDialogLoader.showDialog();
    final response = await profileServices.getProfile();

    response.fold((l) {
      FullScreenDialogLoader.cancelDialog();
      isloadingProfile.value = false;
      return isFailedProfile.value = true;
    }, (r) {
      FullScreenDialogLoader.cancelDialog();
      isloadingProfile.value = false;
      isFailedProfile.value = false;
      profileResponse.value = r;
      showModalAlert(Get.context!, true, r.message.toString());
      return isFailedProfile.value = false;
    });
  }

  void showModalAlert(BuildContext context, bool isSuccess, String text) {
    showDialog(
      barrierDismissible: false,
      useSafeArea: false,
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async {
            Get.offNamed(Routes.SPLASH_SCREEN);
            Get.toNamed(Routes.HOME);
            Get.toNamed(Routes.PROFILE);
            return true;
          },
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            // title: Text('Judul Dialog'), // Gantilah dengan judul yang sesuai
            content: SizedBox(
              height: 250,
              width: double.infinity,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            Get.offNamed(Routes.SPLASH_SCREEN);
                            Get.toNamed(Routes.HOME);
                            Get.toNamed(Routes.PROFILE); 
                          },
                          child: const Icon(Icons.close, size: 25),
                        ),
                      ],
                    ),
                  ),
                  Image.asset(
                      isSuccess
                          ? 'assets/ic-success.png'
                          : 'assets/ic-failed.png',
                      width: 60),
                  const SizedBox(height: 30),
                  Text(
                    isSuccess ? 'Yeeyyy' : 'Gagal',
                    style: blackTextStyle.copyWith(
                      fontSize: AdaptiveTextSize()
                          .getAdaptiveTextSize(Get.context!, 24),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    text,
                    textAlign: TextAlign.center,
                    style: greyTextStyle.copyWith(
                      fontSize: AdaptiveTextSize()
                          .getAdaptiveTextSize(Get.context!, 12),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    usernameC.text = dataProfile.value.username.toString();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
