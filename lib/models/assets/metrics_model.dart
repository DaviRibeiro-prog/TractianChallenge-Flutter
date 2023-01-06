class Metrics {
  Metrics({
    required this.lastUptimeAt,
    required this.totalCollectsUptime,
    required this.totalUptime,
  });
  late final String lastUptimeAt;
  late final int totalCollectsUptime;
  late final double totalUptime;

  Metrics.fromJson(Map<String, dynamic> json) {
    lastUptimeAt = json['lastUptimeAt'];
    totalCollectsUptime = json['totalCollectsUptime'];
    totalUptime = json['totalUptime'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['lastUptimeAt'] = lastUptimeAt;
    data['totalCollectsUptime'] = totalCollectsUptime;
    data['totalUptime'] = totalUptime;
    return data;
  }
}
