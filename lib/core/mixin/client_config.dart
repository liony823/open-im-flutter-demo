import 'package:openim_common/openim_common.dart';
import 'package:get/get.dart';

mixin ClientConfig {
  final clientConfigMap = <String, dynamic>{}.obs;
  final defaultApplet = Rxn<AppletInfo>();
  final appletList = <AppletInfo>[].obs;

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

  // 小程序页
  bool get miniProgramVisible =>
      clientConfigMap[ClientConfigs.appMiniProgramVisible] ==
      ClientConfigs.commonAllow;

  // 发现页
  bool get discoveryVisible =>
      clientConfigMap[ClientConfigs.appDiscoveryVisible] ==
      ClientConfigs.commonAllow;

  // 签到红包模块
  bool get signRedEnvelopeVisible =>
      clientConfigMap[ClientConfigs.appSignRedEnvelopeVisible] ==
      ClientConfigs.commonAllow;

  // 好友分享
  bool get momentsVisible =>
      clientConfigMap[ClientConfigs.appMomentsVisible] ==
      ClientConfigs.commonAllow;

  Future<void> _initApplet() async {
    final applet = DataSp.getApplet();
    if (applet != null) {
      defaultApplet.value = applet;
      defaultApplet.refresh();
    }
    final list = await Apis.getAppletList();
    for (var item in list) {
      if (item.isDefault == 1) {
        defaultApplet.update((applet) {
          applet?.appID = item.appID;
          applet?.icon = item.icon;
          applet?.isDefault = item.isDefault;
          applet?.name = item.name;
          applet?.url = item.url;
          applet?.status = item.status;
        });
        DataSp.putApplet(item);
      }
    }
    appletList.addAll(list);
  }

  Future<void> initClientConfig() async {
    final config = await Apis.getClientConfig();
    clientConfigMap.value = config;

    if (miniProgramVisible) {
      await _initApplet();
    }
  }
}
