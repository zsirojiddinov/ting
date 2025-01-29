class RoleModel {
  int? id;
  String? roleName;

  RoleModel({
    this.id = 0,
    this.roleName = "",
  });

  factory RoleModel.fromJson(Map<String, dynamic> json) {
    return RoleModel(
      id: json['id'] ?? 0,
      roleName: json['roleName'] ?? "",
    );
  }

  static fromListJson(List<dynamic> json) {
    var list = <RoleModel>[];
    json.map((elem) {
      list.add(RoleModel.fromJson(elem));
    }).toList();

    return list;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['roleName'] = roleName;
    return data;
  }
}
