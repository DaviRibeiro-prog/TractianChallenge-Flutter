class HealthHistory {
  HealthHistory({
    required this.status,
    required this.timestamp,
  });
  late final String status;
  late final String timestamp;

  HealthHistory.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['timestamp'] = timestamp;
    return data;
  }
}
