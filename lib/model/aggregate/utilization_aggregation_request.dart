class UtilizationAggregationRequest {
  String? groupCis;
  List<String>? unitCis;

  UtilizationAggregationRequest({
    this.groupCis = "",
    this.unitCis,
  });

  factory UtilizationAggregationRequest.fromJson(Map<String, dynamic> json) {
    return UtilizationAggregationRequest(
      groupCis: json['groupCis'] ?? "",
      unitCis: json['unitCis'] == null
          ? []
          : (json['unitCis'] as List).map((e) => e as String).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['groupCis'] = groupCis;
    data['unitCis'] = this.unitCis;
    return data;
  }
}
