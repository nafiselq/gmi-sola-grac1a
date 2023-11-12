import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gmi_sola_gracia_apps/app/data/models/response_models/ibadah/list_ibadah_model.dart';
import 'package:gmi_sola_gracia_apps/app/data/services/home_services.dart';
import 'package:gmi_sola_gracia_apps/app/data/services/ibadah_services.dart';

import '../../../controllers/page_index_controller.dart';
import '../../../data/models/response_models/home/now_ibadah_home_model.dart';
import '../../utils/fullscreen_dialog_loader.dart';

class IbadahController extends GetxController {
  //TODO: Implement IbadahController

  // Variable
  String textAppBar = 'Daftar Jadwal Ibadah';
  HomeServices homeServices = HomeServices();
  IbadahServices ibadahServices = IbadahServices();
  RxBool isLoadingNowIbadah = true.obs;
  RxBool isFailedNowIbadah = false.obs;
  RxString textIbadahNull = ''.obs;
  Rx<NowIbadahHomeResponse> nowIbadah = NowIbadahHomeResponse().obs;
  final pageIndexController = Get.find<PageIndexController>();
  final ScrollController scrollController = ScrollController();
  RxString limit = '5'.obs;
  RxInt page = 1.obs;
  RxInt lastPage = 0.obs;
  RxBool hasMore = true.obs;
  RxList<ListDataIbadah> listIbadah = <ListDataIbadah>[].obs;
  RxBool isFailedLoadIbadah = true.obs;

  // Function Scrolling
  void onScroll() {
    double maxScroll = scrollController.position.maxScrollExtent;
    double currentScroll = scrollController.position.pixels;
    if (maxScroll == currentScroll && hasMore.value) {
      if (page != lastPage) {
        page.value++;
        getListDaftarIbadah();
      } else if (page == lastPage) {
        hasMore.value = false;
      }
    }
  }

  // Function GetList Daftar Berita
  void getListDaftarIbadah() async {
    FullScreenDialogLoader.showDialog();
    final response =
        await ibadahServices.getDaftarIbadah(limit.value, page.value);

    response.fold((l) {
      FullScreenDialogLoader.cancelDialog();
      return isFailedLoadIbadah.value = true;
    }, (r) {
      FullScreenDialogLoader.cancelDialog();
      isFailedLoadIbadah.value = false;
      lastPage.value = r.lastPage!;
      for (var item in r.data!) {
        listIbadah.add(item);
      }
      return isFailedLoadIbadah.value = false;
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

  @override
  void onInit() {
    scrollController.addListener(onScroll);
    getNowIbadah();
    super.onInit();
  }

  @override
  void onReady() {
    getListDaftarIbadah();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
