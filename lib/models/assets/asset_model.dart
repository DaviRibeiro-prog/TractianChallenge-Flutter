import 'package:tractian_challenge/models/assets/metrics_model.dart';
import 'package:tractian_challenge/models/assets/specifications_model.dart';

import 'health_history_model.dart';

class Asset {
  Asset({
    required this.assignedUserIds,
    required this.companyId,
    required this.healthHistory,
    required this.healthscore,
    required this.id,
    required this.image,
    required this.metrics,
    required this.model,
    required this.name,
    required this.sensors,
    required this.specifications,
    required this.status,
    required this.unitId,
  });
  late final List<int> assignedUserIds;
  late final int companyId;
  late final List<HealthHistory> healthHistory;
  late final double healthscore;
  late final int id;
  late final String image;
  late final Metrics metrics;
  late final String model;
  late final String name;
  late final List<String> sensors;
  late final Specifications specifications;
  late String status;
  late final int unitId;

  Asset.fromJson(Map<String, dynamic> json) {
    assignedUserIds = List.castFrom<dynamic, int>(json['assignedUserIds']);
    companyId = json['companyId'];
    healthHistory = List.from(json['healthHistory'])
        .map((e) => HealthHistory.fromJson(e))
        .toList();
    healthscore = json['healthscore'].toDouble();
    id = json['id'];
    image = json['image'];
    metrics = Metrics.fromJson(json['metrics']);
    model = json['model'];
    name = json['name'];
    sensors = List.castFrom<dynamic, String>(json['sensors']);
    specifications = Specifications.fromJson(json['specifications']);
    status = json['status'];
    unitId = json['unitId'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['assignedUserIds'] = assignedUserIds;
    data['companyId'] = companyId;
    data['healthHistory'] = healthHistory.map((e) => e.toJson()).toList();
    data['healthscore'] = healthscore;
    data['id'] = id;
    data['image'] = image;
    data['metrics'] = metrics.toJson();
    data['model'] = model;
    data['name'] = name;
    data['sensors'] = sensors;
    data['specifications'] = specifications.toJson();
    data['status'] = status;
    data['unitId'] = unitId;
    return data;
  }
}
