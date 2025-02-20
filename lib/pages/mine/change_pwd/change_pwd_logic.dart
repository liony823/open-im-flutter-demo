import 'package:flutter/material.dart';
import 'package:flutter_openim_sdk/flutter_openim_sdk.dart';
import 'package:get/get.dart';
import 'package:openim_common/openim_common.dart';

import '../../../routes/app_navigator.dart';

class ChangePwdLogic extends GetxController {
  final oldPwdCtrl = TextEditingController();
  final newPwdCtrl = TextEditingController();
  final againPwdCtrl = TextEditingController();

  @override
  void onClose() {
    oldPwdCtrl.dispose();
    newPwdCtrl.dispose();
    againPwdCtrl.dispose();
    super.onClose();
  }

  void confirm() async {
    if (oldPwdCtrl.text.isEmpty) {
      IMViews.showToast(t.plsEnterOldPwd);
      return;
    }
    if (!IMUtils.isValidPassword(newPwdCtrl.text)) {
      IMViews.showToast(t.wrongPasswordFormat);
      return;
    }
    if (newPwdCtrl.text.isEmpty) {
      IMViews.showToast(t.plsEnterNewPwd);
      return;
    }
    if (againPwdCtrl.text.isEmpty) {
      IMViews.showToast(t.plsEnterConfirmPwd);
      return;
    }
    if (newPwdCtrl.text != againPwdCtrl.text) {
      IMViews.showToast(t.twicePwdNoSame);
      return;
    }

    final result = await LoadingView.singleton.wrap(
      asyncFunction: () => Apis.changePassword(
        userID: OpenIM.iMManager.userID,
        newPassword: newPwdCtrl.text,
        currentPassword: oldPwdCtrl.text,
      ),
    );
    if (result) {
      IMViews.showToast(t.changedSuccessfully);
      await LoadingView.singleton.wrap(asyncFunction: () async {
        await OpenIM.iMManager.logout();
        await DataSp.removeLoginCertificate();
        // PushController.logout();
      });
      AppNavigator.startLogin();
    }
  }
}
