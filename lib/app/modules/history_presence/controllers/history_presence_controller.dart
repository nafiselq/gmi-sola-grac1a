import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gmi_sola_gracia_apps/app/data/models/response_models/profile/list_history_presence_model.dart';
import 'package:gmi_sola_gracia_apps/app/data/services/profile_services.dart';

import '../../utils/fullscreen_dialog_loader.dart';

class HistoryPresenceController extends GetxController {
  //TODO: Implement HistoryPresenceController

  final count = 0.obs;

  ScrollController scrollController = ScrollController();
  String textHeader = 'Riwayat Absen';
  RxString limit = '5'.obs;
  RxInt page = 1.obs;
  RxInt lastPage = 0.obs;
  RxBool hasMore = true.obs;
  RxList<ListHistoryPresence> listHistoryPresence = <ListHistoryPresence>[].obs;
  RxBool isFailedLoadAnggota = true.obs;
  ProfileServices profileServices = ProfileServices();

  // Function Scrolling
  void onScroll() {
    double maxScroll = scrollController.position.maxScrollExtent;
    double currentScroll = scrollController.position.pixels;
    if (maxScroll == currentScroll && hasMore.value) {
      if (page != lastPage) {
        page.value++;
        getListDaftarAnggota();
      } else if (page == lastPage) {
        hasMore.value = false;
      }
    }
  }

  // Function GetList Daftar Berita
  void getListDaftarAnggota() async {
    FullScreenDialogLoader.showDialog();
    final response =
        await profileServices.getListHistoryPresence(limit.value, page.value);

    response.fold((l) {
      FullScreenDialogLoader.cancelDialog();
      return isFailedLoadAnggota.value = true;
    }, (r) {
      FullScreenDialogLoader.cancelDialog();
      isFailedLoadAnggota.value = false;
      lastPage.value = r.lastPage!;
      for (var item in r.data!) {
        listHistoryPresence.add(item);
      }
      return isFailedLoadAnggota.value = false;
    });
  }

  @override
  void onInit() {
    scrollController.addListener(onScroll);
    super.onInit();
  }

  @override
  void onReady() {
    getListDaftarAnggota();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
