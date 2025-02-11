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
      body: _buildH5Body(),
    );
  }

  Widget _buildH5Body() {
    return H5Container(url: logic.applet.value!.url!);
  }
}
