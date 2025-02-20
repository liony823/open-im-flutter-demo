import 'package:hive/hive.dart';

part 'user_full_info.g.dart';

@HiveType(typeId: 6)
class UserFullInfo {
  @HiveField(0)
  String? userID;
  @HiveField(1)
  String? password;
  @HiveField(2)
  String? account;
  @HiveField(3)
  String? phoneNumber;
  @HiveField(4)
  String? areaCode;
  @HiveField(5)
  String? nickname;
  @HiveField(6)
  String? remark;
  @HiveField(7)
  String? englishName;
  @HiveField(8)
  String? faceURL;
  @HiveField(9)
  int? gender;
  @HiveField(10)
  String? mobileAreaCode;
  @HiveField(11)
  String? mobile;
  @HiveField(12)
  int? level;
  @HiveField(13)
  int? birth;
  @HiveField(14)
  String? email;
  @HiveField(15)
  int? order;
  @HiveField(16)
  int? status;
  @HiveField(17)
  int? allowAddFriend;
  @HiveField(18)
  int? allowBeep;
  @HiveField(19)
  int? allowVibration;
  @HiveField(20)
  int? forbidden;
  @HiveField(21)
  String? ex;
  @HiveField(22)
  String? station;
  @HiveField(23)
  int? globalRecvMsgOpt;
  @HiveField(24)
  bool isFriendship = false;
  @HiveField(25)
  bool isBlacklist = false;
  @HiveField(26)
  int? createTime;
  @HiveField(27)
  int? registerType;

  bool get isMale => gender == 1;

  String get showName => remark?.isNotEmpty == true
      ? remark!
      : (nickname?.isNotEmpty == true ? nickname! : userID!);

  UserFullInfo({
    this.userID,
    this.password,
    this.account,
    this.phoneNumber,
    this.areaCode,
    this.nickname,
    this.remark,
    this.englishName,
    this.faceURL,
    this.gender,
    this.mobileAreaCode,
    this.mobile,
    this.level,
    this.birth,
    this.email,
    this.order,
    this.status,
    this.allowAddFriend,
    this.allowBeep,
    this.allowVibration,
    this.forbidden,
    this.station,
    this.ex,
    this.globalRecvMsgOpt,
    this.isFriendship = false,
    this.isBlacklist = false,
    this.registerType,
    this.createTime,
  });

  UserFullInfo.fromJson(Map<String, dynamic> json) {
    userID = json['userID'];
    password = json['password'];
    account = json['account'];
    phoneNumber = json['phoneNumber'];
    areaCode = json['areaCode'];
    nickname = json['nickname'];
    remark = json['remark'];
    englishName = json['englishName'];
    faceURL = json['faceURL'];
    gender = json['gender'];
    mobileAreaCode = json['mobileAreaCode'];
    mobile = json['mobile'];
    level = json['level'];
    birth = json['birth'];
    email = json['email'];
    order = json['order'];
    status = json['status'];
    allowAddFriend = json['allowAddFriend'];
    allowBeep = json['allowBeep'];
    allowVibration = json['allowVibration'];
    forbidden = json['forbidden'];
    station = json['station'];
    ex = json['ex'];
    globalRecvMsgOpt = json['globalRecvMsgOpt'];
    isFriendship = json['isFriendship'] ?? false;
    isBlacklist = json['isBlacklist'] ?? false;
    createTime = json['createTime'];
    registerType = json['registerType'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['userID'] = userID;
    data['password'] = password;
    data['account'] = account;
    data['phoneNumber'] = phoneNumber;
    data['areaCode'] = areaCode;
    data['nickname'] = nickname;
    data['remark'] = remark;
    data['englishName'] = englishName;
    data['faceURL'] = faceURL;
    data['gender'] = gender;
    data['mobileAreaCode'] = mobileAreaCode;
    data['level'] = level;
    data['birth'] = birth;
    data['email'] = email;
    data['order'] = order;
    data['status'] = status;
    data['allowAddFriend'] = allowAddFriend;
    data['allowBeep'] = allowBeep;
    data['allowVibration'] = allowVibration;
    data['forbidden'] = forbidden;
    data['station'] = station;
    data['ex'] = ex;
    data['globalRecvMsgOpt'] = globalRecvMsgOpt;
    data['isFriendship'] = isFriendship;
    data['isBlacklist'] = isBlacklist;
    data['createTime'] = createTime;
    data['registerType'] = registerType;
    return data;
  }
}

class DepartmentInfo {
  String? departmentID;
  String? departmentFaceURL;
  String? departmentName;
  String? departmentParentID;
  int? departmentOrder;
  int? departmentDepartmentType;
  String? departmentRelatedGroupID;
  int? departmentCreateTime;
  int? memberOrder;
  String? memberPosition;
  int? memberLeader;
  int? memberStatus;
  int? memberEntryTime;
  int? memberTerminationTime;
  int? memberCreateTime;

  DepartmentInfo(
      {this.departmentID,
      this.departmentFaceURL,
      this.departmentName,
      this.departmentParentID,
      this.departmentOrder,
      this.departmentDepartmentType,
      this.departmentRelatedGroupID,
      this.departmentCreateTime,
      this.memberOrder,
      this.memberPosition,
      this.memberLeader,
      this.memberStatus,
      this.memberEntryTime,
      this.memberTerminationTime,
      this.memberCreateTime});

  DepartmentInfo.fromJson(Map<String, dynamic> json) {
    departmentID = json['departmentID'];
    departmentFaceURL = json['departmentFaceURL'];
    departmentName = json['departmentName'];
    departmentParentID = json['departmentParentID'];
    departmentOrder = json['departmentOrder'];
    departmentDepartmentType = json['departmentDepartmentType'];
    departmentRelatedGroupID = json['departmentRelatedGroupID'];
    departmentCreateTime = json['departmentCreateTime'];
    memberOrder = json['memberOrder'];
    memberPosition = json['memberPosition'];
    memberLeader = json['memberLeader'];
    memberStatus = json['memberStatus'];
    memberEntryTime = json['memberEntryTime'];
    memberTerminationTime = json['memberTerminationTime'];
    memberCreateTime = json['memberCreateTime'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['departmentID'] = departmentID;
    data['departmentFaceURL'] = departmentFaceURL;
    data['departmentName'] = departmentName;
    data['departmentParentID'] = departmentParentID;
    data['departmentOrder'] = departmentOrder;
    data['departmentDepartmentType'] = departmentDepartmentType;
    data['departmentRelatedGroupID'] = departmentRelatedGroupID;
    data['departmentCreateTime'] = departmentCreateTime;
    data['memberOrder'] = memberOrder;
    data['memberPosition'] = memberPosition;
    data['memberLeader'] = memberLeader;
    data['memberStatus'] = memberStatus;
    data['memberEntryTime'] = memberEntryTime;
    data['memberTerminationTime'] = memberTerminationTime;
    data['memberCreateTime'] = memberCreateTime;
    return data;
  }
}
