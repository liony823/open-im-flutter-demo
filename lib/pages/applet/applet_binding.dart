import 'package:get/get.dart';

import 'applet_logic.dart';

class AppletBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AppletLogic());
  }
}
