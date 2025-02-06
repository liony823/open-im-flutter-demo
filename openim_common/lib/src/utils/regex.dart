// ignore_for_file: non_constant_identifier_names

final PASSWORD_REG = RegExp(r'^[a-zA-Z0-9]{6,18}$'); // 6-18位字母或数字
final ACCOUNT_REG =
    RegExp(r'^[a-zA-Z][a-zA-Z0-9_]{4,20}$'); // 字母开头, 字母、数字、下划线组合, 4-20个字符
final NICKNAME_REG = RegExp(r'^[^\s]{2,20}$'); // 2-20个字符
