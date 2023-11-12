import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gmi_sola_gracia_apps/app/data/models/response_models/berita/list_berita_model.dart';
import 'package:gmi_sola_gracia_apps/app/data/services/berita_services.dart';

import '../../../controllers/page_index_controller.dart';
import '../../utils/fullscreen_dialog_loader.dart';

class BeritaController extends GetxController {
  //TODO: Implement BeritaController

  // Variable
  final ScrollController scrollController = ScrollController();
  RxString limit = '5'.obs;
  RxInt page = 1.obs;
  RxInt lastPage = 0.obs;
  RxBool hasMore = true.obs;
  RxList<ListDataBerita> listBerita = <ListDataBerita>[].obs;
  RxBool isFailedLoadBerita = false.obs;
  final pageIndexController = Get.find<PageIndexController>();

  //Services
  BeritaServices beritaServices = BeritaServices();

  // Function Scrolling
  void onScroll() {
    double maxScroll = scrollController.position.maxScrollExtent;
    double currentScroll = scrollController.position.pixels;
    if (maxScroll == currentScroll && hasMore.value) {
      if (page != lastPage) {
        page.value++;
        getListDaftarBerita();
      } else if (page == lastPage) {
        hasMore.value = false;
      }
    }
  }

  // Function GetList Daftar Berita
  void getListDaftarBerita() async {
    FullScreenDialogLoader.showDialog();
    final response =
        await beritaServices.getDaftarBerita(limit.value, page.value);

    response.fold((l) {
      FullScreenDialogLoader.cancelDialog();
      return isFailedLoadBerita.value = true;
    }, (r) {
      FullScreenDialogLoader.cancelDialog();
      isFailedLoadBerita.value = false;
      lastPage.value = r.lastPage!;
      for (var item in r.data!) {
        listBerita.add(item);
      }
      return isFailedLoadBerita.value = false;
    });
  }

  @override
  void onInit() {
    scrollController.addListener(onScroll);
    super.onInit();
  }

  @override
  void onReady() {
    getListDaftarBerita();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
