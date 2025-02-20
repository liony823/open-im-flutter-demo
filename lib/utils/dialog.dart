import 'package:get/get.dart';
import 'package:openim_common/openim_common.dart';

class DialogUtils {
  static Future<bool> showAlertAgreement(
    Function() onEnterUa,
    Function() onEnterPP,
  ) async {
    final b = await Get.dialog<bool>(AlertAgreement(
      onEnterUa: onEnterUa,
      onEnterPP: onEnterPP,
    ));

    return b ?? false;
  }
}
