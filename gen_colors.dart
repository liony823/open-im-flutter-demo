import 'dart:io';

void main() {
  final colors = [
    {'name': 'c_0089FF', 'value': '0xFF0089FF'},
    {'name': 'c_2F54EB', 'value': '0xFF2F54EB'},
    {'name': 'c_0C1C33', 'value': '0xFF0C1C33'},
    {'name': 'c_8E9AB0', 'value': '0xFF8E9AB0'},
    {'name': 'c_DE473E', 'value': '0xFFDE473E'},
    {'name': 'c_F55545', 'value': '0xFFF55545'},
    {'name': 'c_CFAC74', 'value': '0xFFCFAC74'},
    {'name': 'c_FFFFFF', 'value': '0xFFFFFFFF'},
    {'name': 'c_F1F1F1', 'value': '0xFFF1F1F1'},
    {'name': 'c_0D0D0D', 'value': '0xFF0D0D0D'},
    {'name': 'c_161616', 'value': '0xFF161616'},
    {'name': 'c_1B1B1B', 'value': '0xFF1B1B1B'},
    {'name': 'c_121212', 'value': '0xFF121212'},
    {'name': 'c_222222', 'value': '0xFF222222'},
    {'name': 'c_333333', 'value': '0xFF333333'},
    {'name': 'c_555555', 'value': '0xFF555555'},
    {'name': 'c_666666', 'value': '0xFF666666'},
    {'name': 'c_777777', 'value': '0xFF777777'},
    {'name': 'c_999999', 'value': '0xFF999999'},
    {'name': 'c_CCCCCC', 'value': '0xFFCCCCCC'},
    {'name': 'c_F3F3F3', 'value': '0xFFF3F3F3'},
    {'name': 'c_F6F6F6', 'value': '0xFFF6F6F6'},
    {'name': 'c_F9F9F9', 'value': '0xFFF9F9F9'},
    {'name': 'c_EDEDED', 'value': '0xFFEDEDED'},
    {'name': 'c_262626', 'value': '0xFF262626'},
    {'name': 'c_E3E3E3', 'value': '0xFFE3E3E3'},
    {'name': 'c_E6E6E6', 'value': '0xFFE6E6E6'},
    {'name': 'c_FAC576', 'value': '0xFFFAC576'},
    {'name': 'c_CA2B1B', 'value': '0xFFCA2B1B'},
    {'name': 'c_F84938', 'value': '0xFFF84938'},
    {'name': 'c_E8EAEF', 'value': '0xFFE8EAEF'},
    {'name': 'c_FF381F', 'value': '0xFFFF381F'},
    {'name': 'c_18E875', 'value': '0xFF18E875'},
    {'name': 'c_F0F2F6', 'value': '0xFFF0F2F6'},
    {'name': 'c_000000', 'value': '0xFF000000'},
    {'name': 'c_92B3E0', 'value': '0xFF92B3E0'},
    {'name': 'c_F2F8FF', 'value': '0xFFF2F8FF'},
    {'name': 'c_F8F9FA', 'value': '0xFFF8F9FA'},
    {'name': 'c_6085B1', 'value': '0xFF6085B1'},
    {'name': 'c_FFB300', 'value': '0xFFFFB300'},
    {'name': 'c_FFE1DD', 'value': '0xFFFFE1DD'},
    {'name': 'c_CCE7FE', 'value': '0xFFCCE7FE'},
    {'name': 'c_F4F5F7', 'value': '0xFFF4F5F7'},
    {'name': 'c_000033', 'value': '0xFF000033'},
  ];

  final fontSizes = [24, 21, 20, 17, 16, 14, 12, 10];
  final fontWeights = [
    {'name': 'bold', 'value': 'FontWeight.bold'},
    {'name': 'semibold', 'value': 'FontWeight.w600'},
    {'name': 'medium', 'value': 'FontWeight.w500'},
    {'name': '', 'value': 'FontWeight.w400'},
  ];

  final buffer = StringBuffer();
  buffer.writeln('import \'package:flutter/material.dart\';');
  buffer.writeln(
      'import \'package:flutter_screenutil/flutter_screenutil.dart\';');
  buffer.writeln('import \'package:openim_common/openim_common.dart\';');

  buffer.writeln();
  buffer.writeln('class Styles {');

  buffer.writeln('Styles._();');

  buffer.writeln();

  for (var color in colors) {
    buffer.writeln(
        '  static const Color ${color['name']} = Color(${color['value']});');
  }

  for (var color in colors) {
    for (var size in fontSizes) {
      for (var weight in fontWeights) {
        final styleName = weight['name']!.isEmpty
            ? 'ts_${color['name']?.substring(2)}_$size'
            : 'ts_${color['name']?.substring(2)}_${size}_${weight['name']}';
        buffer.writeln(
            '  static TextStyle $styleName = TextStyle(color: Styles.${color['name']}, fontSize: $size.sp, fontWeight: ${weight['value']}, fontFamily: MyTheme.fontFamily, package: "openim_common");');
      }
    }
  }

  buffer.writeln('}');

  final outputFile = File('./styles.dart');
  outputFile.writeAsStringSync(buffer.toString());
}
