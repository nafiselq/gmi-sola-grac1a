import 'package:get/get.dart';
import 'package:gmi_sola_gracia_apps/app/data/models/response_models/berita/detail_berita_model.dart';
import 'package:gmi_sola_gracia_apps/app/data/services/berita_services.dart';

import '../../utils/fullscreen_dialog_loader.dart';

class DetailBeritaController extends GetxController {
  //TODO: Implement DetailBeritaController

  // Variable
  Rx<DetailBerita> detailBerita = DetailBerita().obs;
  RxBool isFailedLoadBerita = false.obs;
  RxBool isLoadingBerita = false.obs;

  // Services
  BeritaServices beritaServices = BeritaServices();

  // Function Get Berita Detail
  void getDetailBerita(int? beritaId) async {
    isLoadingBerita.value = true;
    // listBerita.clear();
    // FullScreenDialogLoader.showDialog();
    final response = await beritaServices.getBeritabyId(beritaId);

    response.fold((l) {
      // FullScreenDialogLoader.cancelDialog();
      isLoadingBerita.value = false;
      return isFailedLoadBerita.value = true;
    }, (r) {
      // FullScreenDialogLoader.cancelDialog();
      detailBerita.value = r.beritaDetail!;
      isFailedLoadBerita.value = false;
      isLoadingBerita.value = false;
      return isFailedLoadBerita.value = false;
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
