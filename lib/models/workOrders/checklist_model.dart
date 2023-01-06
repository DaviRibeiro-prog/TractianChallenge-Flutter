class TaskTile {
  TaskTile({
    required this.completed,
    required this.task,
  });
  late bool completed;
  late String task;

  TaskTile.fromJson(Map<String, dynamic> json) {
    completed = json['completed'];
    task = json['task'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['completed'] = completed;
    data['task'] = task;
    return data;
  }
}
