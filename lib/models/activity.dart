class Activity {
  final int historyId;
  final int userId;
  final String activityType;
  final int value;
  final String date;

  Activity({
    required this.historyId,
    required this.userId,
    required this.activityType,
    required this.value,
    required this.date,
  });

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      historyId: json['history_id'] ?? 0,
      userId: json['user_id'] ?? 0,
      activityType: json['activity_type'] ?? '',
      value: json['value'] ?? 0,
      date: json['date'] ?? '',
    );
  }
}