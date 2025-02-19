import "package:openim/core/controller/app_controller.dart";
import "package:openim/core/controller/im_controller.dart";
import "package:openim/core/mixin/world.dart";
import "package:openim/pages/ua/ua_logic.dart";
import "package:openim/routes/app_navigator.dart";
import "package:openim/utils/dialog.dart";
import "package:flutter/material.dart";
import "package:flutter_form_builder/flutter_form_builder.dart";
import "package:get/get.dart";
import "package:openim_common/openim_common.dart";
import "package:world_countries/world_countries.dart";

class RegisterLogic extends GetxController
    with GetTickerProviderStateMixin, WorldMixin {
  final appLogic = Get.find<AppController>();
  final imLogic = Get.find<IMController>();
  final formKey = GlobalKey<FormBuilderState>();
  TabController? tabController;
  final passwordController = TextEditingController();

  String get loginType => appLogic.loginType;
  bool get inviteCodeVisible => appLogic.inviteCodeVisible;

  final isAgreementChecked = true.obs; // 默认勾选 用户协议和隐私政策
  final loading = false.obs; // 点击登录按钮时，显示加载中
  final areaCode = "+86".obs;

  void onAgreementChecked(bool? value) {
    isAgreementChecked.value = value ?? false;
  }

  void toUserAgreement() {
    AppNavigator.startUa(type: UaType.userAgreement);
  }

  void toPrivacyPolicy() {
    AppNavigator.startUa(type: UaType.privacyPolicy);
  }

  void toLanguage() {
    AppNavigator.startLanguage();
  }

  Future<bool> requestVerificationCode(String phone, {String? inviteCode}) =>
      Apis.requestVerificationCode(
        areaCode: areaCode.value,
        phoneNumber: phone,
        usedFor: 1,
        invitationCode: inviteCode,
      );

  void register() async {
    Map<String, dynamic> params = {};
    if (loginType != ClientConfigs.appLoginWithAutoRegister) {
      if (!formKey.currentState!.saveAndValidate()) return;
      params = formKey.currentState!.value;
    }
    if (!isAgreementChecked.value) {
      final b = await DialogUtils.showAlertAgreement();
      onAgreementChecked(b);
    }

    loading.value = true;
    try {
      // 手机号注册逻辑
      if (params.isNotEmpty && IMUtils.isNotNullEmptyStr(params['phone'])) {
        final success = await requestVerificationCode(params['phone'],
            inviteCode: params['inviteCode']);
        loading.value = false;
        Logger.print('---------success-------${params['password']}');
        if (success) {
          AppNavigator.startVerifyPhone(
              areaCode: areaCode.value,
              phoneNumber: params['phone'].trim(),
              usedFor: 1,
              invitationCode: params['inviteCode'],
              password: params['password'],
              registerType: RegisterType.phone);

          return;
        }
      }

      LoginCertificate? result;

      // 账户注册逻辑
      if (params.isNotEmpty && IMUtils.isNotNullEmptyStr(params['account'])) {
        result = await Apis.register(
          nickname: IMUtils.generateRandomString(6),
          account: params['account'].trim(),
          password: params['password'].trim(),
          invitationCode: params['inviteCode'],
          registerType: RegisterType.account,
        );
      }

      // 自动注册登陆逻辑
      if (loginType == ClientConfigs.appLoginWithAutoRegister) {
        result = await Apis.register(
          nickname: IMUtils.generateRandomString(6),
          password: "",
          registerType: RegisterType.autoDevice,
        );
      }

      final userInfo = await Apis.queryMyFullInfo(userID: result?.userID);
      await appLogic.initClientConfig();

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
      AppNavigator.startSetSelfInfo(userInfo);
    } catch (e) {
      Logger.print("e: $e");
    } finally {
      loading.value = false;
    }
  }

  @override
  void onInit() {
    if (loginType == ClientConfigs.appLoginWithUserAndPhone) {
      tabController = TabController(length: 2, vsync: this);
    }
    areaCode.value = getCurrentCountryAreaCode();
    super.onInit();
  }

  @override
  void onClose() {
    tabController?.dispose();
    super.onClose();
  }

  @override
  void onSelectPhoneCode(WorldCountry newCountry) {
    final phoneCode = newCountry.idd.phoneCode();
    Logger.print('Phone code: $phoneCode');
    areaCode.value = phoneCode;
  }
}
