import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:openim_common/openim_common.dart';

class InputPhoneCode extends StatelessWidget {
  final VoidCallback onOpenPicker;
  final String areaCode;
  const InputPhoneCode(
      {super.key, required this.onOpenPicker, required this.areaCode});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onOpenPicker,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          16.horizontalSpace,
          areaCode.toText..style = Styles.ts_000033_14_medium,
          const Icon(EvaIcons.chevronDown),
          Container(
            width: 1.w,
            height: 20.h,
            color: Styles.c_333333.withValues(alpha: .25),
          ),
          8.horizontalSpace,
        ],
      ),
    );
  }
}
