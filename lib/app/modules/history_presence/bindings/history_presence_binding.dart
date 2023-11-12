import 'package:get/get.dart';

import '../controllers/history_presence_controller.dart';

class HistoryPresenceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HistoryPresenceController>(
      () => HistoryPresenceController(),
    );
  }
}
