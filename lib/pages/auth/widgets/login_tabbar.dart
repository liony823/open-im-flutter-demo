import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:openim_common/openim_common.dart';

class LoginTabBar extends StatelessWidget {
  const LoginTabBar({
    super.key,
    required this.controller,
    required this.tabs,
  });

  final TabController controller;
  final List<String> tabs;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TabBar(
          controller: controller,
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          labelPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.w),
          tabAlignment: TabAlignment.start,
          isScrollable: true,
          dividerHeight: 0,
          unselectedLabelStyle: Styles.ts_999999_17_semibold,
          labelStyle: Styles.ts_333333_17_semibold,
          indicator: RectIndicator(
            gradient: const LinearGradient(
              colors: [Styles.c_0089FF, Styles.c_F3F3F3],
            ),
            leftPadding: 2.w,
            bottomPadding: 13.h,
            width: 56.w,
            height: 6.h,
          ),
          tabs: tabs.map((e) => Text(e)).toList()),
    );
  }
}
