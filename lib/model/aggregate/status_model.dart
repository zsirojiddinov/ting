class StatusModel {
  bool isAccept;
  String? name;
  String? color;

  StatusModel({
    this.isAccept = false,
    this.color = "",
    this.name = "",
  });

  factory StatusModel.fromJson(Map<String, dynamic> json) {
    return StatusModel(
      isAccept: json['isAccept'] ?? 0,
      color: json['color'] ?? "",
      name: json['name'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isAccept'] = isAccept;
    data['color'] = color;
    data['name'] = name;
    return data;
  }
}
