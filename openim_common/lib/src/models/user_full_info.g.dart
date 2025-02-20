// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_full_info.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserFullInfoAdapter extends TypeAdapter<UserFullInfo> {
  @override
  final int typeId = 6;

  @override
  UserFullInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserFullInfo(
      userID: fields[0] as String?,
      password: fields[1] as String?,
      account: fields[2] as String?,
      phoneNumber: fields[3] as String?,
      areaCode: fields[4] as String?,
      nickname: fields[5] as String?,
      remark: fields[6] as String?,
      englishName: fields[7] as String?,
      faceURL: fields[8] as String?,
      gender: fields[9] as int?,
      mobileAreaCode: fields[10] as String?,
      mobile: fields[11] as String?,
      level: fields[12] as int?,
      birth: fields[13] as int?,
      email: fields[14] as String?,
      order: fields[15] as int?,
      status: fields[16] as int?,
      allowAddFriend: fields[17] as int?,
      allowBeep: fields[18] as int?,
      allowVibration: fields[19] as int?,
      forbidden: fields[20] as int?,
      station: fields[22] as String?,
      ex: fields[21] as String?,
      globalRecvMsgOpt: fields[23] as int?,
      isFriendship: fields[24] as bool,
      isBlacklist: fields[25] as bool,
      createTime: fields[26] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, UserFullInfo obj) {
    writer
      ..writeByte(27)
      ..writeByte(0)
      ..write(obj.userID)
      ..writeByte(1)
      ..write(obj.password)
      ..writeByte(2)
      ..write(obj.account)
      ..writeByte(3)
      ..write(obj.phoneNumber)
      ..writeByte(4)
      ..write(obj.areaCode)
      ..writeByte(5)
      ..write(obj.nickname)
      ..writeByte(6)
      ..write(obj.remark)
      ..writeByte(7)
      ..write(obj.englishName)
      ..writeByte(8)
      ..write(obj.faceURL)
      ..writeByte(9)
      ..write(obj.gender)
      ..writeByte(10)
      ..write(obj.mobileAreaCode)
      ..writeByte(11)
      ..write(obj.mobile)
      ..writeByte(12)
      ..write(obj.level)
      ..writeByte(13)
      ..write(obj.birth)
      ..writeByte(14)
      ..write(obj.email)
      ..writeByte(15)
      ..write(obj.order)
      ..writeByte(16)
      ..write(obj.status)
      ..writeByte(17)
      ..write(obj.allowAddFriend)
      ..writeByte(18)
      ..write(obj.allowBeep)
      ..writeByte(19)
      ..write(obj.allowVibration)
      ..writeByte(20)
      ..write(obj.forbidden)
      ..writeByte(21)
      ..write(obj.ex)
      ..writeByte(22)
      ..write(obj.station)
      ..writeByte(23)
      ..write(obj.globalRecvMsgOpt)
      ..writeByte(24)
      ..write(obj.isFriendship)
      ..writeByte(25)
      ..write(obj.isBlacklist)
      ..writeByte(26)
      ..write(obj.createTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserFullInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
