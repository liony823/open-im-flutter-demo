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
      backgroundColor: Styles.c_F8F9FA,
      appBar: AppBar(
        title: StrRes.feed.toText..style = Styles.ts_0C1C33_17_semibold,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildCard(
                child: Column(
              children: [
                if (logic.appMomentsVisible)
                  _buildItemView(
                    img: ImageRes.feedMoments.toImage,
                    label: StrRes.friendShare,
                  ),
                if (logic.appMomentsVisible) _buildDivider(),
                _buildItemView(
                  img: ImageRes.feedScan.toImage,
                  label: StrRes.scanQrCode,
                ),
              ],
            )),
            16.verticalSpace,
            StrRes.workbench.toText..style = Styles.ts_999999_20,
            _buildCard(child: Column(
              children: [
                if (logic.appSignRedEnvelopeVisible) _buildItemView(
                  img: ImageRes.feedHongbao.toImage,
                  label: StrRes.signRedEnvelope,
                ),
                if (logic.appSignRedEnvelopeVisible) _buildDivider(),
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
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: child,
    );
  }

  Widget _buildItemView(
      {required Widget img, required String label, int unReadCount = 0}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          img,
          20.horizontalSpace,
          label.toText..style = Styles.ts_0C1C33_17_semibold,
          const Spacer(),
          if (unReadCount > 0) UnreadCountView(count: unReadCount),
          10.horizontalSpace,
          Icon(
            Icons.arrow_right_outlined,
            size: 16.w,
          )
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(thickness: 1, indent: 24.w, endIndent: 24.w);
  }
}
