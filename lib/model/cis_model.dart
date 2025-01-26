class CisModel {
  int packageCount;
  String? packageType;
  String? code;
  bool? accept;

  CisModel({
    this.packageCount = 0,
    this.code = "",
    this.accept = false,
    this.packageType = "",
  });

  factory CisModel.fromJson(Map<String, dynamic> json) {
    return CisModel(
      packageCount: json['packageCount'] ?? 0,
      code: json['code'] ?? "",
      accept: json['accept'] ?? false,
      packageType: json['packageType'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['packageCount'] = packageCount;
    data['code'] = code;
    data['accept'] = accept;
    data['packageType'] = packageType;

    return data;
  }
}
