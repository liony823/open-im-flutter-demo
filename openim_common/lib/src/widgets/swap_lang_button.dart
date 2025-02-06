import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:openim_common/openim_common.dart';

class SwapLangButton extends StatelessWidget {
  final VoidCallback onTap;
  final String? text;
  const SwapLangButton({super.key, required this.onTap, this.text});

  @override
  Widget build(BuildContext context) {
    return AdaptiveButton.small(
      onTap: onTap,
      enabledColor: const Color.fromARGB(255, 172, 210, 244),
      block: false,
      radius: 24.r,
      child: Row(
        children: [
          (text ?? '').toText..style = Styles.ts_FFFFFF_12,
          3.horizontalSpace,
          Icon(EvaIcons.swapOutline, size: 16.r, color: Styles.c_FFFFFF),
        ],
      ),
    );
  }
}
