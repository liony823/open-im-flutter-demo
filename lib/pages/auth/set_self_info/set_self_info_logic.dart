import 'package:flutter/material.dart';
import 'package:flutter_openim_sdk/flutter_openim_sdk.dart';
import 'package:openim/routes/app_navigator.dart';
import 'package:get/get.dart';
import 'package:openim_common/openim_common.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class SetSelfInfoLogic extends GetxController {
  final formKey = GlobalKey<FormBuilderState>();
  final loading = false.obs;
  late UserFullInfo userFullInfo;
  final faceURL = ''.obs;
  void openPhotoSheet() {
    IMViews.openPhotoSheet(onData: (path, url) async {
      if (url != null) {
        Logger.print('---------update user info-------$url');
        faceURL.value = url;
      }
    });
  }

  void confirm() async {
    final form = formKey.currentState;
    if (form == null) return;
    if (!form.saveAndValidate()) {
      return;
    }
    try {
      final nickname = form.getRawValue('nickname');
      final account = form.getRawValue('account');
      if (userFullInfo.account != account ||
          userFullInfo.nickname != nickname ||
          userFullInfo.faceURL != faceURL.value) {
        loading.value = true;
        await Apis.updateUserInfo(
          userID: OpenIM.iMManager.userID,
          account: account,
          nickname: nickname,
          faceURL: faceURL.value,
        );
      }
      AppNavigator.startMain();
    } catch (e) {
      Logger.print("---------update user info error-------$e");
    } finally {
      loading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    userFullInfo = Get.arguments['userFullInfo'];
    faceURL.value = userFullInfo.faceURL ?? '';
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      formKey.currentState?.patchValue({
        "nickname": userFullInfo.nickname,
        "account": userFullInfo.account,
      });
    });
  }
}
