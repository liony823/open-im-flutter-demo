import 'package:openim_common/openim_common.dart';
import 'package:get/get.dart';

mixin ClientConfig {
  final clientConfigMap = <String, dynamic>{}.obs;

  // 当前登录类型
  String get loginType =>
      clientConfigMap[ClientConfigs.appLoginType] ??
      ClientConfigs.appLoginWithUserAndPhone;

  // 邀请码
  bool get inviteCodeVisible =>
      clientConfigMap[ClientConfigs.appSignupInviteCodeVisible] ==
      ClientConfigs.commonAllow;

  // 用户协议
  String get userAgreement =>
      clientConfigMap[ClientConfigs.appUserAgreementContent] ?? '';

  // 隐私政策
  String get privacyPolicy =>
      clientConfigMap[ClientConfigs.appPrivacyPolicyContent] ?? '';

  void initClientConfig() async {
    final config = await Apis.getClientConfig();
    clientConfigMap.value = config;
  }
}
