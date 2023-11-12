import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gmi_sola_gracia_apps/app/data/models/response_models/profile/profile_model.dart';
import 'package:gmi_sola_gracia_apps/app/data/services/profile_services.dart';
import 'package:gmi_sola_gracia_apps/app/routes/app_pages.dart';

import '../../utils/fullscreen_dialog_loader.dart';

class ProfileController extends GetxController {
  //TODO: Implement ProfileController

  final count = 0.obs;
  String textHeader = 'My Profile';
  final box = GetStorage();
  ProfileServices profileServices = ProfileServices();
  Rx<ProfileResponse> profileResponse = ProfileResponse().obs;
  RxBool isFailedProfile = false.obs;
  RxBool isLoadingProfile = true.obs;

  // Function Get Data Profile
  void getDataProfile() async {
    FullScreenDialogLoader.showDialog();
    final response = await profileServices.getProfile();

    response.fold((l) {
      FullScreenDialogLoader.cancelDialog();
      isLoadingProfile.value = false;
      return isFailedProfile.value = true;
    }, (r) {
      FullScreenDialogLoader.cancelDialog();
      isLoadingProfile.value = false;
      isFailedProfile.value = false;
      profileResponse.value = r;
      return isFailedProfile.value = false;
    });
  }

  void logout() {
    box.erase();
    Get.offAllNamed(Routes.LOGIN);
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    getDataProfile();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
