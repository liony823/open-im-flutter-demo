import 'package:openim/pages/ua/ua_logic.dart';
import 'package:openim/routes/app_navigator.dart';
import 'package:get/get.dart';
import 'package:openim_common/openim_common.dart';

class DialogUtils {
  static Future<bool> showAlertAgreement() async {
    final b = await Get.dialog<bool>(AlertAgreement(
      onEnterUa: () => AppNavigator.startUa(type: UaType.userAgreement),
      onEnterPP: () => AppNavigator.startUa(type: UaType.privacyPolicy),
    ));

    return b ?? false;
  }
}
