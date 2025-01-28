class AddCisResponse {
  int productId;
  int? cisCount;
  int? facturaStatus;


  AddCisResponse({
    this.productId = 0,
    this.cisCount = 0,
    this.facturaStatus = 0,
  });

  factory AddCisResponse.fromJson(Map<String, dynamic> json) {
    return AddCisResponse(
      productId: json['productId'] ?? 0,
      cisCount: json['cisCount'] ?? 0,
      facturaStatus: json['facturaStatus'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productId'] = productId;
    data['cisCount'] = cisCount;
    data['facturaStatus'] = facturaStatus;
    return data;
  }
}
