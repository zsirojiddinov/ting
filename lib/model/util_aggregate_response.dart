class UtilAggregateResponse {
  int utilId;
  String? utilStatus;
  String? aggStatus;

  UtilAggregateResponse({
    this.utilId = 0,
    this.aggStatus = "",
    this.utilStatus = "",
  });

  factory UtilAggregateResponse.fromJson(Map<String, dynamic> json) {
    return UtilAggregateResponse(
      utilId: json['utilId'] ?? 0,
      aggStatus: json['aggStatus'] ?? "",
      utilStatus: json['utilStatus'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['utilId'] = utilId;
    data['aggStatus'] = aggStatus;
    data['utilStatus'] = utilStatus;

    return data;
  }
}
