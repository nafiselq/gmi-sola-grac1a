import 'package:get/get.dart';

import '../controllers/informasi_pribadi_controller.dart';

class InformasiPribadiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InformasiPribadiController>(
      () => InformasiPribadiController(),
    );
  }
}
