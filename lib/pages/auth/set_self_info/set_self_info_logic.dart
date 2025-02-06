import 'package:openim/core/controller/im_controller.dart';
import 'package:openim/routes/app_navigator.dart';
import 'package:get/get.dart';
import 'package:openim_common/openim_common.dart';

class SetSelfInfoLogic extends GetxController {
  final imLogic = Get.find<IMController>();
  late Rx<UserFullInfo> userInfo;

  final loading = false.obs;

  void openPhotoSheet() {
    IMViews.openPhotoSheet(onData: (path, url) async {
      if (url != null) {
        Logger.print('---------update user info-------$url');
        userInfo.value.faceURL = url;
        userInfo.refresh();
      }
    });
  }

  void toSetInfo({required String field, required String value}) async {
    final res = await AppNavigator.startSetInfo(field: field, value: value);
    if (res != null) {
      switch (field) {
        case 'nickname':
          userInfo.value.nickname = res;
          break;
        case 'account':
          userInfo.value.account = res;
          break;
      }
      userInfo.refresh();
    }
  }

  void confirm() async {
    loading.value = true;
    try {
      await Apis.updateUserInfo(
        userID: userInfo.value.userID!,
        nickname: userInfo.value.nickname,
        faceURL: userInfo.value.faceURL,
        account: userInfo.value.account,
      );
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
    userInfo = Rx(imLogic.userInfo.value);
    ever(imLogic.userInfo, (value) {
      userInfo.update((val) {
        val?.nickname = value.nickname;
        val?.faceURL = value.faceURL;
        val?.account = value.account;
      });
    });
  }
}
