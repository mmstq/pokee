class UserModel {
  String? id;
  String? displayName;
  String? userName;
  String? phoneNumber;

  UserModel({this.id, this.displayName, this.userName, this.phoneNumber});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    displayName = json['display_name'];
    userName = json['user_name'];
    phoneNumber = json['phone_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['display_name'] = displayName;
    data['user_name'] = userName;
    data['phone_number'] = phoneNumber;
    return data;
  }
}
