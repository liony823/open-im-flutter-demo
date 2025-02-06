import 'package:get/get.dart';
import 'package:world_countries/world_countries.dart';

const sortedCountryCodeList = [
  "en",
  "zh",
  "es",
  "fr",
  "de",
  "it",
  "ja",
  "ko",
  "ru",
  "pt",
  "ar",
  "it",
  "tr",
  "vi",
  "th",
  "id",
  "in",
  "my",
];

class LanguageLogic extends GetxController {
  final currentNaturalLanguage = Rxn<NaturalLanguage>();
  final _currentTypedLocale = Rxn<TypedLocale>();

  // 根据 sortedCountryCodeList 排序
  List<NaturalLanguage> get sortedLanguageList {
    List<NaturalLanguage> list = List.from(NaturalLanguage.list);
    list.sort((a, b) {
      final aIndex = sortedCountryCodeList.indexOf(a.codeShort.toLowerCase());
      final bIndex = sortedCountryCodeList.indexOf(b.codeShort.toLowerCase());

      // 如果两个元素都不在 sortedCountryCodeList 中,保持原顺序
      if (aIndex == -1 && bIndex == -1) {
        return 0;
      }

      // 如果只有一个元素在 sortedCountryCodeList 中,将其排在前面
      if (aIndex == -1) return 1;
      if (bIndex == -1) return -1;

      // 如果两个元素都在 sortedCountryCodeList 中,按照列表中的顺序排序
      return aIndex.compareTo(bIndex);
    });
    return list;
  }

  bool isCurrentLanguage(NaturalLanguage language) {
    final currentLanguage = Get.locale?.languageCode ?? "en";
    return currentLanguage == language.codeShort.toLowerCase();
  }

  void onSelectLanguage(NaturalLanguage language) {
    _currentTypedLocale.value = TypedLocale.withTranslationsCache(language);
    Get.updateLocale(language.toLocale());
  }

  String getTranslatedBaseLanguage(NaturalLanguage language) {
    final nativeName = language.namesNative.firstOrNull;
    final locale = _currentTypedLocale.value ??
        Get.context?.pickersTheme?.translation ??
        Get.context?.maybeLocale;
    final title = locale?.languageTranslations[language] ??
        language.maybeTranslation(locale)?.language.name ??
        language.name;
    return "$title-$nativeName";
  }
}
