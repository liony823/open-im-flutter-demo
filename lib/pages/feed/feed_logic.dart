import 'package:get/get.dart';
import 'package:openim/core/controller/app_controller.dart';
import 'package:openim_common/openim_common.dart';

class FeedLogic extends GetxController {
  final appLogic = Get.find<AppController>();

  bool get appMomentsVisible => appLogic.momentsVisible;
  bool get appSignRedEnvelopeVisible => appLogic.signRedEnvelopeVisible;

  List<AppletInfo> get appletList => appLogic.appletList;
}
