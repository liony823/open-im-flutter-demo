import 'package:get/get.dart';

import 'feed_logic.dart';

class FeedBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FeedLogic());
  }
}