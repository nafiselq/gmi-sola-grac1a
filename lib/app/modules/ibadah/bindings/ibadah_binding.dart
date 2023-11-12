import 'package:get/get.dart';

import '../controllers/ibadah_controller.dart';

class IbadahBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IbadahController>(
      () => IbadahController(),
    );
  }
}
