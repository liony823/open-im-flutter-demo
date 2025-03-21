import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:openim/core/controller/app_controller.dart';
import 'package:openim/utils/dialog.dart';
import 'package:openim_common/openim_common.dart';
import "package:flutter_form_builder/flutter_form_builder.dart";
import 'package:webview_flutter/webview_flutter.dart';

class AppletLogic extends GetxController {
  final appLogic = Get.find<AppController>();
  final formKey = GlobalKey<FormBuilderState>();
  WebViewController? controller;
  TextEditingController? _textEditingController;

  final progress = 0.0.obs;

  List<AppletInfo> get appleList => appLogic.appletList;
  AppletInfo? get defaultApplet => appLogic.defaultApplet.value;

  void _getApplet(String appID) async {
    try {
      LoadingView.singleton.wrap(asyncFunction: () async {
        final data = await Apis.getApplet(appID);
        if (data != null) {
          controller?.loadRequest(Uri.parse(data.url!));
          appLogic.setDefaultApplet(data);
        }
      });
    } catch (e) {
      Logger.print("AppletLogic _getApplet error: $e", isError: true);
    }
  }

  void submit() {
    final valid = formKey.currentState?.saveAndValidate();
    if (valid == true) {
      final text = formKey.currentState?.getRawValue('appID') as String;
      if (text.trim() != "") {
        _getApplet(text);
      }
    }
  }

  void reloadH5() {
    controller?.reload();
  }

  void showAppletsModal() {}

  void showSearchAppletModal() async {
    if (_textEditingController == null) return;
    final text = await DialogUtils.showSearchApplet(_textEditingController!);
    if (text.isNotEmpty) {
      _getApplet(text);
    }
  }

  @override
  void onInit() {
    super.onInit();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('WebView is loading (progress : $progress%)');
            this.progress.value = progress / 100;
          },
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('''
Page resource error:
  code: ${error.errorCode}
  description: ${error.description}
  errorType: ${error.errorType}
  isForMainFrame: ${error.isForMainFrame}
          ''');
          },
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
          onHttpError: (HttpResponseError error) {
            debugPrint('Error occurred on page: ${error.response?.statusCode}');
          },
          onUrlChange: (UrlChange change) {
            debugPrint('url change to ${change.url}');
          },
          onHttpAuthRequest: (HttpAuthRequest request) {},
        ),
      );
    if (defaultApplet != null) {
      controller?.loadRequest(Uri.parse(defaultApplet!.url!));
    } else {
      _textEditingController = TextEditingController();
      showSearchAppletModal();
    }
  }

  @override
  void onClose() {
    _textEditingController?.dispose();
    super.onClose();
  }
}
