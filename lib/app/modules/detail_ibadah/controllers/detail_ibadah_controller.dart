import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:gmi_sola_gracia_apps/app/data/models/response_models/ibadah/detail_ibadah_model.dart';
import 'package:gmi_sola_gracia_apps/app/data/services/home_services.dart';
import 'package:gmi_sola_gracia_apps/app/data/services/ibadah_services.dart';
import 'package:gmi_sola_gracia_apps/app/modules/detail_ibadah/views/widget/widget_modal_bottom_absen.dart';
import 'package:gmi_sola_gracia_apps/app/modules/home/controllers/home_controller.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/models/form_models/form_presence_model.dart';
import '../../custom_widget/custom_modal_bottom_absen.dart';
import '../../utils/adaptive_text.dart';
import '../../utils/fullscreen_dialog_loader.dart';
import '../../utils/theme.dart';

class DetailIbadahController extends GetxController {
  //TODO: Implement DetailIbadahController

  final count = 0.obs;
  String titleHeader = 'Detail Jadwal Ibadah';
  RxString date = ''.obs;
  RxList<ListDataIbadaDetail> listIbadahDetail = <ListDataIbadaDetail>[].obs;
  RxBool isFailedLoadIbadahDetail = true.obs;
  RxBool isLoadingIbadahDetail = true.obs;
  IbadahServices ibadahServices = IbadahServices();
  HomeServices homeServices = HomeServices();
  RxString messageSubmit = ''.obs;

  // Function GetList Daftar Berita
  void getListDaftarIbadah(String date) async {
    final response = await ibadahServices.getIbadahById(date);

    response.fold((l) {
      isLoadingIbadahDetail.value = false;
      return isFailedLoadIbadahDetail.value = true;
    }, (r) {
      isLoadingIbadahDetail.value = false;
      isFailedLoadIbadahDetail.value = false;
      listIbadahDetail.clear();
      for (var item in r.ibadahDetail!) {
        listIbadahDetail.add(item);
      }
      return isFailedLoadIbadahDetail.value = false;
    });
  }

  // Function Modal Absen
  void show(BuildContext context, ListDataIbadaDetail data) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) {
        return WidgetModalBottomAbsen(ibadah: data);
      },
    );
  }

  void submitPresence(ListDataIbadaDetail data) async {
    FullScreenDialogLoader.showDialog();
    Position location = await _determinePosition();

    final response = await homeServices.submitPresence(FormPresenceModel(
        lat: location.latitude.toString(),
        long: location.longitude.toString(),
        scheduleId: data.id.toString()));

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

  bool checkValidDate({String? date, String? startAt, String? endAt}) {
    DateTime currentDate = DateTime.now();
    DateTime targetDate = DateTime.parse(date!);
    final currentDateFormatted = DateFormat('yyyy-MM-dd').format(currentDate);
    final targetDateFormatted = DateFormat('yyyy-MM-dd').format(targetDate);
    TimeOfDay currentTime = TimeOfDay.now();
    TimeOfDay endTime = TimeOfDay(
        hour: int.parse(endAt!.split(':')[0]),
        minute: int.parse(endAt.split(':')[1]));

    if (currentDateFormatted != targetDateFormatted) {
      // Tanggal saat ini lebih besar dari tanggal target
      return false;
    } else if (currentTime.hour >= endTime.hour &&
        currentTime.minute > endTime.minute) {
      return false;
    }
    return true;
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

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
