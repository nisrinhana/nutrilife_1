class Achievement {
  final int achievementId;
  final int userId;
  final String achievementName;
  final int target;
  final int progress;
  final bool isAchieved;
  final String achievedAt;

  Achievement({
    required this.achievementId,
    required this.userId,
    required this.achievementName,
    required this.target,
    required this.progress,
    required this.isAchieved,
    required this.achievedAt,
  });

  factory Achievement.fromJson(Map<String, dynamic> json) {
    return Achievement(
      achievementId: json['achievement_id'] ?? 0,
      userId: json['user_id'] ?? 0,
      achievementName: json['achievement_name'] ?? 'Unknown',
      target: json['target'] ?? 0,
      progress: json['progress'] ?? 0,
      isAchieved: json['is_achieved'] == 1,
      achievedAt: json['achieved_at'] ?? '',
    );
  }
}