import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_openim_sdk/flutter_openim_sdk.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:media_kit/media_kit.dart';
import 'package:openim_common/openim_common.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class Config {
  static Future init(Function() runApp) async {
    WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
    await DataSp.init();
    await initServerConfig();
    FlutterNativeSplash.remove();

    try {
      final path = (await getApplicationDocumentsDirectory()).path;
      cachePath = '$path/';
      await Hive.initFlutter(path);
      MediaKit.ensureInitialized();
      HttpUtil.init();
      ApiService().setBaseUrl(serverIp);
    } catch (_) {}

    runApp();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    var brightness = Platform.isAndroid ? Brightness.dark : Brightness.light;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: brightness,
      statusBarIconBrightness: brightness,
    ));

    final packageInfo = await PackageInfo.fromPlatform();
    _appName = packageInfo.appName;
  }

  static late String _appName;

  static late String cachePath;
  static const uiW = 375.0;
  static const uiH = 812.0;

  static const double textScaleFactor = 1.0;

  static const secret = 'feihongim';

  static const allowSendMsgNotFriend = '1';
  // amap key
  static const webKey = 'webKey';
  static const webServerKey = 'webServerKey';
  static const locationHost = 'http://location.your-domain';

  static OfflinePushInfo get offlinePushInfo => OfflinePushInfo(
        title: _appName,
        desc: StrRes.offlineMessage,
        iOSBadgeCount: true,
      );

  static const friendScheme = "io.openim.app/addFriend/";
  static const groupScheme = "io.openim.app/joinGroup/";

  static const _host = "127.0.0.1";

  static bool get _isIP => IP_REG.hasMatch(_host);

  static String get serverIp {
    var ip = DataSp.getServerIP();
    return ip ?? _host;
  }

  static String get chatTokenUrl {
    String? url;
    var server = DataSp.getServerConfig();
    if (null != server) {
      url = server['chatTokenUrl'];
    }
    return url ?? (_isIP ? "http://$serverIp:10009" : "https://$serverIp/chat");
  }

  static String get appAuthUrl {
    String? url;
    var server = DataSp.getServerConfig();
    if (null != server) {
      url = server['authUrl'];
    }
    return url ?? (_isIP ? "http://$serverIp:10008" : "https://$serverIp/chat");
  }

  static String get imApiUrl {
    String? url;
    var server = DataSp.getServerConfig();
    if (null != server) {
      url = server['apiUrl'];
    }
    return url ?? (_isIP ? 'http://$serverIp:10002' : "https://$serverIp/api");
  }

  static String get imWsUrl {
    String? url;
    var server = DataSp.getServerConfig();
    if (null != server) {
      url = server['wsUrl'];
    }
    return url ?? (_isIP ? "ws://$serverIp:10001" : "wss://$serverIp/msg_gateway");
  }

  static int get logLevel {
    String? level;
    var server = DataSp.getServerConfig();
    if (null != server) {
      level = server['logLevel'].toString();
    }
    return level == null ? 5 : int.parse(level);
  }



  static Future<bool> pingServer(String host) async {
    try {
      final url = IP_REG.hasMatch(host) ? 'http://$host:10008' : 'https://$host/chat';
      return await Apis.pingServer(url);
    } catch (e) {
      return false;
    }
  }

  static presetServer(Map<String,dynamic> config)async {
    if (config['server'] != null) {
      final servers = List<Map<String, dynamic>>.from(config['server']);
      for (var server in servers) {
        final isAlive = await pingServer(server['serverIP']);
        if (isAlive) {
          final ip = server['serverIP'];

          final config = {
            'logLevel': server['logLevel'],
            'chatTokenUrl': IP_REG.hasMatch(ip) ? 'http://$ip:10009' : 'https://$ip/chat',
            'authUrl': IP_REG.hasMatch(ip) ? 'http://$ip:10008' : 'https://$ip/chat',
            'apiUrl': IP_REG.hasMatch(ip) ? 'http://$ip:10002' : 'https://$ip/api',
            'wsUrl': IP_REG.hasMatch(ip) ? 'ws://$ip:10001' : 'wss://$ip/msg_gateway',
          };
 
          DataSp.putServerConfig(config);
          DataSp.putServerIP(ip);
          return;
        }
      }
    }
  }

  static Future initServerConfig() async {
    final config = await Apis.getServerConfig();
    await presetServer(config);
  }
}
