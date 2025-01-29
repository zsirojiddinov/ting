import 'package:ting/model/auth/role_model.dart';

class LoginModel {
  String? full_name;
  List<RoleModel>? roles;
  String? access_token;

  LoginModel({
    this.full_name = "",
    this.roles,
    this.access_token="",
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      full_name: json['full_name'],
      roles:
          json['roles'] == null ? [] : RoleModel.fromListJson(json['products']),
      access_token: json['access_token'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['full_name'] = full_name;
    data['roles'] = roles;
    data['access_token'] = access_token;
    return data;
  }
}
