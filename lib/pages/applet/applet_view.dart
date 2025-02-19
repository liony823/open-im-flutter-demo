import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:openim_common/openim_common.dart';

import 'applet_logic.dart';

class AppletPage extends StatelessWidget {
  final logic = Get.find<AppletLogic>();

  AppletPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleBar.workbench(),
      backgroundColor: Styles.c_F8F9FA,
      body: Obx(() {
        if (logic.applet.value != null) {
          return _buildH5Body(logic.applet.value!.url!);
        }
        return const SizedBox.shrink();
      }),
    );
  }

  Widget _buildH5Body(String url) {
    return H5Container(url: url);
  }
}
