import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_openim_sdk/flutter_openim_sdk.dart';
import 'package:get/get.dart';
import 'package:openim_common/openim_common.dart';
import 'package:sprintf/sprintf.dart';

class Apis {
  static Options get imTokenOptions =>
      Options(headers: {'token': DataSp.imToken});

  static Options get chatTokenOptions =>
      Options(headers: {'token': DataSp.chatToken});

  static StreamController kickoffController = StreamController<int>.broadcast();

  static void _kickoff(int? errCode) {
    if (errCode == 1501 ||
        errCode == 1503 ||
        errCode == 1504 ||
        errCode == 1505) {
      kickoffController.sink.add(errCode);
    }
  }

  static Future<LoginCertificate> login({
    String? areaCode,
    String? phoneNumber,
    String? account,
    String? password,
    String? verificationCode,
    LoginType? loginType,
  }) async {
    try {
      var data = await HttpUtil.post(Urls.login, data: {
        "areaCode": areaCode,
        'phoneNumber': phoneNumber,
        'account': account,
        'password': password,
        'deviceID': DataSp.getDeviceID(),
        'deviceName': DataSp.getDeviceName(),
        'platform': IMUtils.getPlatform(),
        'verifyCode': verificationCode,
        'loginType': loginType?.value,
      });

      final cert = LoginCertificate.fromJson(data!);
      ApiService().setToken(cert.imToken);

      return cert;
    } catch (e, _) {
      final t = e as (int, String?)?;

      if (t == null) {
        Logger.print('e:$e');

        return Future.error(e);
      }
      final errCode = t.$1;
      final errMsg = t.$2;
      _kickoff(errCode);
      Logger.print('e:$errCode s:$errMsg');
      return Future.error(e);
    }
  }

  static Future<LoginCertificate> register({
    required String nickname,
    required String password,
    String? faceURL,
    String? areaCode,
    String? phoneNumber,
    String? account,
    int birth = 0,
    int gender = 1,
    String? verificationCode,
    String? invitationCode,
    RegisterType? registerType,
  }) async {
    try {
      var data = await HttpUtil.post(Urls.register, data: {
        'deviceID': DataSp.getDeviceID(),
        'deviceName': DataSp.getDeviceName(),
        'verifyCode': verificationCode,
        'platform': IMUtils.getPlatform(),
        'invitationCode': invitationCode,
        'autoLogin': true,
        'user': {
          "nickname": nickname,
          "account": account,
          "faceURL": faceURL,
          'birth': birth,
          'gender': gender,
          "areaCode": areaCode,
          'phoneNumber': phoneNumber,
          'password': password,
          'registerType': registerType?.value,
        },
      });

      final cert = LoginCertificate.fromJson(data!);
      ApiService().setToken(cert.imToken);

      return cert;
    } catch (e, s) {
      final t = e as (int, String?);
      final errCode = t.$1;
      final errMsg = t.$2;
      _kickoff(errCode);
      Logger.print('e:$errCode s:$errMsg');
      return Future.error(e);
    }
  }

  static Future<dynamic> resetPassword({
    String? areaCode,
    String? phoneNumber,
    String? email,
    required String password,
    required String verificationCode,
  }) async {
    try {
      return HttpUtil.post(
        Urls.resetPwd,
        data: {
          "areaCode": areaCode,
          'phoneNumber': phoneNumber,
          'email': email,
          'password': password,
          'verifyCode': verificationCode,
          'platform': IMUtils.getPlatform(),
        },
        options: chatTokenOptions,
      );
    } catch (e, s) {
      final t = e as (int, String?);
      final errCode = t.$1;
      final errMsg = t.$2;
      _kickoff(errCode);
      Logger.print('e:$errCode s:$errMsg');
    }
  }

  static Future<bool> changePassword({
    required String userID,
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      await HttpUtil.post(
        Urls.changePwd,
        data: {
          "userID": userID,
          'currentPassword': IMUtils.generateMD5(currentPassword),
          'newPassword': IMUtils.generateMD5(newPassword),
          'platform': IMUtils.getPlatform(),
        },
        options: chatTokenOptions,
      );
      return true;
    } catch (e, s) {
      final t = e as (int, String?);
      final errCode = t.$1;
      final errMsg = t.$2;
      _kickoff(errCode);
      Logger.print('e:$errCode s:$errMsg');
      return false;
    }
  }

  static Future<bool> changePasswordOfB({
    required String newPassword,
  }) async {
    try {
      await HttpUtil.post(
        Urls.resetPwd,
        data: {
          'password': IMUtils.generateMD5(newPassword),
          'platform': IMUtils.getPlatform(),
        },
        options: chatTokenOptions,
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<dynamic> updateUserInfo({
    required String userID,
    String? account,
    String? phoneNumber,
    String? areaCode,
    String? email,
    String? nickname,
    String? faceURL,
    int? gender,
    int? birth,
    int? level,
    int? allowAddFriend,
    int? allowBeep,
    int? allowVibration,
  }) async {
    try {
      Map<String, dynamic> param = {'userID': userID};
      void put(String key, dynamic value) {
        if (null != value) {
          param[key] = value;
        }
      }

      put('account', account);
      put('phoneNumber', phoneNumber);
      put('areaCode', areaCode);
      put('email', email);
      put('nickname', nickname);
      put('faceURL', faceURL);
      put('gender', gender);
      put('gender', gender);
      put('level', level);
      put('birth', birth);
      put('allowAddFriend', allowAddFriend);
      put('allowBeep', allowBeep);
      put('allowVibration', allowVibration);

      return HttpUtil.post(
        Urls.updateUserInfo,
        data: {
          ...param,
          'platform': IMUtils.getPlatform(),
        },
        options: chatTokenOptions,
      );
    } catch (e, s) {
      final t = e as (int, String?);
      final errCode = t.$1;
      final errMsg = t.$2;
      _kickoff(errCode);
      Logger.print('e:$errCode s:$errMsg');
    }
  }

  static Future<List<FriendInfo>> searchFriendInfo(
    String keyword, {
    int pageNumber = 1,
    int showNumber = 10,
  }) async {
    try {
      final data = await HttpUtil.post(
        Urls.searchFriendInfo,
        data: {
          'pagination': {'pageNumber': pageNumber, 'showNumber': showNumber},
          'keyword': keyword,
        },
        options: chatTokenOptions,
      );
      if (data['users'] is List) {
        return (data['users'] as List)
            .map((e) => FriendInfo.fromJson(e))
            .toList();
      }
      return [];
    } catch (e, s) {
      final t = e as (int, String?);
      final errCode = t.$1;
      final errMsg = t.$2;
      _kickoff(errCode);
      Logger.print('e:$errCode s:$errMsg');
      return [];
    }
  }

  static Future<List<UserFullInfo>?> getUserFullInfo({
    int pageNumber = 0,
    int showNumber = 10,
    required List<String> userIDList,
  }) async {
    try {
      final data = await HttpUtil.post(
        Urls.getUsersFullInfo,
        data: {
          'pagination': {'pageNumber': pageNumber, 'showNumber': showNumber},
          'userIDs': userIDList,
          'platform': IMUtils.getPlatform(),
        },
        options: chatTokenOptions,
      );
      if (data['users'] is List) {
        return (data['users'] as List)
            .map((e) => UserFullInfo.fromJson(e))
            .toList();
      }
      return null;
    } catch (e, s) {
      final t = e as (int, String?);
      final errCode = t.$1;
      final errMsg = t.$2;
      _kickoff(errCode);
      Logger.print('e:$errCode s:$errMsg');
      return [];
    }
  }

  static Future<List<UserFullInfo>?> searchUserFullInfo({
    required String content,
    int pageNumber = 1,
    int showNumber = 10,
  }) async {
    try {
      final data = await HttpUtil.post(
        Urls.searchUserFullInfo,
        data: {
          'pagination': {'pageNumber': pageNumber, 'showNumber': showNumber},
          'keyword': content,
        },
        options: chatTokenOptions,
      );
      if (data['users'] is List) {
        return (data['users'] as List)
            .map((e) => UserFullInfo.fromJson(e))
            .toList();
      }
      return null;
    } catch (e, s) {
      final t = e as (int, String?);
      final errCode = t.$1;
      final errMsg = t.$2;
      _kickoff(errCode);
      Logger.print('e:$errCode s:$errMsg');
      return [];
    }
  }

  static Future<UserFullInfo?> queryMyFullInfo({String? userID}) async {
    final list = await Apis.getUserFullInfo(
      userIDList: [userID ?? OpenIM.iMManager.userID],
    );
    return list?.firstOrNull;
  }

  static Future<bool> requestVerificationCode({
    String? areaCode,
    String? phoneNumber,
    required int usedFor,
    String? invitationCode,
  }) async {
    return HttpUtil.post(
      Urls.getVerificationCode,
      data: {
        "areaCode": areaCode,
        "phoneNumber": phoneNumber,
        'usedFor': usedFor,
        'invitationCode': invitationCode
      },
    ).then((value) {
      IMViews.showToast(t.sentSuccessfully);
      return true;
    }).catchError((e, s) {
      Logger.print('e:$e s:$s');
      return false;
    });
  }

  static Future<SignalingCertificate> getTokenForRTC(
      String roomID, String userID) async {
    return HttpUtil.post(
      Urls.getTokenForRTC,
      data: {
        "room": roomID,
        "identity": userID,
      },
      options: chatTokenOptions,
    ).then((value) {
      final signaling = SignalingCertificate.fromJson(value)..roomID = roomID;
      return signaling;
    }).catchError((e, s) {
      Logger.print('e:$e s:$s');
    });
  }

  static Future<dynamic> checkVerificationCode({
    String? areaCode,
    String? phoneNumber,
    String? email,
    required String verificationCode,
    required int usedFor,
    String? invitationCode,
  }) {
    return HttpUtil.post(
      Urls.checkVerificationCode,
      data: {
        "phoneNumber": phoneNumber,
        "areaCode": areaCode,
        "email": email,
        "verifyCode": verificationCode,
        "usedFor": usedFor,
        'invitationCode': invitationCode
      },
    );
  }

  static Future<UpgradeInfoV2> checkUpgradeV2() {
    return dio.post<Map<String, dynamic>>(
      'https://www.pgyer.com/apiv2/app/check',
      options: Options(
        contentType: 'application/x-www-form-urlencoded',
      ),
      data: {
        '_api_key': '',
        'appKey': '',
      },
    ).then((resp) {
      Map<String, dynamic> map = resp.data!;
      if (map['code'] == 0) {
        return UpgradeInfoV2.fromJson(map['data']);
      }
      return Future.error(map);
    });
  }

  static Future<Map<String, dynamic>> getClientConfig() {
    try {
      return HttpUtil.post(
        Urls.getClientConfig,
        options: chatTokenOptions,
      ).then((value) {
        return value['config'] as Map<String, dynamic>;
      });
    } catch (e, s) {
      return Future.error(e);
    }
  }

  static Future<Map<String, dynamic>> getServerConfig() async {
    try {
      return dio
          .get(
        "http://43.163.80.39/PresetConfig.json",
      )
          .then((value) {
        return json.decode(value.toString());
      });
    } catch (e) {
      return Future.error(e);
    }
  }

  static Future<List<AppletInfo>> getAppletList() async {
    try {
      final data = await HttpUtil.post(
        Urls.getApplets,
        options: chatTokenOptions,
      );
      if (data['applets'] is List) {
        return (data['applets'] as List)
            .map((e) => AppletInfo.fromJson(e))
            .toList();
      }
      return [];
    } catch (e) {
      return Future.error(e);
    }
  }

  static Future<AppletInfo?> getApplet(String appID) async {
    try {
      final data = await HttpUtil.post(
        Urls.getApplet,
        data: {"appID": appID},
        options: chatTokenOptions,
      );
      if (data['applet'] != null) {
        return AppletInfo.fromJson(data['applet']);
      }
      return null;
    } catch (e) {
      return Future.error(e);
    }
  }

  static Future<bool> pingServer(String host) async {
    try {
      final data = await dio.get(
        '$host/ping',
        options: Options(
          sendTimeout: const Duration(seconds: 2),
          receiveTimeout: const Duration(seconds: 2),
        ),
      );
      var resp = ApiResp.fromJson(data.data!);
      if (resp.errCode != 0) {
        return false;
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  static void _catchError(Object e, StackTrace s, {bool forceBack = true}) {
    if (e is ApiException) {
      var msg = '${e.code}';
      if (msg.isEmpty || e.code.toString() == msg) {
        msg = e.message ?? 'Unkonw error';
      } else if (e.code == 1004) {
        msg = sprintf(msg, [t.meeting]);
      }

      IMViews.showToast(msg);

      if ((e.code == 10010 || e.code == 10002) && forceBack) {
        DataSp.removeLoginCertificate();
        Get.offAllNamed('/login');
      }
    } else {
      IMViews.showToast(e.toString());
    }
  }
}
