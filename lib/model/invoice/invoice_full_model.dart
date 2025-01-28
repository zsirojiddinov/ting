import 'package:ting/model/invoice/product_model.dart';

class InvoiceFullModel {
  int id;
  String? facturaNumber;
  String? facturaDate;
  int? status;
  String? partnerName;
  List<ProductModel>? products;

  InvoiceFullModel({
    this.id = -1,
    this.facturaDate = "",
    this.facturaNumber = "",
    this.status = 0,
    this.partnerName = "",
    this.products,
  });

  factory InvoiceFullModel.fromJson(Map<String, dynamic> json) {
    return InvoiceFullModel(
      id: json['id'] ?? 0,
      facturaDate: json['facturaDate'] ?? "",
      facturaNumber: json['facturaNumber'] ?? "",
      status: json['status'] ?? 0,
      partnerName: json['partnerName'] ?? "",
      products: json['products'] == null
          ? []
          : ProductModel.fromListJson(json['products']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['facturaDate'] = facturaDate;
    data['facturaNumber'] = facturaNumber;
    data['status'] = status;
    data['partnerName'] = partnerName;
    data['products'] = products;
    return data;
  }
}
