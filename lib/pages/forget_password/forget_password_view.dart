import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:openim/widgets/register_page_bg.dart';
import 'package:openim_common/openim_common.dart';

import 'forget_password_logic.dart';

class ForgetPasswordPage extends StatelessWidget {
  final logic = Get.find<ForgetPasswordLogic>();

  ForgetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) => RegisterBgView(
        child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                (context.t.forgetPassword).toText
                  ..style = Styles.ts_0089FF_20_semibold,
                29.verticalSpace,
                InputBox.account(
                  label: t.phoneNumber,
                  code: logic.areaCode.value,
                  onAreaCode: logic.openCountryCodePicker,
                  controller: logic.phoneCtrl,
                ),
                16.verticalSpace,
                InputBox.verificationCode(
                  label: t.verificationCode,
                  hintText: t.plsEnterVerificationCode,
                  controller: logic.verificationCodeCtrl,
                  onSendVerificationCode: logic.getVerificationCode,
                ),
                130.verticalSpace,
                AdaptiveButton(
                  text: t.nextStep,
                  enabled: logic.enabled.value,
                  onTap: logic.nextStep,
                ),
              ],
            )),
      );
}
