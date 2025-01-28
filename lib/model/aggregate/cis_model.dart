class CisModel {
  int packageCount;
  String? packageType;
  String? code;
  String? statusName;

  CisModel({
    this.packageCount = 0,
    this.code = "",
    this.packageType = "",
    this.statusName = "",
  });

  factory CisModel.fromJson(Map<String, dynamic> json) {
    return CisModel(
      packageCount: json['packageCount'] ?? 0,
      code: json['code'] ?? "",
      packageType: json['packageType'] ?? "",
      statusName: json['statusName'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['packageCount'] = packageCount;
    data['code'] = code;
    data['packageType'] = packageType;
    data['statusName'] = statusName;
    return data;
  }
}
