import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:gmi_sola_gracia_apps/app/modules/utils/global_helper.dart';

import '../../../data/models/response_models/anggota/detail_anggota_model.dart';
import '../../../data/services/anggota_services.dart';

class DetailAnggotaController extends GetxController {
  //TODO: Implement DetailAnggotaController
  RxList<ListDataAnggotaDetail> listAnggotaDetail =
      <ListDataAnggotaDetail>[].obs;
  // var anak = [].obs;
  // var riwayatPelayanan = [].obs;
  RxBool isFailedLoadAnggotaDetail = false.obs;
  RxBool isLoadingAnggotaDetail = true.obs;
  AnggotaServices anggotaServices = AnggotaServices();

  // Function GetList Daftar Berita
  void getAnggotaDetail(int id) async {
    final response = await anggotaServices.getAnggotaById(id);

    response.fold((l) {
      isFailedLoadAnggotaDetail.value = true;
      isLoadingAnggotaDetail.value = false;
      return isFailedLoadAnggotaDetail.value = true;
    }, (r) {
      isFailedLoadAnggotaDetail.value = false;
      isLoadingAnggotaDetail.value = false;
      listAnggotaDetail.clear();
      for (var item in r.data!) {
        listAnggotaDetail.add(item);
        // if (item.title == 'Tanggal Menikah') {
        //   item.value = GlobalHelper().formatDateFromJson(item.value.toString());
        //   // Get.snackbar("value", item.value);
        // }
      }
      return isFailedLoadAnggotaDetail.value = false;
    });
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
}
