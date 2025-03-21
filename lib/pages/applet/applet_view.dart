import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:openim_common/openim_common.dart';

import 'applet_logic.dart';

class AppletPage extends StatelessWidget {
  final logic = Get.find<AppletLogic>();

  AppletPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: (context.t.miniProgram).toText
          ..style = Styles.ts_0C1C33_17_semibold,
        actions: [
          IconButton(
            onPressed: logic.showAppletsModal,
            icon: const Icon(
              EvaIcons.gridOutline,
              color: Styles.c_0C1C33,
            ),
          ),
          IconButton(
            onPressed: logic.reloadH5,
            icon: const Icon(
              EvaIcons.refreshOutline,
              color: Styles.c_0C1C33,
            ),
          ),
          8.horizontalSpace,
        ],
      ),
      backgroundColor: Styles.c_F8F9FA,
      body: Obx(() {
        if (logic.defaultApplet?.url != null) {
          return H5Container(
            controller: logic.controller,
            progress: logic.progress.value,
          );
        }
        return Center(
          child: Column(
            spacing: 24.w,
            children: [
              48.verticalSpace,
              ImageRes.noNetwork.toImage..width = 176.w,
              TextButton(
                onPressed: logic.showSearchAppletModal,
                child: (context.t.tapApplet).toText
                  ..style = Styles.ts_0C1C33_14
                  ..textAlign = TextAlign.center,
              ),
            ],
          ),
        );
      }),
    );
  }
}
