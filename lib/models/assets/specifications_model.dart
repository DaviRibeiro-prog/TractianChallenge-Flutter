class Specifications {
  Specifications({
    required this.maxTemp,
    required this.power,
    required this.rpm,
  });
  late final int maxTemp;
  late final double? power;
  late final double? rpm;

  Specifications.fromJson(Map<String, dynamic> json) {
    maxTemp = json['maxTemp'];
    power = json['power']?.toDouble();
    rpm = json['rpm']?.toDouble();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['maxTemp'] = maxTemp;
    data['power'] = power;
    data['rpm'] = rpm;
    return data;
  }
}
