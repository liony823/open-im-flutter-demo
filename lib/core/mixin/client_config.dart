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

  void setDefaultApplet(AppletInfo applet) {
    defaultApplet.update((val) {
      val?.appID = applet.appID;
      val?.icon = applet.icon;
      val?.isDefault = applet.isDefault;
      val?.name = applet.name;
      val?.url = applet.url;
      val?.status = applet.status;
    });
    DataSp.putApplet(applet);
  }

  Future<void> _initApplet() async {
    appletList.clear();
    final applet = DataSp.getApplet();
    if (applet != null) {
      defaultApplet.value = applet;
      defaultApplet.refresh();
    }
    final list = await Apis.getAppletList();
    for (var item in list) {
      if (item.isDefault == 1) {
        if (defaultApplet.value != null &&
            defaultApplet.value!.appID != item.appID) {
          defaultApplet.update((applet) {
            applet?.icon = item.icon;
            applet?.isDefault = item.isDefault;
            applet?.name = item.name;
            applet?.url = item.url;
            applet?.status = item.status;
          });
        } else {
          defaultApplet.update((applet) {
            applet?.icon = item.icon;
            applet?.isDefault = item.isDefault;
            applet?.name = item.name;
            applet?.url = item.url;
            applet?.status = item.status;
          });
        }
      }
    }
    if (defaultApplet.value != null) {
      DataSp.putApplet(defaultApplet.value!);
    }
    list.sort((a, b) => (a.priority ?? 0).compareTo(b.priority ?? 0));
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
