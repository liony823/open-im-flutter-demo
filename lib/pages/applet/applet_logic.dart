import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:openim/pages/home/home_logic.dart';
import 'package:openim_common/openim_common.dart';
import "package:flutter_form_builder/flutter_form_builder.dart";

class AppletLogic extends GetxController {
  final homeLogic = Get.find<HomeLogic>();
  final formKey = GlobalKey<FormBuilderState>();

  final applet = Rxn<AppletInfo>();

  List<AppletInfo> get appleList => homeLogic.appletList;

  void _getApplet(String appID) async {
    try {
      final data = await Apis.getApplet(appID);
      if (data != null){
        DataSp.putApplet(data);
        applet.value = data;
        applet.refresh();
      }
    } catch (e) {
      Logger.print("AppletLogic _getApplet error: $e",isError: true);
    }
  }

  void submit(){
    final valid = formKey.currentState?.saveAndValidate();
    if (valid == true){
      final text = formKey.currentState?.getRawValue('appID') as String;
      if (text.trim() != ""){
        _getApplet(text);
      }
    }
  }  

  
  @override
  onReady(){
    if (homeLogic.defaultApplet.value != null){
      applet.value = homeLogic.defaultApplet.value;
      applet.refresh();
    }
  }
}
