import "package:get/get.dart";
import "package:openim/core/controller/app_controller.dart";
import "package:openim/core/controller/im_controller.dart";
import "package:openim/core/mixin/world.dart";
import "package:openim/pages/conversation/conversation_logic.dart";
import "package:openim/pages/webview/webview_logic.dart";
import "package:openim/routes/app_navigator.dart";
import "package:openim/utils/dialog.dart";
import "package:flutter/material.dart";
import "package:flutter_form_builder/flutter_form_builder.dart";
import "package:openim_common/openim_common.dart";
import "package:world_countries/world_countries.dart";

class LoginLogic extends GetxController
    with GetTickerProviderStateMixin, WorldMixin {
  final cacheController = Get.find<CacheController>();
  final imLogic = Get.find<IMController>();
  final appLogic = Get.find<AppController>();
  final userFormKey = GlobalKey<FormBuilderState>();
  final phoneFormKey = GlobalKey<FormBuilderState>();
  TabController? tabController;

  String get loginType => appLogic.loginType;

  final selectedUser = Rxn<UserFullInfo>();

  final isAgreementChecked = true.obs; // 默认勾选 用户协议和隐私政策
  final areaCode = "+86".obs;

  final loading = false.obs;

  void onAgreementChecked(bool? value) {
    isAgreementChecked.value = value ?? false;
  }

  void toUserAgreement() {
    AppNavigator.startWebView(
      title: StrRes.userAgreement,
      content: appLogic.userAgreement,
    );
  }

  void toPrivacyPolicy() {
    AppNavigator.startWebView(
      title: StrRes.privacyPolicy,
      content: appLogic.privacyPolicy,
    );
  }

  void toLanguage() {
    AppNavigator.startLanguage();
  }

  void login() async {
    if (loginType == ClientConfigs.appLoginWithAutoRegister) {
      _autoRegisterLogin();
      return;
    }

    final formKey = _getFormKey();
    if (formKey == null || !formKey.currentState!.saveAndValidate()) return;

    final params = formKey.currentState!.value;
    _checkAgreementAndLogin(params);
  }

  GlobalKey<FormBuilderState>? _getFormKey() {
    if (loginType == ClientConfigs.appLoginWithUserAndPhone) {
      return tabController!.index == 0 ? userFormKey : phoneFormKey;
    } else if (loginType == ClientConfigs.appLoginWithPhone) {
      return phoneFormKey;
    } else if (loginType == ClientConfigs.appLoginWithUser) {
      return userFormKey;
    }
    return null;
  }

  void _autoRegisterLogin() async {
    loading.value = true;
    try {
      final result = await Apis.register(
        nickname: IMUtils.generateRandomString(6),
        password: "",
        registerType: RegisterType.autoDevice,
      );
      _loginSuccess(result, {});
    } catch (e) {
      Logger.print("e: $e");
    } finally {
      loading.value = false;
    }
  }

  void _checkAgreementAndLogin(Map<String, dynamic> params) async {
    if (!isAgreementChecked.value) {
      final b = await DialogUtils.showAlertAgreement(
        toUserAgreement,
        toPrivacyPolicy,
      );
      onAgreementChecked(b);
      return;
    }

    loading.value = true;
    try {
      final result = await _performLogin(params);
      _loginSuccess(result!, params);
    } catch (e) {
      Logger.print("e: $e");
    } finally {
      loading.value = false;
    }
  }

  Future<LoginCertificate?> _performLogin(Map<String, dynamic> params) async {
    LoginCertificate? certificate;
    if (selectedUser.value != null) {
      certificate = await _loginWithSelectedUser();
    } else {
      certificate = await _loginWithoutSelectedUser(params);
    }
    return certificate;
  }

  Future<LoginCertificate?> _loginWithSelectedUser() async {
    if (selectedUser.value?.registerType == RegisterType.account.value) {
      return await Apis.login(
        account: selectedUser.value!.account!,
        password: selectedUser.value!.password!,
        loginType: LoginType.account,
      );
    } else if (selectedUser.value?.registerType == RegisterType.phone.value) {
      return await Apis.login(
        phoneNumber: selectedUser.value!.phoneNumber,
        password: selectedUser.value!.password!,
        loginType: LoginType.phone,
        areaCode: areaCode.value,
      );
    } else {
      if (selectedUser.value?.phoneNumber != null &&
          selectedUser.value?.areaCode != null) {
        return await Apis.login(
          phoneNumber: selectedUser.value!.phoneNumber,
          password: selectedUser.value!.password!,
          areaCode: selectedUser.value!.areaCode,
          loginType: LoginType.phone,
        );
      }
    }
    return null;
  }

  Future<LoginCertificate?> _loginWithoutSelectedUser(
      Map<String, dynamic> params) async {
    if (params.containsKey('phone') &&
        IMUtils.isNotNullEmptyStr(params['phone'])) {
      return await Apis.login(
        areaCode: areaCode.value,
        phoneNumber: params['phone'],
        password: params['password'],
        loginType: LoginType.phone,
      );
    } else {
      return await Apis.login(
        account: params['account'],
        password: params['password'],
        loginType: LoginType.account,
      );
    }
  }

  void _loginSuccess(
      LoginCertificate result, Map<String, dynamic> params) async {
    final certificate = result;
    DataSp.putLoginCertificate(certificate);
    imLogic.login(
        certificate.userID, certificate.imToken, params['password'] ?? '');
    Logger.print('---------im login success-------');
    final conversations = await ConversationLogic.getConversationFirstPage();
    Get.find<CacheController>().resetCache();
    AppNavigator.startMain(isAutoLogin: true, conversations: conversations);
  }

  List<UserFullInfo> getUserList(String search) {
    return cacheController.accountList
        .where((element) =>
            element.account!.contains(search) ||
            element.nickname!.contains(search) ||
            element.userID!.contains(search))
        .toList();
  }

  void onUserSelected(UserFullInfo user) {
    GlobalKey<FormBuilderState>? formKey;
    String fieldKey = 'account';
    if (loginType == ClientConfigs.appLoginWithUserAndPhone) {
      final index = tabController!.index;
      formKey = index == 0 ? userFormKey : phoneFormKey;
      fieldKey = index == 0 ? 'account' : 'phone';
    } else if (loginType == ClientConfigs.appLoginWithPhone) {
      formKey = phoneFormKey;
      fieldKey = 'phone';
    } else if (loginType == ClientConfigs.appLoginWithUser) {
      formKey = userFormKey;
      fieldKey = 'account';
    }
    final formState = formKey?.currentState;
    if (formState == null) return;
    selectedUser.value = user;
    formState.patchValue({
      fieldKey: user.account ?? user.phoneNumber,
      'password': user.password,
    });

    login();
  }

  void onUserClose(UserFullInfo user) async {
    await cacheController.delAccount(user.userID!);
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
