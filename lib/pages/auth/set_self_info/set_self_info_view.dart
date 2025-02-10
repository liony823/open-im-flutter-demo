import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:openim_common/openim_common.dart';

import 'set_self_info_logic.dart';

class SetSelfInfoPage extends StatelessWidget {
  final logic = Get.find<SetSelfInfoLogic>();

  SetSelfInfoPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: StrRes.plsCompleteInfo.toText
            ..style = Styles.ts_0C1C33_17_semibold,
        ),
        body: Center(
          child: Obx(() => Column(
                children: [
                  48.verticalSpace,
                  _buildAvatarView(),
                  24.verticalSpace,
                  _buildItemView(
                      StrRes.account, logic.userInfo.value.account ?? '',
                      onTap: () => logic.toSetInfo(
                          field: 'account',
                          value: logic.userInfo.value.account ?? '')),
                  _buildItemView(
                      StrRes.nickname, logic.userInfo.value.nickname ?? '',
                      onTap: () => logic.toSetInfo(
                          field: 'nickname',
                          value: logic.userInfo.value.nickname ?? '')),
                  24.verticalSpace,
                  AdaptiveButton(
                    margin: EdgeInsets.symmetric(horizontal: 24.w),
                    text: StrRes.confirm,
                    loading: logic.loading.value,
                    onTap: logic.confirm,
                  )
                ],
              )),
        ),
      );

  Widget _buildAvatarMask() => Container(
        width: 66.w,
        height: 66.w,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black54,
        ),
        child: Center(
          child: Icon(
            EvaIcons.imageOutline,
            size: 22.r,
            color: Styles.c_FFFFFF,
          ),
        ),
      );

    

  Widget _buildAvatarView() => GestureDetector(
        onTap: () => logic.openPhotoSheet(),
        child: Column(
          spacing: 12.w,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                AvatarView(
                  width: 68.w,
                  height: 68.w,
                  url: logic.userInfo.value.faceURL,
                  text: logic.userInfo.value.nickname,
                  isCircle: true,
                ),
                Positioned(child: _buildAvatarMask()),
              ],
            ),
            StrRes.plsSetAvatar.toText
              ..style = Styles.ts_0089FF_16_medium
              ..textAlign = TextAlign.center,
          ],
        ),
      );

  Widget _buildItemView(String title, String text, {VoidCallback? onTap}) =>
      InkWell(
        onTap: onTap,
        child: Container(
          height: 52.h,
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              title.toText..style = Styles.ts_666666_16,
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    text.toText..style = Styles.ts_0C1C33_16_semibold,
                    8.horizontalSpace,
                    Icon(
                      EvaIcons.chevronRightOutline,
                      size: 24.r,
                      color: Styles.c_333333,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
