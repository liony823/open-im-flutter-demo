import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:openim_common/openim_common.dart';
import 'webview_logic.dart';

class WebviewPage extends StatelessWidget {
  WebviewPage({super.key});

  final logic = Get.find<WebviewLogic>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => H5Container(
          title: logic.title,
          html: IMUtils.isNotNullEmptyStr(logic.content) ? logic.webHtml : null,
          url: IMUtils.isNotNullEmptyStr(logic.url) ? logic.url : null,
        ));
  }
}
