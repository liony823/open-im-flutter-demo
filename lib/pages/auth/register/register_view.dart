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
                          leftTitle: context.t.registerTitle,
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
                      _buildFormView(context),
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

  Widget _buildFormView(BuildContext context) {
    if (logic.loginType == ClientConfigs.appLoginWithUserAndPhone) {
      return Column(
        spacing: 24.w,
        children: [
          LoginTabBar(controller: logic.tabController!, tabs: [
            context.t.registerWithUser,
            context.t.registerWithPhone,
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
                            _buildUserForm(context),
                            _buildPhoneForm(context),
                          ])),
                  ..._buildCommonForm(context),
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
          LoginTab(title: context.t.registerWithPhone),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
            child: FormBuilder(
              key: logic.formKey,
              child: Column(
                spacing: 26.w,
                children: [
                  _buildPhoneForm(context),
                  ..._buildCommonForm(context),
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
          LoginTab(title: context.t.registerWithUser),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
            child: FormBuilder(
              key: logic.formKey,
              child: Column(
                spacing: 26.w,
                children: [
                  _buildUserForm(context),
                  ..._buildCommonForm(context),
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
          LoginTab(title: context.t.loginWithAutoRegister),
          _buildAutoRegisterForm(context),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: _buildRegisterButton(context),
          ),
        ],
      );
    }
    return const SizedBox.shrink();
  }

  /// 自动注册登录
  Widget _buildAutoRegisterForm(BuildContext context) {
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
              child: (context.t.loginWithAutoRegisterHint).toText
                ..style = Styles.ts_000033_14_medium,
            ),
          ),
        ),
      ),
    );
  }

  /// 手机号登录
  Widget _buildPhoneForm(BuildContext context) {
    return FormInput.phone(
      label: context.t.phoneNumber,
      labelIcon: EvaIcons.phoneOutline,
      hintText: context.t.plsEnterPhoneNumber,
      name: "phone",
      textInputAction: TextInputAction.next,
      prefixIcon: InputPhoneCode(
        onOpenPicker: logic.showPhoneCodePicker,
        areaCode: logic.areaCode.value,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return context.t.plsEnterPhoneNumber;
        }
        return null;
      },
    );
  }

  /// 用户名登录
  Widget _buildUserForm(BuildContext context) {
    return FormInput(
      label: context.t.account,
      labelIcon: EvaIcons.personOutline,
      hintText: context.t.plsEnterAccount,
      name: "account",
      textInputAction: TextInputAction.next,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return context.t.plsEnterAccount;
        }
        if (!ACCOUNT_REG.hasMatch(value)) {
          return context.t.accountFormatError;
        }
        return null;
      },
    );
  }

  List<Widget> _buildCommonForm(BuildContext context) {
    return [
      FormInput.password(
        controller: logic.passwordController,
        label: context.t.password,
        labelIcon: EvaIcons.lockOutline,
        hintText: context.t.plsEnterPassword,
        name: "password",
        textInputAction: TextInputAction.next,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return context.t.plsEnterPassword;
          }
          if (!IMUtils.isValidPassword(value)) {
            return context.t.passwordFormatError;
          }
          return null;
        },
      ),
      FormInput.password(
        label: context.t.confirmPassword,
        labelIcon: EvaIcons.lockOutline,
        hintText: context.t.plsConfirmPasswordAgain,
        name: "confirmPassword",
        textInputAction: TextInputAction.done,
        onSubmitted: (_) => logic.register(),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return context.t.plsConfirmPasswordAgain;
          }
          if (value != logic.passwordController.text.trim()) {
            return context.t.twicePwdNoSame;
          }
          return null;
        },
      ),
      if (logic.inviteCodeVisible)
        FormInput(
          label: context.t.invitationCode,
          labelIcon: EvaIcons.emailOutline,
          hintText: context.t.plsEnterInvitationCode,
          name: "inviteCode",
          validator: (value) {
            if (value == null || value.isEmpty) {
              return context.t.plsEnterInvitationCode;
            }
            return null;
          },
        ),
      // 16.verticalSpace,
      _buildRegisterButton(context),
    ];
  }

  /// 登录按钮
  Widget _buildRegisterButton(BuildContext context) {
    return AdaptiveButton(
      text: context.t.registerNow,
      onTap: logic.register,
      loading: logic.loading.value,
    );
  }
}
