
class LoginModel {
  String? full_name;
  String? phone;
  String? access_token;

  LoginModel({
    this.full_name = "",
    this.phone = "",
    this.access_token="",
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      full_name: json['full_name'],
      phone: json['phone'],
      access_token: json['access_token'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['full_name'] = full_name;
    data['phone'] = phone;
    data['access_token'] = access_token;
    return data;
  }
}
