import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:openim/routes/app_navigator.dart';
import 'package:openim/widgets/user_agreement_with_privacy_policy.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:openim_common/openim_common.dart';
import 'package:world_countries/helpers.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'login_logic.dart';
import '../widgets/input_phone_code.dart';
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
                52.verticalSpace,
                _buildFormView(),
                UserAgreementWithPrivacyPolicy(
                  isChecked: logic.isAgreementChecked.value,
                  onCheck: logic.onAgreementChecked,
                  onTapUserAgreement: logic.toUserAgreement,
                  onTapPrivacyPolicy: logic.toPrivacyPolicy,
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
              textInputAction: TextInputAction.next,
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
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => logic.login(),
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
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      child: FormBuilder(
        key: logic.userFormKey,
        child: Column(
          children: [
            TypeAheadField<UserFullInfo>(
              suggestionsCallback: (search) => logic.getUserList(search),
              onSelected: (UserFullInfo item) => logic.onUserSelected(item),
              itemBuilder: (context, item) => Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6).w,
                child: Row(
                  children: [
                    AvatarView(
                      url: item.faceURL,
                      text: item.nickname,
                      isCircle: true,
                      width: 32.w,
                      height: 32.h,
                    ),
                    16.horizontalSpace,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          spacing: 8.w,
                          children: [
                            StrRes.account.toText..style = Styles.ts_999999_10,
                            (item.account ?? '').toText
                              ..style = Styles.ts_333333_14,
                          ],
                        ),
                        Row(
                          spacing: 8.w,
                          children: [
                            StrRes.nickname.toText..style = Styles.ts_999999_10,
                            (item.nickname ?? '').toText
                              ..style = Styles.ts_333333_12,
                          ],
                        ),
                      ],
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () => logic.onUserClose(item),
                      icon: Icon(
                        EvaIcons.close,
                        size: 20.w,
                      ),
                    )
                  ],
                ),
              ),
              emptyBuilder: (context) => const SizedBox.shrink(),
              builder: (context, controller, focusNode) => FormInput(
                controller: controller,
                focusNode: focusNode,
                label: StrRes.account,
                labelIcon: EvaIcons.personOutline,
                hintText: StrRes.plsEnterAccount,
                textInputAction: TextInputAction.next,
                name: "account",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return StrRes.plsEnterAccount.tr;
                  }
                  return null;
                },
              ),
            ),
            34.verticalSpace,
            FormInput.password(
              label: StrRes.password,
              labelIcon: EvaIcons.lockOutline,
              hintText: StrRes.plsEnterPassword,
              textInputAction: TextInputAction.done,
              name: "password",
              onSubmitted: (_) => logic.login(),
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
          onPressed: AppNavigator.startForgetPassword,
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
