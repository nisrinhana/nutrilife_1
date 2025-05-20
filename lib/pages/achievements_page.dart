import 'package:flutter/material.dart';
import 'package:nutrilife/services/api_service.dart';
import 'package:nutrilife/models/achievement.dart';

class AchievementsPage extends StatefulWidget {
  final int? userId; // Tambahkan parameter userId

  const AchievementsPage({super.key, this.userId});

  @override
  _AchievementsPageState createState() => _AchievementsPageState();
}

class _AchievementsPageState extends State<AchievementsPage> {
  final ApiService _apiService = ApiService();
  List<Achievement> _achievements = [];
  bool _isLoading = false;

  void _fetchAchievements() async {
    setState(() {
      _isLoading = true;
    });
    try {
      if (widget.userId == null) {
        throw Exception('User not logged in');
      }
      final date = DateTime.now().toIso8601String().split('T')[0]; // Gunakan tanggal hari ini
      final achievements = await _apiService.getAchievements(widget.userId!, date);
      setState(() {
        _achievements = achievements;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchAchievements();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Achievements',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF800000),
                Color(0xFF000080),
              ],
            ),
          ),
        ),
        elevation: 0,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Your Progress',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _achievements.isEmpty
                      ? const Center(child: Text('No achievements available for today.'))
                      : Expanded(
                          child: ListView(
                            children: _achievements.map((achievement) {
                              Color color;
                              if (achievement.achievementName == 'Daily Steps') {
                                color = Colors.blue;
                              } else if (achievement.achievementName == 'Water Intake') {
                                color = Colors.green;
                              } else {
                                color = Colors.red;
                              }
                              return _buildProgressItem(
                                title: achievement.achievementName,
                                value: achievement.progress / achievement.target, // Normalisasi progress
                                target: achievement.achievementName == 'Daily Steps'
                                    ? '${achievement.target} steps'
                                    : achievement.achievementName == 'Water Intake'
                                        ? '${achievement.target ~/ 1000}L'
                                        : '${achievement.target} kcal',
                                color: color,
                              );
                            }).toList(),
                          ),
                        ),
                ],
              ),
            ),
    );
  }

  Widget _buildProgressItem({
    required String title,
    required double value,
    required String target,
    required Color color,
  }) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: value > 1 ? 1 : value, // Batasi value agar tidak melebihi 1
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(color),
              minHeight: 8,
            ),
            const SizedBox(height: 8),
            Text(
              'Progress: ${(value * 100).toStringAsFixed(1)}% (Target: $target)',
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}