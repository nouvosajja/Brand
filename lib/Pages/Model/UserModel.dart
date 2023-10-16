class UserModel {
  bool? success;
  Data? data;

  UserModel({this.success, this.data});

  UserModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

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
  late String name;
  String? email;

  Data({this.photo, required this.name, this.email});

  Data.fromJson(Map<String, dynamic> json) {
    photo = json['photo'];
    name = json['name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['photo'] = this.photo;
    data['name'] = this.name;
    data['email'] = this.email;
    return data;
  }
}
