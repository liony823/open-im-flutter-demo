class ClientConfigs {
  static const String commonAllow = "1";
  static const String commonDeny = "0";

  // 后台IP白名单
  static const String appIPWhiteList = "app_ip_white_list";
  // app登录类型
  static const String appLoginType = "app_login_type";
  static const String appLoginWithUser = "1";
  static const String appLoginWithPhone = "2";
  static const String appLoginWithUserAndPhone = "3";
  static const String appLoginWithAutoRegister = "4";

  // 敏感词
  static const String appSensitiveWords = "app_sensitive_words";
  // 手机消息撤回
  static const String appMobileMsgWithdraw = "app_mobile_msg_withdraw";
  // 是否禁止更换设备
  static const String appDisableChangeDevice = "app_disable_change_device";
  // 是否开启消息撤回
  static const String appMsgWithdraw = "app_msg_withdraw";

  // 设备限制注册限制数
  static const String appSignupDeviceLimit = "app_signup_device_limit";
  // 单IP12小时注册限制数
  static const String appSigleIpRegisterLimitIn12hour =
      "app_sigle_ip_register_limit_in_12hour";
  // 自动清除几天前历史消息
  static const String appAutoClearHistoryMsg = "app_auto_clear_history_msg";
  // 小程序页
  static const String appMiniProgramVisible = "app_mini_program_visible";
  // 发现页
  static const String appDiscoveryVisible = "app_discovery_visible";
  // 充值和提现
  static const String appChargeAndPayoutVisible =
      "app_charge_and_payout_visible";
  // 语音通话
  static const String appVoiceCallVisible = "app_voice_call_visible";
  // 视频通话
  static const String appVideoCallVisible = "app_video_call_visible";
  // 注册邀请码
  static const String appSignupInviteCodeVisible =
      "app_signup_invite_code_visible";
  // 登录授权码
  static const String appSigninAuthCodeVisible = "app_signin_auth_code_visible";
  // 好友在线状态
  static const String appFriendOnlineStatusVisible =
      "app_friend_online_status_visible";
  // 手机消息已读状态
  static const String appMobileMsgReadStatusVisible =
      "app_mobile_msg_read_status_visible";
  // 签到红包模块
  static const String appSignRedEnvelopeVisible =
      "app_sign_red_envelope_visible";
  // 我的钱包
  static const String appMineWalletVisible = "app_mine_wallet_visible";
  // 钱包提现最小金额
  static const String appWalletPayoutMin = "app_wallet_payout_min";
  // 红包模块
  static const String appRedEnvelopeVisible = "app_red_envelope_visible";
  // 转账模块
  static const String appTransferVisible = "app_transfer_visible";
  // 转账最小金额
  static const String appTransferMinAmount = "app_transfer_min_amount";
  // 手机端编辑消息
  static const String appMobileEditMsg = "app_mobile_edit_msg";
  // 普通群成员查看其他群成员
  static const String appGroupMemberSeeMember = "app_group_member_see_member";
  // 消息时间
  static const String appMsgTimeVisible = "app_msg_time_visible";
  // 置顶会话
  static const String appPinnedConversationSync =
      "app_pinned_conversation_sync";
  // 仅内部号可互加好友
  static const String appOnlyInternalFriendAdd = "app_only_internal_friend_add";
  // 仅内部号可建群
  static const String appOnlyInternalFriendCreateGroup =
      "app_only_internal_friend_create_group";
  // 仅内部号可发群红包
  static const String appOnlyInternalFriendSendGroupRedEnvelope =
      "app_only_internal_friend_send_group_red_envelope";
  // 仅内部号可群内推送名片
  static const String appOnlyInternalFriendSendGroupCard =
      "app_only_internal_friend_send_group_card";
  // 群机器人免消息
  static const String appOnlyInternalFriendGroupRobotFreeMsg =
      "app_only_internal_friend_group_robot_free_msg";
  // 群人数限制
  static const String appGroupMemberLimit = "app_group_member_limit";
  // 用户协议
  static const String appUserAgreementContent = "app_user_agreement_content";
  // 隐私政策
  static const String appPrivacyPolicyContent = "app_privacy_policy_content";
}
