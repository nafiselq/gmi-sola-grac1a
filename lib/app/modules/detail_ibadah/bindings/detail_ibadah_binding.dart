import 'package:get/get.dart';

import '../controllers/detail_ibadah_controller.dart';

class DetailIbadahBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailIbadahController>(
      () => DetailIbadahController(),
    );
  }
}
