import 'package:get/get.dart';

import '../controllers/detail_anggota_controller.dart';

class DetailAnggotaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailAnggotaController>(
      () => DetailAnggotaController(),
    );
  }
}
