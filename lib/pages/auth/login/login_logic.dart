import "package:get/get.dart";
import "package:openim/core/controller/app_controller.dart";
import "package:openim/core/controller/im_controller.dart";
import "package:openim/core/mixin/world.dart";
import "package:openim/pages/ua/ua_logic.dart";
import "package:openim/routes/app_navigator.dart";
import "package:openim/utils/dialog.dart";
import "package:flutter/material.dart";
import "package:flutter_form_builder/flutter_form_builder.dart";
import "package:openim_common/openim_common.dart";
import "package:world_countries/world_countries.dart";



class LoginLogic extends GetxController
    with GetTickerProviderStateMixin, WorldMixin {
  final imLogic = Get.find<IMController>();
  final appLogic = Get.find<AppController>();
  final userFormKey = GlobalKey<FormBuilderState>();
  final phoneFormKey = GlobalKey<FormBuilderState>();
  TabController? tabController;

  String get loginType => appLogic.loginType;

  final isAgreementChecked = true.obs; // 默认勾选 用户协议和隐私政策
  final areaCode = "+86".obs;

  final loading = false.obs;

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

  void login() async {
    Map<String, dynamic> params = {};
    if (loginType != ClientConfigs.appLoginWithAutoRegister) {
      GlobalKey<FormBuilderState>? formKey;
      if (loginType == ClientConfigs.appLoginWithUserAndPhone) {
        final index = tabController!.index;
        if (index == 0) {
          formKey = userFormKey;
        } else {
          formKey = phoneFormKey;
        }
      } else if (loginType == ClientConfigs.appLoginWithPhone) {
        formKey = phoneFormKey;
      } else if (loginType == ClientConfigs.appLoginWithUser) {
        formKey = userFormKey;
      }

      if (formKey == null) return;
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
        if (success) {
          AppNavigator.startVerifyPhone(
              areaCode: areaCode.value,
              phoneNumber: params['phone'],
              usedFor: 3,
              invitationCode: params['inviteCode'],
              password: params['password'],
              registerType: RegisterType.phone);

          return;
        }
      }

      LoginCertificate? result;

      // 账户注册逻辑
      if (params.isNotEmpty && IMUtils.isNotNullEmptyStr(params['account'])) {
        result = await Apis.login(
          account: params['account'],
          password: params['password'],
          registerType: RegisterType.account,
        );
      }

      // 自动注册登陆逻辑
      if (loginType == ClientConfigs.appLoginWithAutoRegister) {
        result = await Apis.register(
          nickname: IMUtils.generateRandomString(6),
          registerType: RegisterType.autoDevice,
          password: Config.secret,
        );
      }

      loading.value = false;
      if (null == IMUtils.emptyStrToNull(result?.imToken) ||
          null == IMUtils.emptyStrToNull(result?.chatToken)) {
        return;
      }

      final certificate = result!;

      await DataSp.putLoginCertificate(certificate);
      await imLogic.login(certificate.userID, certificate.imToken);
      Logger.print('---------im login success-------');
      AppNavigator.startMain();
    } catch (e) {
      Logger.print("e: $e");
    } finally {
      loading.value = false;
    }
  }

  @override
  void onSelectPhoneCode(WorldCountry newCountry) {
    final phoneCode = newCountry.idd.phoneCode();
    areaCode.value = phoneCode;
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
}
