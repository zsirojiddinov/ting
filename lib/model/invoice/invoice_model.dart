class InvoiceModel {
  int id;
  String? facturaNumber;
  String? facturaDate;
  int? status;
  String? partnerName;
  int? productCount;
  int? cisCount;

  InvoiceModel({
    this.id = 0,
    this.facturaDate = "",
    this.facturaNumber = "",
    this.status = 0,
    this.partnerName = "",
    this.productCount = 0,
    this.cisCount = 0,
  });

  factory InvoiceModel.fromJson(Map<String, dynamic> json) {
    return InvoiceModel(
      id: json['id'] ?? 0,
      facturaDate: json['facturaDate'] ?? "",
      facturaNumber: json['facturaNumber'] ?? "",
      status: json['status'] ?? 0,
      partnerName: json['partnerName'] ?? "",
      productCount: json['productCount'] ?? 0,
      cisCount: json['cisCount'] ?? 0,
    );
  }

  static fromListJson(List<dynamic> json) {
    var list = <InvoiceModel>[];
    json.map((elem) {
      list.add(InvoiceModel.fromJson(elem));
    }).toList();

    return list;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['facturaDate'] = facturaDate;
    data['facturaNumber'] = facturaNumber;
    data['status'] = status;
    data['partnerName'] = partnerName;
    data['productCount'] = productCount;
    data['cisCount'] = cisCount;
    return data;
  }
}
