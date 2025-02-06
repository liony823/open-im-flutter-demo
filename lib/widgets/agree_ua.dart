import 'package:openim/pages/ua/ua_logic.dart';
import 'package:openim/routes/app_navigator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:openim_common/openim_common.dart';

class AgreeUA extends StatelessWidget {
  const AgreeUA({
    super.key,
    required this.isChecked,
    required this.onCheck,
  });

  final bool isChecked;
  final Function(bool?) onCheck;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: 4.h + MediaQuery.of(context).padding.bottom),
      child: Row(
        spacing: 4.w,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomCheckBox(
            isChecked: isChecked,
            onTap: onCheck,
            size: 20.r,
          ),
          RichText(
            text: TextSpan(
              style: Styles.ts_999999_12,
              children: [
                TextSpan(text: StrRes.agreementText),
                TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () =>
                          AppNavigator.startUa(type: UaType.userAgreement),
                    text: StrRes.userAgreement,
                    style: Styles.ts_333333_12),
                TextSpan(text: StrRes.and, style: Styles.ts_999999_12),
                TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () =>
                          AppNavigator.startUa(type: UaType.privacyPolicy),
                    text: StrRes.privacyPolicy,
                    style: Styles.ts_333333_12),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
