import 'package:flutter/material.dart';
import 'package:openim_common/openim_common.dart';

class MyTheme {
  static const fontFamily = 'NotoSans';

  static ThemeData lightTheme = ThemeData(
    fontFamily: fontFamily,
    scaffoldBackgroundColor: Styles.c_FFFFFF,
    colorScheme: const ColorScheme.light(primary: Styles.c_0089FF),
  );

  static ThemeData darkTheme = ThemeData(
    fontFamily: fontFamily,
    scaffoldBackgroundColor: Styles.c_0D0D0D,
    colorScheme: const ColorScheme.dark(primary: Styles.c_0089FF),
  );
}
