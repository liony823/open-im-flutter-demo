import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:openim_common/openim_common.dart';
import 'ua_logic.dart';

class UaPage extends StatelessWidget {
  UaPage({super.key});

  final logic = Get.find<UaLogic>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: AppBar(
            title: logic.type == UaType.userAgreement
                ? (StrRes.userAgreement.toText
                  ..style = Styles.ts_0C1C33_17_semibold)
                : StrRes.privacyPolicy.toText
              ..style = Styles.ts_0C1C33_17_semibold,
          ),
          body: SafeArea(
            child: InAppWebView(
              initialData: InAppWebViewInitialData(
                data: logic.content,
                mimeType: 'text/html',
                encoding: 'utf-8',
              ),
            ),
          ),
        ));
  }
}
