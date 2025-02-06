import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:openim_common/openim_common.dart';

class AlertAgreement extends StatelessWidget {
  final VoidCallback onEnterUa;
  final VoidCallback onEnterPP;
  const AlertAgreement({
    super.key,
    required this.onEnterUa,
    required this.onEnterPP,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 28.w),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      title: StrRes.alertDialogAgreementTitle.toText
        ..style = Styles.ts_000000_20_semibold,
      actions: [
        TextButton(
            onPressed: () {
              // Logger.print("AlertAgreement cancel");
              Get.back(result: false);
            },
            style: TextButton.styleFrom(
              foregroundColor: Styles.c_666666,
            ),
            child: StrRes.cancel.toText),
        TextButton(
            onPressed: () {
              Get.back(result: true);
            },
            child: StrRes.agreementText.toText),
      ],
      content: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 16.w,
        children: [
          RichText(
              text: TextSpan(children: [
            TextSpan(
                text: StrRes.alertDialogAgreementContent,
                style: Styles.ts_000000_14_medium),
            TextSpan(
                recognizer: TapGestureRecognizer()..onTap = onEnterUa,
                text: StrRes.userAgreement,
                style: Styles.ts_0089FF_14_medium),
            TextSpan(
                recognizer: TapGestureRecognizer()..onTap = onEnterPP,
                text: StrRes.privacyPolicy,
                style: Styles.ts_0089FF_14_medium),
          ])),
        ],
      ),
    );
  }
}
