class UserModel {
  bool? success;
  Data? data;

  UserModel({this.success, this.data});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        success: json['success'],
        data: json['data'] != null ? new Data.fromJson(json['data']) : null,
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? photo;
  String? name;
  String? email;

  Data({this.photo, this.name, this.email});

  factory Data.fromJson(Map<String, dynamic> json) =>
      Data(photo: json['photo'], name: json['name'], email: json['email']);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['photo'] = this.photo;
    data['name'] = this.name;
    data['email'] = this.email;
    return data;
  }
}
