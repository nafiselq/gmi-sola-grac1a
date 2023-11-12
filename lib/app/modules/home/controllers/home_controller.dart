import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gmi_sola_gracia_apps/app/controllers/page_index_controller.dart';
import 'package:gmi_sola_gracia_apps/app/data/models/form_models/form_presence_model.dart';
import 'package:gmi_sola_gracia_apps/app/data/models/response_models/auth/response_login_model.dart';
import 'package:gmi_sola_gracia_apps/app/data/models/response_models/home/news_berita_home_model.dart';
import 'package:gmi_sola_gracia_apps/app/data/models/response_models/home/now_ibadah_home_model.dart';
import 'package:gmi_sola_gracia_apps/app/data/services/home_services.dart';
import 'package:gmi_sola_gracia_apps/app/modules/custom_widget/custom_modal_bottom_absen.dart';
import 'package:gmi_sola_gracia_apps/app/modules/utils/fullscreen_dialog_loader.dart';
import 'package:gmi_sola_gracia_apps/app/modules/utils/key_value.dart';
import 'package:gmi_sola_gracia_apps/app/modules/utils/listen_notification.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/models/response_models/profile/profile_model.dart';
import '../../../data/services/profile_services.dart';
import '../../utils/adaptive_text.dart';
import '../../utils/theme.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  // Services
  HomeServices homeServices = HomeServices();

  // Variable
  GetStorage box = GetStorage();
  final pageIndexController = Get.find<PageIndexController>();
  Rx<DataProfile> user = DataProfile().obs;
  RxList<DataBerita> listBerita = <DataBerita>[].obs;
  Rx<NowIbadahHomeResponse> nowIbadah = NowIbadahHomeResponse().obs;
  RxString textIbadahNull = ''.obs;
  RxBool isFailedDaftarBerita = false.obs;
  RxBool isFailedNowIbadah = false.obs;
  RxBool isLoadingNowIbadah = true.obs;
  RxString messageSubmit = ''.obs;

  ProfileServices profileServices = ProfileServices();
  RxBool isFailedProfile = false.obs;
  RxBool isLoadingProfile = true.obs;

  // Function GetList Daftar Berita
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
      user.value = r.dataProfile!;
      return isFailedProfile.value = false;
    });
  }

  // Function GetList Daftar Berita
  void getListDaftarBerita() async {
    listBerita.clear();
    FullScreenDialogLoader.showDialog();
    final response = await homeServices.getDaftarBerita("5", "1");

    response.fold((l) {
      FullScreenDialogLoader.cancelDialog();
      return isFailedDaftarBerita.value = true;
    }, (r) {
      FullScreenDialogLoader.cancelDialog();
      isFailedDaftarBerita.value = false;
      for (var item in r.data!) {
        listBerita.add(item);
      }
      return isFailedDaftarBerita.value = false;
    });
  }

  // Function GetList Ibadah Sekarang
  void getNowIbadah() async {
    final response = await homeServices.getIbadahNow();

    response.fold((l) {
      isLoadingNowIbadah.value = false;
      isFailedNowIbadah.value = true;
      textIbadahNull.value = l.message.toString();
      return;
    }, (r) {
      isLoadingNowIbadah.value = false;
      isFailedNowIbadah.value = false;
      nowIbadah.value = r;
      return;
    });
  }

  // Function Refresh Halaman
  Future<void> onRefresh() async {
    getDataProfile();
    getNowIbadah();
    getListDaftarBerita();
  }

  // Function Modal Absen
  void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) {
        return CustomModalBottomAbsen(ibadah: nowIbadah.value.data);
      },
    );
  }

  //Function modal
  void showModalAlert(BuildContext context, bool isSuccess, String text) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
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
                          Get.back();
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
                  isSuccess ? 'Absen Berhasil' : 'Absen Gagal',
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
        );
      },
    );
  }

  void submitPresence() async {
    FullScreenDialogLoader.showDialog();
    Position location = await _determinePosition();

    final response = await homeServices.submitPresence(FormPresenceModel(
        lat: location.latitude.toString(),
        long: location.longitude.toString(),
        scheduleId: nowIbadah.value.data?.id.toString()));

    response.fold((l) {
      FullScreenDialogLoader.cancelDialog();
      Get.back();
      showModalAlert(Get.context!, false, l.message.toString());
      return messageSubmit.value = l.message.toString();
    }, (r) {
      FullScreenDialogLoader.cancelDialog();
      Get.back();
      showModalAlert(Get.context!, true, r.message.toString());
      return messageSubmit.value = r.message.toString();
    });
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  redirectLink(String url) {
    final Uri urlWebview = Uri.parse(url);
    _launchUrl(urlWebview);
  }

  Future<void> _launchUrl(url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  final count = 0.obs;
  @override
  void onInit() {
    ConfigureNotification.configureSelectNotificationForeground();
    listenNotif();
    super.onInit();
  }

  @override
  void onReady() {
    getDataProfile();
    getNowIbadah();
    getListDaftarBerita();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
