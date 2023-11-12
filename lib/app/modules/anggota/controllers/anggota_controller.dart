import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gmi_sola_gracia_apps/app/data/models/response_models/anggota/list_anggota_model.dart';
import 'package:gmi_sola_gracia_apps/app/data/services/anggota_services.dart';

import '../../../controllers/page_index_controller.dart';
import '../../utils/fullscreen_dialog_loader.dart';

class AnggotaController extends GetxController {
  //TODO: Implement AnggotaController

  final pageIndexController = Get.find<PageIndexController>();
  String textHeader = 'Anggota';
  ScrollController scrollController = ScrollController();
  RxString limit = '5'.obs;
  RxInt page = 1.obs;
  RxInt lastPage = 0.obs;
  RxBool hasMore = true.obs;
  RxList<ListDataAnggota> listAnggota = <ListDataAnggota>[].obs;
  RxBool isFailedLoadAnggota = true.obs;
  AnggotaServices anggotaServices = AnggotaServices();

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
        await anggotaServices.getListAnggota(limit.value, page.value);

    response.fold((l) {
      FullScreenDialogLoader.cancelDialog();
      return isFailedLoadAnggota.value = true;
    }, (r) {
      FullScreenDialogLoader.cancelDialog();
      isFailedLoadAnggota.value = false;
      lastPage.value = r.lastPage!;
      for (var item in r.data!) {
        listAnggota.add(item);
      }
      return isFailedLoadAnggota.value = false;
    });
  }

  final count = 0.obs;
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
