import 'package:get/get.dart';
import 'package:openim/core/controller/app_controller.dart';
import 'package:openim/pages/home/home_logic.dart';
import 'package:openim_common/openim_common.dart';

class FeedLogic extends GetxController {
  final appLogic = Get.find<AppController>();
  final homeLogic = Get.find<HomeLogic>();

  bool get appMomentsVisible => appLogic.momentsVisible;
  bool get appSignRedEnvelopeVisible => appLogic.signRedEnvelopeVisible;

  List<AppletInfo> get appletList => appLogic.appletList;

  switchApplet(AppletInfo applet) {
    homeLogic.switchApplet(applet);
  }
}
