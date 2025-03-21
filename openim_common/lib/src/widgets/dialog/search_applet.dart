import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:openim_common/openim_common.dart';

class SearchApplet extends StatelessWidget {
  const SearchApplet({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: (context.t.appletCode).toText
          ..textAlign = TextAlign.center
          ..style = Styles.ts_0C1C33_17_semibold,
        content: Column(
          spacing: 16.w,
          mainAxisSize: MainAxisSize.min,
          children: [
            FormInput(
              name: "code",
              controller: controller,
              hintText: context.t.plsEnterAppletCode,
            ),
            Row(
              spacing: 16.w,
              children: [
                Flexible(
                  child: Button(
                    type: ButtonType.secondary,
                    onTap: () => Get.back(result: ''),
                    text: context.t.cancel,
                  ),
                ),
                Flexible(
                  child: Button(
                    onTap: () => Get.back(result: controller.text),
                    text: context.t.confirm,
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
