class Constants {
  static const String appName = "FeihongIM";
}

enum RegisterType {
  account(0),
  phone(1),
  autoDevice(2);

  final int value;
  const RegisterType(this.value);

  static RegisterType fromRawValue(int rawValue) {
    return values.firstWhere((e) => e.value == rawValue);
  }
}

enum LoginType {
  account(0),
  phone(1),
  autoDevice(2);

  final int value;

  const LoginType(this.value);

  static LoginType fromRawValue(int rawValue) {
    return values.firstWhere((e) => e.value == rawValue);
  }
}
