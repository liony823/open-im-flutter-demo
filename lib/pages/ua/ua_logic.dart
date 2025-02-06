import 'package:get/get.dart';
import 'package:openim/core/controller/app_controller.dart';

enum UaType {
  userAgreement,
  privacyPolicy,
}

class UaLogic extends GetxController {
  late UaType type;
  final appLogic = Get.find<AppController>();

  @override
  void onInit() {
    super.onInit();
    type = Get.arguments['type'];
  }

  String get content => '''
                      <!DOCTYPE html>
                      <html>
                      <head>
                          <meta name="viewport" content="width=device-width, initial-scale=1.0">
                      </head>
                      <body>
                          ${type == UaType.userAgreement ? appLogic.userAgreement : appLogic.privacyPolicy}
                      </body>
                      </html>
                      ''';
}
