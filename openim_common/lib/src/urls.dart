import 'config.dart';

class Urls {
  static String get onlineStatus => "${Config.imApiUrl}/manager/get_users_online_status";
  static String get queryAllUsers => "${Config.imApiUrl}/manager/get_all_users_uid";
  static String get updateUserInfo => "${Config.appAuthUrl}/user/update";
  static String get searchFriendInfo => "${Config.appAuthUrl}/friend/search";
  static String get getUsersFullInfo => "${Config.appAuthUrl}/user/find/full";
  static String get searchUserFullInfo => "${Config.appAuthUrl}/user/search/full";

  static String get getVerificationCode => "${Config.appAuthUrl}/account/code/send";
  static String get checkVerificationCode => "${Config.appAuthUrl}/account/code/verify";
  static String get register => "${Config.appAuthUrl}/account/register";

  static String get resetPwd => "${Config.appAuthUrl}/account/password/reset";
  static String get changePwd => "${Config.appAuthUrl}/account/password/change";
  static String get login => "${Config.appAuthUrl}/account/login";

  static String get upgrade => "${Config.appAuthUrl}/app/check";
  static String get getClientConfig => '${Config.appAuthUrl}/client_config/get';
  static String get getTokenForRTC => "${Config.appAuthUrl}/user/rtc/get_token";

  static String get getApplets => "${Config.appAuthUrl}/applet/find";
  static String get getApplet => "${Config.appAuthUrl}/applet/get";
}
