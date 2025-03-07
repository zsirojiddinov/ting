class ProductModel {
  int productId;
  String? productName;
  int? productCount;
  int? cisCount;
  int? groupCount;
  int? productGroupCount;

  ProductModel({
    this.productId = 0,
    this.productName = "",
    this.productCount = 0,
    this.cisCount = 0,
    this.groupCount = 0,
    this.productGroupCount = 0,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      productId: json['productId'] ?? 0,
      productName: json['productName'] ?? "",
      productCount: json['productCount'] ?? 0,
      cisCount: json['cisCount'] ?? 0,
      groupCount: json['groupCount'] ?? 0,
      productGroupCount: json['productGroupCount'] ?? 0,
    );
  }

  static fromListJson(List<dynamic> json) {
    var list = <ProductModel>[];
    json.map((elem) {
      list.add(ProductModel.fromJson(elem));
    }).toList();

    return list;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productId'] = productId;
    data['productName'] = productName;
    data['productCount'] = productCount;
    data['cisCount'] = cisCount;
    data['groupCount'] = groupCount;
    data['productGroupCount'] = productGroupCount;
    return data;
  }
}
