import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:openim_common/openim_common.dart';

class LoginTab extends StatelessWidget {
  const LoginTab({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Stack(
        children: [
          Positioned(
            bottom: 5.w,
            left: 0.w,
            child: buildLine(),
          ),
          title.toText..style = Styles.ts_333333_17_semibold,
        ],
      ),
    );
  }

  Widget buildLine() {
    return Container(
      width: 56.w,
      height: 6.h,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Styles.c_0089FF, Styles.c_F3F3F3],
        ),
        borderRadius: BorderRadius.circular(5.r),
      ),
    );
  }
}
