import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:openim_common/openim_common.dart';

import 'feed_logic.dart';

class FeedPage extends StatelessWidget {
  FeedPage({super.key});

  final logic = Get.find<FeedLogic>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.c_F6F6F6,
      appBar: AppBar(
        title: StrRes.feed.toText..style = Styles.ts_0C1C33_17_semibold,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCard(
                child: Column(
              children: [
                if (logic.appMomentsVisible)
                  _buildItemView(
                      img: ImageRes.feedMoments.toImage..width = 28.w,
                      label: StrRes.friendShare,
                      showDivider: true),
                _buildItemView(
                  img: ImageRes.feedScan.toImage..width = 28.w,
                  label: StrRes.scanQrCode,
                ),
              ],
            )),
            16.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: StrRes.workbench.toText..style = Styles.ts_999999_20,
            ),
            _buildCard(
                child: Column(
              children: [
                if (logic.appSignRedEnvelopeVisible)
                  _buildItemView(
                    img: ImageRes.feedHongbao.toImage..width = 28.w,
                    label: StrRes.signRedEnvelope,
                  ),
                for (var item in logic.appletList)
                  _buildItemView(
                    img: ImageUtil.networkImage(
                      url: item.icon ?? '',
                      width: 28.w,
                    ),
                    label: item.name ?? '',
                  ),
              ],
            ))
          ],
        ),
      ),
    );
  }

  Widget _buildCard({required Widget child}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.w),
      decoration: BoxDecoration(
        color: Styles.c_FFFFFF,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: child,
    );
  }

  Widget _buildItemView(
      {required Widget img,
      required String label,
      int unReadCount = 0,
      bool showDivider = false}) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              img,
              14.horizontalSpace,
              label.toText..style = Styles.ts_0C1C33_17_semibold,
              const Spacer(),
              if (unReadCount > 0) UnreadCountView(count: unReadCount),
              10.horizontalSpace,
              Icon(
                EvaIcons.chevronRightOutline,
                size: 22.w,
              )
            ],
          ),
        ),
        if (showDivider) _buildDivider(),
      ],
    );
  }

  Widget _buildDivider() {
    return Divider(
      thickness: 1,
      height: 1,
      indent: 24.w,
      endIndent: 24.w,
      color: Styles.c_EDEDED,
    );
  }
}
