import 'dart:async';

import 'package:openim/core/controller/im_controller.dart';
import 'package:openim/routes/app_navigator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:openim_common/openim_common.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyPhoneLogic extends GetxController {
  final imLogic = Get.find<IMController>();
  final codeErrorCtrl = StreamController<ErrorAnimationType>();
  final codeEditCtrl = TextEditingController();
  final enabled = false.obs;
  final loading = false.obs;
  late String phoneNumber;
  late String areaCode;
  late String password;
  late int usedFor;
  String? invitationCode;
  RegisterType? registerType;

  @override
  void onInit() {
    phoneNumber = Get.arguments['phoneNumber'];
    password = Get.arguments['password'];
    areaCode = Get.arguments['areaCode'];
    usedFor = Get.arguments['usedFor'];
    invitationCode = Get.arguments['invitationCode'];
    registerType = Get.arguments['registerType'] as RegisterType?;
    codeEditCtrl.addListener(_onChanged);
    super.onInit();
  }

  @override
  void onClose() {
    codeErrorCtrl.close();
    super.onClose();
  }

  void _onChanged() {
    enabled.value = codeEditCtrl.text.length == 6;
  }

  void shake() {
    codeErrorCtrl.add(ErrorAnimationType.shake);
  }

  Future<bool> requestVerificationCode() => LoadingView.singleton.wrap(
      asyncFunction: () => Apis.requestVerificationCode(
            areaCode: areaCode,
            phoneNumber: phoneNumber,
            email: null,
            usedFor: usedFor,
            invitationCode: invitationCode,
          ));

  Future checkVerificationCode(String verificationCode) =>
      Apis.checkVerificationCode(
        areaCode: areaCode,
        phoneNumber: phoneNumber,
        email: null,
        verificationCode: verificationCode,
        usedFor: usedFor,
        invitationCode: invitationCode,
      );

  void completed(value) async {
    try {
      loading.value = true;
      await checkVerificationCode(value);

      // 忘记密码逻辑
      if (usedFor == 2) {
        loading.value = false;

        return;
      }

      LoginCertificate? result;
      // 手机注册逻辑
      if (usedFor == 1) {
        result = await Apis.register(
          nickname: IMUtils.generateRandomString(6),
          areaCode: areaCode,
          phoneNumber: phoneNumber,
          password: password,
          invitationCode: invitationCode,
          verificationCode: value,
          registerType: registerType,
        );
      }

      // 手机登陆逻辑
      if (usedFor == 3) {
        result = await Apis.login(
          areaCode: areaCode,
          phoneNumber: phoneNumber,
          password: password,
          verificationCode: value,
        );
      }

      loading.value = false;
      if (null == IMUtils.emptyStrToNull(result?.imToken) ||
          null == IMUtils.emptyStrToNull(result?.chatToken)) {
        AppNavigator.startLogin();
        return;
      }

      final certificate = result!;

      await DataSp.putLoginCertificate(certificate);
      await imLogic.login(certificate.userID, certificate.imToken);
      Logger.print('---------im login success-------');
      AppNavigator.startSetSelfInfo();
    } catch (e) {
      shake();
    } finally {
      loading.value = false;
    }
  }
}
