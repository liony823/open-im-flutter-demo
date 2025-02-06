import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:world_countries/world_countries.dart';
import 'package:get/get.dart';
import 'package:openim_common/openim_common.dart';

import 'core/controller/im_controller.dart';
import 'routes/app_pages.dart';
import 'widgets/app_view.dart';

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppView(
      builder: (locale, builder) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        enableLog: true,
        builder: builder,
        logWriterCallback: Logger.print,
        theme: MyTheme.lightTheme,
        darkTheme: MyTheme.darkTheme,
        translations: TranslationService(),
        localizationsDelegates: const [
          TypedLocaleDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        fallbackLocale: TranslationService.fallbackLocale,
        locale: locale,
        localeResolutionCallback: (locale, list) {
          Get.locale ??= locale;
          return locale;
        },
        supportedLocales: [
          const Locale.fromSubtags(languageCode: "bs", scriptCode: "Cyrl"),
          const Locale.fromSubtags(languageCode: "bs", scriptCode: "Latn"),
          // Classic, string only based locale, or:
          const TypedLocale(LangPor(), country: "PT"), // Loose typed.
          const IsoLocale(LangPor(), country: CountryBra()), // Strict typed.
          for (final locale in kMaterialSupportedLanguages) Locale(locale),
        ],
        getPages: AppPages.routes,
        initialBinding: InitBinding(),
        initialRoute: AppRoutes.splash,
      ),
    );
  }
}

class InitBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<IMController>(IMController());
    Get.put<PushController>(PushController());
    Get.put<CacheController>(CacheController());
    Get.put<DownloadController>(DownloadController());
  }
}
