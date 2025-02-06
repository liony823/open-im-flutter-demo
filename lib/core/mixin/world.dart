import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:openim_common/openim_common.dart';
import 'package:world_countries/world_countries.dart';

mixin WorldMixin {
  late CountryPicker picker = CountryPicker(
    separator: const SizedBox.shrink(),
    padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
    searchBarPadding: EdgeInsets.symmetric(horizontal: 16.w),
    onSelect: onSelectPhoneCode,
    itemBuilder: (properties, {bool? isDense}) {
      final locale = properties.context.pickersTheme?.translation ??
          properties.context.maybeLocale;
      final title = locale?.countryTranslations[properties.item] ??
          properties.item.maybeTranslation(locale)?.name ??
          properties.item.name.common;
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            title.toText
              ..style = Styles.ts_333333_17_medium
              ..overflow = TextOverflow.ellipsis,
            Container(
              padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 3.h),
              margin: EdgeInsets.only(right: 12.w),
              decoration: BoxDecoration(
                color: Styles.c_F4F5F7,
                borderRadius: BorderRadius.circular(4.r),
              ),
              child: properties.item.idd.phoneCode().toText
                ..style = Styles.ts_666666_14,
            ),
          ],
        ),
      );
    },
  );

  void onSelectPhoneCode(WorldCountry newCountry);

  void showPhoneCodePicker() {
    final phonePicker = PhoneCodePicker.fromCountryPicker(picker);
    phonePicker.showInModalBottomSheet(Get.context!,
        showDragHandle: true, heightFactor: 0.85);
  }

  WorldCountry? getCurrentCountry() {
    Locale locale = Get.locale ?? const Locale('en', 'US'); // 获取区域设置
    String? countryCode = locale.countryCode; // 获取国家代码
    if (countryCode != null) {
      final country =
          WorldCountry.maybeFromCodeShort(countryCode.toLowerCase());
      Logger.print('Current country: $country');
      return country;
    } else {
      return null;
    }
  }

  String getCurrentCountryAreaCode() {
    return getCurrentCountry()?.idd.phoneCode() ?? "+86";
  }
}
