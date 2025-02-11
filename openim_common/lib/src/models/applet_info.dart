import 'dart:convert';

class AppletInfo {
  String? id;
  String? appID;
  String? name;
  String? icon;
  String? url;
  int? status;
  int? isDefault;
  int? priority;

  AppletInfo({
    this.id,
    this.appID,
    this.name,
    this.icon,
    this.url,
    this.status,
    this.isDefault,
    this.priority
  });

  AppletInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    appID = json['appID'];
    name = json['name'];
    icon = json['icon'];
    url = json['url'];
    status = json['status'];
    isDefault = json['isDefault'];
    priority = json['priority'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['appID'] = appID;
    data['name'] = name;
    data['icon'] = icon;
    data['url'] = url;
    data['status'] = status;
    data['isDefault'] = isDefault;
    data['priority'] = priority;
    return data;
  }

  @override
  String toString() {
    return jsonEncode(this);
  }
}
