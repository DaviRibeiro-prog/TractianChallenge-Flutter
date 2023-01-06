class User {
  User({
    required this.companyId,
    required this.email,
    required this.id,
    required this.name,
    required this.unitId,
  });
  late final int companyId;
  late final String email;
  late final int id;
  late final String name;
  late final int unitId;

  User.fromJson(Map<String, dynamic> json) {
    companyId = json['companyId'];
    email = json['email'];
    id = json['id'];
    name = json['name'];
    unitId = json['unitId'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['companyId'] = companyId;
    data['email'] = email;
    data['id'] = id;
    data['name'] = name;
    data['unitId'] = unitId;
    return data;
  }
}
