import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:openim/core/controller/app_controller.dart';
import 'package:openim_common/openim_common.dart';
import "package:flutter_form_builder/flutter_form_builder.dart";

class AppletLogic extends GetxController {
  final appLogic = Get.find<AppController>();
  final formKey = GlobalKey<FormBuilderState>();

  final applet = Rxn<AppletInfo>();

  List<AppletInfo> get appleList => appLogic.appletList;

  void _getApplet(String appID) async {
    try {
      final data = await Apis.getApplet(appID);
      if (data != null) {
        DataSp.putApplet(data);
        applet.value = data;
        applet.refresh();
      }
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

  @override
  void onReady() {
    super.onReady();
    final defaultApplet = appLogic.defaultApplet.value;
    if (defaultApplet != null) {
      applet.value = defaultApplet;
      applet.refresh();
    }
  }
}
