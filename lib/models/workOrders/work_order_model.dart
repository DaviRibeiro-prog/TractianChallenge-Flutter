import 'package:tractian_challenge/models/workOrders/checklist_model.dart';

class WorkOrder {
  WorkOrder({
    required this.assetId,
    required this.assignedUserIds,
    required this.tasksList,
    required this.description,
    required this.id,
    required this.priority,
    required this.status,
    required this.title,
  });
  late int assetId;
  late List<int> assignedUserIds;
  late List<TaskTile> tasksList;
  late String description;
  late int id;
  late String priority;
  late String status;
  late String title;

  WorkOrder.fromJson(Map<String, dynamic> json) {
    assetId = json['assetId'];
    assignedUserIds = List.castFrom<dynamic, int>(json['assignedUserIds']);
    tasksList =
        List.from(json['checklist']).map((e) => TaskTile.fromJson(e)).toList();
    description = json['description'];
    id = json['id'];
    priority = json['priority'];
    status = json['status'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['assetId'] = assetId;
    data['assignedUserIds'] = assignedUserIds;
    data['checklist'] = tasksList.map((e) => e.toJson()).toList();
    data['description'] = description;
    data['id'] = id;
    data['priority'] = priority;
    data['status'] = status;
    data['title'] = title;
    return data;
  }
}
