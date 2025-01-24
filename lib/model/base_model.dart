class BaseModel<T> {
  int? code;
  String? message;
  T? response;

  BaseModel({
    required this.code,
    this.message = "",
    this.response,
  });
  factory BaseModel.fromJson(Map<String, dynamic> json) {
    return BaseModel(
      code: json['code'],
      message: json['message'],
      response: json['response'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['message'] = message;
    data['response'] = response;

    return data;
  }
}
