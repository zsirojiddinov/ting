class SearchModel {
  String? statusName;
  String? statusAggregation;
  int packageCount;
  String? packageType;
  String? productName;
  String? ownerName;
  String? productionDate;
  String? producedDate;
  String? code;

  SearchModel({
    this.packageCount = 0,
    this.productName = "",
    this.packageType = "",
    this.statusName = "",
    this.statusAggregation = "",
    this.ownerName = "",
    this.productionDate = "",
    this.producedDate = "",
    this.code = "",
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    return SearchModel(
      packageCount: json['packageCount'] ?? 0,
      productName: json['productName'] ?? "",
      packageType: json['packageType'] ?? "",
      statusName: json['statusName'] ?? "",
      statusAggregation: json['statusAggregation'] ?? "",
      ownerName: json['ownerName'] ?? "",
      productionDate: json['productionDate'] ?? "",
      producedDate: json['producedDate'] ?? "",
      code: json['code'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['packageCount'] = packageCount;
    data['productName'] = productName;
    data['packageType'] = packageType;
    data['statusName'] = statusName;
    data['statusAggregation'] = statusAggregation;
    data['ownerName'] = ownerName;
    data['productionDate'] = productionDate;
    data['producedDate'] = producedDate;
    data['code'] = code;
    return data;
  }
}
