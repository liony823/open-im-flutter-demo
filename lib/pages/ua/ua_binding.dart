import 'package:get/get.dart';

import 'ua_logic.dart';

class UaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UaLogic());
  }
}
