import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:openim/routes/app_navigator.dart';
import 'package:openim/widgets/agree_ua.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:openim_common/openim_common.dart';
import 'package:world_countries/helpers.dart';
import '../widgets/input_phone_code.dart';
import 'login_logic.dart';
import '../widgets/login_tab.dart';
import '../widgets/login_tabbar.dart';

class LoginPage extends StatelessWidget {
  final logic = Get.find<LoginLogic>();
  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: TouchCloseSoftKeyboard(
        isGradientBg: true,
        child: Obx(() => Column(
              children: [
                SizedBox(
                  height: context.mediaQueryPadding.top,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SwapLangButton(
                      text: context
                          .maybeLocale?.language.namesNative.firstOrNull
                          ?.replaceFirst(RegExp(r'\([^)]*\)'), ''),
                      onTap: logic.toLanguage,
                    ),
                    16.horizontalSpace,
                  ],
                ),
                32.verticalSpace,
                ImageRes.loginLogo.toImage
                  ..width = 64.w
                  ..height = 64.h,
                16.verticalSpace,
                StrRes.welcome.toText..style = Styles.ts_0089FF_17_semibold,
                64.verticalSpace,
                _buildFormView(),
                AgreeUA(
                  isChecked: logic.isAgreementChecked.value,
                  onCheck: logic.onAgreementChecked,
                )
              ],
            )),
      ),
    );
  }

  Widget _buildFormView() {
    if (logic.loginType == ClientConfigs.appLoginWithUserAndPhone) {
      return Expanded(
          child: Column(
        spacing: 24.w,
        children: [
          LoginTabBar(controller: logic.tabController!, tabs: [
            StrRes.loginWithUser,
            StrRes.loginWithPhone,
          ]),
          Expanded(child: _buildLoginWithUserAndPhoneTabView()),
        ],
      ));
    } else if (logic.loginType == ClientConfigs.appLoginWithPhone) {
      return Expanded(
          child: Column(
        spacing: 24.w,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LoginTab(title: StrRes.loginWithPhone),
          _buildPhoneForm(),
        ],
      ));
    } else if (logic.loginType == ClientConfigs.appLoginWithUser) {
      return Expanded(
          child: Column(
        spacing: 24.w,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LoginTab(title: StrRes.loginWithUser),
          _buildUserForm(),
        ],
      ));
    } else if (logic.loginType == ClientConfigs.appLoginWithAutoRegister) {
      return Expanded(
          child: Column(
        spacing: 24.w,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LoginTab(title: StrRes.loginWithAutoRegister),
          _buildAutoRegisterForm(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: _buildLoginButton(),
          ),
        ],
      ));
    }
    return const SizedBox.shrink();
  }

  /// 用户名和手机号登录tabview
  Widget _buildLoginWithUserAndPhoneTabView() {
    return TabBarView(
      controller: logic.tabController,
      children: [
        _buildUserForm(),
        _buildPhoneForm(),
      ],
    );
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
      child: FormBuilder(
        key: logic.phoneFormKey,
        child: Column(
          children: [
            FormInput.phone(
              label: StrRes.phoneNumber,
              labelIcon: EvaIcons.phoneOutline,
              hintText: StrRes.plsEnterPhoneNumber,
              prefixIcon: InputPhoneCode(
                onOpenPicker: logic.showPhoneCodePicker,
                areaCode: logic.areaCode.value,
              ),
              name: "phone",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return StrRes.plsEnterPhoneNumber.tr;
                }
                return null;
              },
            ),
            34.verticalSpace,
            FormInput.password(
              label: StrRes.password,
              labelIcon: EvaIcons.lockOutline,
              hintText: StrRes.plsEnterPassword,
              name: "password",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return StrRes.plsEnterPassword.tr;
                }
                return null;
              },
            ),
            12.verticalSpace,
            _buildFormBottomView(),
            24.verticalSpace,
            _buildLoginButton()
          ],
        ),
      ),
    );
  }

  /// 用户名登录
  Widget _buildUserForm() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
      child: FormBuilder(
        key: logic.userFormKey,
        child: Column(
          children: [
            FormInput(
              label: StrRes.account,
              labelIcon: EvaIcons.personOutline,
              hintText: StrRes.plsEnterAccount,
              name: "account",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return StrRes.plsEnterAccount.tr;
                }
                return null;
              },
            ),
            34.verticalSpace,
            FormInput.password(
              label: StrRes.password,
              labelIcon: EvaIcons.lockOutline,
              hintText: StrRes.plsEnterPassword,
              name: "password",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return StrRes.plsEnterPassword.tr;
                }
                return null;
              },
            ),
            12.verticalSpace,
            _buildFormBottomView(),
            24.verticalSpace,
            _buildLoginButton(),
          ],
        ),
      ),
    );
  }

  /// 登录按钮
  Widget _buildLoginButton() {
    return AdaptiveButton(
      text: StrRes.login,
      onTap: logic.login,
      loading: logic.loading.value,
    );
  }

  /// 忘记密码和立即注册
  Widget _buildFormBottomView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CupertinoButton(
          onPressed: () {},
          child: StrRes.forgetPassword.toText..style = Styles.ts_0089FF_12,
        ),
        CupertinoButton(
            onPressed: () {
              AppNavigator.startRegister();
            },
            child: StrRes.registerNow.toText..style = Styles.ts_2F54EB_12),
      ],
    );
  }
}
