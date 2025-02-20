import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:openim/routes/app_navigator.dart';
import 'package:openim/widgets/user_agreement_with_privacy_policy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:openim_common/openim_common.dart';
import 'package:world_countries/helpers.dart';
import '../widgets/input_phone_code.dart';
import 'register_logic.dart';
import '../widgets/login_tab.dart';
import '../widgets/login_tabbar.dart';

class RegisterPage extends StatelessWidget {
  final logic = Get.find<RegisterLogic>();
  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: TouchCloseSoftKeyboard(
          isGradientBg: true,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Obx(() => SingleChildScrollView(
                  child: Column(
                    spacing: 32.w,
                    children: [
                      TitleBar.back(
                          leftTitle: StrRes.registerTitle,
                          backgroundColor: Colors.transparent,
                          right: Padding(
                            padding: EdgeInsets.only(right: 16.w),
                            child: SwapLangButton(
                              text: context
                                  .maybeLocale?.language.namesNative.firstOrNull
                                  ?.replaceFirst(RegExp(r'\([^)]*\)'), ''),
                              onTap: logic.toLanguage,
                            ),
                          )),
                      _buildFormView(),
                    ],
                  ),
                )),
            bottomSheet: Padding(
              padding: EdgeInsets.only(
                  top: 12.w, bottom: context.mediaQueryPadding.bottom + 12.w),
              child: UserAgreementWithPrivacyPolicy(
                isChecked: logic.isAgreementChecked.value,
                onCheck: logic.onAgreementChecked,
                onTapUserAgreement: logic.toUserAgreement,
                onTapPrivacyPolicy: logic.toPrivacyPolicy,
              ),
            ),
          )),
    );
  }

  Widget _buildFormView() {
    if (logic.loginType == ClientConfigs.appLoginWithUserAndPhone) {
      return Column(
        spacing: 24.w,
        children: [
          LoginTabBar(controller: logic.tabController!, tabs: [
            StrRes.registerWithUser,
            StrRes.registerWithPhone,
          ]),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
            child: FormBuilder(
              key: logic.formKey,
              child: Column(
                spacing: 26.w,
                children: [
                  SizedBox(
                      height: 102.h,
                      child: TabBarView(
                          controller: logic.tabController,
                          children: [
                            _buildUserForm(),
                            _buildPhoneForm(),
                          ])),
                  ..._buildCommonForm(),
                ],
              ),
            ),
          ),
        ],
      );
    } else if (logic.loginType == ClientConfigs.appLoginWithPhone) {
      return Column(
        spacing: 26.w,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LoginTab(title: StrRes.registerWithPhone),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
            child: FormBuilder(
              key: logic.formKey,
              child: Column(
                spacing: 26.w,
                children: [
                  _buildPhoneForm(),
                  ..._buildCommonForm(),
                ],
              ),
            ),
          ),
        ],
      );
    } else if (logic.loginType == ClientConfigs.appLoginWithUser) {
      return Column(
        spacing: 26.w,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LoginTab(title: StrRes.registerWithUser),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
            child: FormBuilder(
              key: logic.formKey,
              child: Column(
                spacing: 26.w,
                children: [
                  _buildUserForm(),
                  ..._buildCommonForm(),
                ],
              ),
            ),
          ),
        ],
      );
    } else if (logic.loginType == ClientConfigs.appLoginWithAutoRegister) {
      return Column(
        spacing: 26.w,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LoginTab(title: StrRes.loginWithAutoRegister),
          _buildAutoRegisterForm(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: _buildRegisterButton(),
          ),
        ],
      );
    }
    return const SizedBox.shrink();
  }

  /// 自动注册登录
  Widget _buildAutoRegisterForm() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
      child: SizedBox(
        width: double.infinity,
        child: Card.filled(
          elevation: 5,
          shadowColor: Styles.c_0089FF.withValues(alpha: .05),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 36.w, vertical: 18.h),
            child: Center(
              child: StrRes.loginWithAutoRegisterHint.toText
                ..style = Styles.ts_000033_14_medium,
            ),
          ),
        ),
      ),
    );
  }

  /// 手机号登录
  Widget _buildPhoneForm() {
    return FormInput.phone(
      label: StrRes.phoneNumber,
      labelIcon: EvaIcons.phoneOutline,
      hintText: StrRes.plsEnterPhoneNumber,
      name: "phone",
      textInputAction: TextInputAction.next,
      prefixIcon: InputPhoneCode(
        onOpenPicker: logic.showPhoneCodePicker,
        areaCode: logic.areaCode.value,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return StrRes.plsEnterPhoneNumber;
        }
        return null;
      },
    );
  }

  /// 用户名登录
  Widget _buildUserForm() {
    return FormInput(
      label: StrRes.account,
      labelIcon: EvaIcons.personOutline,
      hintText: StrRes.plsEnterAccount,
      name: "account",
      textInputAction: TextInputAction.next,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return StrRes.plsEnterAccount;
        }
        if (!ACCOUNT_REG.hasMatch(value)) {
          return StrRes.accountFormatError;
        }
        return null;
      },
    );
  }

  List<Widget> _buildCommonForm() {
    return [
      FormInput.password(
        controller: logic.passwordController,
        label: StrRes.password,
        labelIcon: EvaIcons.lockOutline,
        hintText: StrRes.plsEnterPassword,
        name: "password",
        textInputAction: TextInputAction.next,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return StrRes.plsEnterPassword;
          }
          if (!IMUtils.isValidPassword(value)) {
            return StrRes.passwordFormatError;
          }
          return null;
        },
      ),
      FormInput.password(
        label: StrRes.confirmPassword,
        labelIcon: EvaIcons.lockOutline,
        hintText: StrRes.plsConfirmPasswordAgain,
        name: "confirmPassword",
        textInputAction: TextInputAction.done,
        onSubmitted: (_) => logic.register(),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return StrRes.plsConfirmPasswordAgain;
          }
          if (value != logic.passwordController.text.trim()) {
            return StrRes.twicePwdNoSame;
          }
          return null;
        },
      ),
      if (logic.inviteCodeVisible)
        FormInput(
          label: StrRes.invitationCode,
          labelIcon: EvaIcons.emailOutline,
          hintText: StrRes.plsEnterInvitationCode,
          name: "inviteCode",
          validator: (value) {
            if (value == null || value.isEmpty) {
              return StrRes.plsEnterInvitationCode;
            }
            return null;
          },
        ),
      // 16.verticalSpace,
      _buildRegisterButton(),
    ];
  }

  /// 登录按钮
  Widget _buildRegisterButton() {
    return AdaptiveButton(
      text: StrRes.registerNow,
      onTap: logic.register,
      loading: logic.loading.value,
    );
  }
}
