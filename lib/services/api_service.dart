import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nutrilife/models/activity.dart';
import 'package:nutrilife/models/achievement.dart';

class ApiService {
  static const String baseUrl = 'http://localhost/nutrilife-api';

  // Login
  Future<Map<String, dynamic>> login(String email, String password) async {
    print('Mengirim permintaan login ke: $baseUrl/auth.php');
    print('Request body: ${jsonEncode({'action': 'login', 'email': email, 'password': password})}');
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth.php'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'action': 'login',
          'email': email,
          'password': password,
        }),
      );
      print('Login Response: ${response.statusCode} - ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'success' && data['data'] != null && data['data']['user_id'] != null) {
          return data;
        } else {
          throw Exception('Login failed: ${data['message'] ?? 'User not found or invalid credentials'}');
        }
      } else {
        throw Exception('Failed to login: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Error during login: $e');
      rethrow;
    }
  }

  // Register
  Future<Map<String, dynamic>> register(String email, String password, String username) async {
    print('Mengirim permintaan register ke: $baseUrl/auth.php');
    print('Request body: ${jsonEncode({'action': 'register', 'email': email, 'password': password, 'username': username})}');
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth.php'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'action': 'register',
          'email': email,
          'password': password,
          'username': username,
        }),
      );
      print('Register Response: ${response.statusCode} - ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'success' && data['data'] != null && data['data']['user_id'] != null) {
          return data;
        } else {
          throw Exception('Registration failed: ${data['message'] ?? 'Unknown error'}');
        }
      } else {
        throw Exception('Failed to register: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Error during register: $e');
      rethrow;
    }
  }

  // Insert history
  Future<Map<String, dynamic>> addHistory(int userId, String activityType, int value, String date) async {
    print('Mengirim permintaan add history ke: $baseUrl/auth.php');
    print('Request body: ${jsonEncode({'action': 'addHistory', 'user_id': userId, 'activity_type': activityType, 'value': value, 'date': date})}');
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth.php'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'action': 'addHistory',
          'user_id': userId,
          'activity_type': activityType,
          'value': value,
          'date': date,
        }),
      );
      print('Add History Response: ${response.statusCode} - ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'success') {
          return data;
        } else {
          throw Exception('Failed to add history: ${data['message'] ?? 'Unknown error'}');
        }
      } else {
        throw Exception('Failed to add history: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Error adding history: $e');
      rethrow;
    }
  }

  // Update history
  Future<Map<String, dynamic>> updateHistory(int historyId, int value) async {
    print('Mengirim permintaan update history ke: $baseUrl/update_activity.php');
    print('Request body: ${jsonEncode({'history_id': historyId, 'value': value})}');
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/update_activity.php'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'history_id': historyId,
          'value': value,
        }),
      );
      print('Update History Response: ${response.statusCode} - ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data;
      } else {
        throw Exception('Failed to update history: ${response.statusCode}');
      }
    } catch (e) {
      print('Error updating history: $e');
      rethrow;
    }
  }

  // Delete history
  Future<Map<String, dynamic>> deleteHistory(int historyId) async {
    print('Mengirim permintaan delete history ke: $baseUrl/delete_activity.php');
    print('Request body: ${jsonEncode({'history_id': historyId})}');
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/delete_activity.php'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'history_id': historyId,
        }),
      );
      print('Delete History Response: ${response.statusCode} - ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data;
      } else {
        throw Exception('Failed to delete history: ${response.statusCode}');
      }
    } catch (e) {
      print('Error deleting history: $e');
      rethrow;
    }
  }

  // Get history
  Future<List<Activity>> getHistory(int userId, String date) async {
    print('Mengirim permintaan ke: $baseUrl/auth.php');
    print('Request body: ${jsonEncode({'action': 'getHistory', 'user_id': userId, 'date': date})}');
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth.php'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'action': 'getHistory',
          'user_id': userId,
          'date': date,
        }),
      );
      print('History Response: ${response.statusCode} - ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'success' && data['data'] != null) {
          return (data['data'] as List)
              .map((activity) => Activity.fromJson(activity))
              .toList();
        } else {
          throw Exception('No history data found: ${data['message'] ?? 'Unknown error'}');
        }
      } else {
        throw Exception('Failed to load history: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Error fetching history: $e');
      rethrow;
    }
  }

  // Get achievements
  Future<List<Achievement>> getAchievements(int userId, String date) async {
    print('Mengirim permintaan ke: $baseUrl/auth.php');
    print('Request body: ${jsonEncode({'action': 'getAchievements', 'user_id': userId, 'date': date})}');
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth.php'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'action': 'getAchievements',
          'user_id': userId,
          'date': date,
        }),
      );
      print('Achievements Response: ${response.statusCode} - ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'success' && data['data'] != null) {
          return (data['data'] as List)
              .map((achievement) => Achievement.fromJson(achievement))
              .toList();
        } else {
          throw Exception('No achievements data found: ${data['message'] ?? 'Unknown error'}');
        }
      } else {
        throw Exception('Failed to load achievements: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Error fetching achievements: $e');
      rethrow;
    }
  }

  // Get exercises
  Future<List<Exercise>> getExercises() async {
    print('Mengirim permintaan ke: $baseUrl/exercises.php');
    try {
      final response = await http.get(Uri.parse('$baseUrl/exercises.php'));
      print('Exercise Response: ${response.statusCode} - ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'success' && data['data'] != null) {
          return (data['data'] as List)
              .map((json) => Exercise.fromJson(json))
              .toList();
        } else {
          throw Exception('No exercises data found in response');
        }
      } else {
        throw Exception('Failed to load exercises: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching exercises: $e');
      rethrow;
    }
  }

  // Complete exercise
  Future<void> completeExercise(int exerciseId, bool completed) async {
    print('Mengirim permintaan complete exercise ke: $baseUrl/exercises.php');
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/exercises.php'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'exercise_id': exerciseId,
          'completed': completed ? 1 : 0,
        }),
      );
      print('Complete Exercise Response: ${response.statusCode} - ${response.body}');

      if (response.statusCode != 200) {
        throw Exception('Failed to update exercise status: ${response.body}');
      }
    } catch (e) {
      print('Error completing exercise: $e');
      rethrow;
    }
  }

  // CRUD untuk Profil
  // Get Profile
  Future<Map<String, dynamic>> getProfile(int userId) async {
    print('Mengirim permintaan get profile ke: $baseUrl/profile.php?user_id=$userId');
    try {
      final response = await http.get(Uri.parse('$baseUrl/profile.php?user_id=$userId'));
      print('Get Profile Response: ${response.statusCode} - ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'success' && data['data'] != null) {
          return data['data'];
        } else {
          throw Exception('No profile data found in response');
        }
      } else {
        throw Exception('Failed to load profile: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching profile: $e');
      rethrow;
    }
  }

  // Update Profile
  Future<Map<String, dynamic>> updateProfile(int userId, String username, String email) async {
    print('Mengirim permintaan update profile ke: $baseUrl/profile.php');
    print('Request body: ${jsonEncode({'user_id': userId, 'username': username, 'email': email})}');
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/profile.php'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'user_id': userId,
          'username': username,
          'email': email,
        }),
      );
      print('Update Profile Response: ${response.statusCode} - ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data;
      } else {
        throw Exception('Failed to update profile: ${response.statusCode}');
      }
    } catch (e) {
      print('Error updating profile: $e');
      rethrow;
    }
  }

  // Delete Profile
  Future<Map<String, dynamic>> deleteProfile(int userId) async {
    print('Mengirim permintaan delete profile ke: $baseUrl/profile.php');
    print('Request body: ${jsonEncode({'user_id': userId})}');
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/profile.php'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'user_id': userId,
        }),
      );
      print('Delete Profile Response: ${response.statusCode} - ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data;
      } else {
        throw Exception('Failed to delete profile: ${response.statusCode}');
      }
    } catch (e) {
      print('Error deleting profile: $e');
      rethrow;
    }
  }

  // Insert Profile (Menggunakan aksi register dari auth.php)
  Future<Map<String, dynamic>> insertProfile(String username, String email, String password) async {
    print('Mengirim permintaan insert profile ke: $baseUrl/auth.php');
    print('Request body: ${jsonEncode({'action': 'register', 'username': username, 'email': email, 'password': password})}');
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth.php'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'action': 'register',
          'username': username,
          'email': email,
          'password': password,
        }),
      );
      print('Insert Profile Response: ${response.statusCode} - ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'success' && data['data'] != null && data['data']['user_id'] != null) {
          return data;
        } else {
          throw Exception('Failed to create profile: ${data['message'] ?? 'Unknown error'}');
        }
      } else {
        throw Exception('Failed to create profile: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Error creating profile: $e');
      rethrow;
    }
  }
}

class Exercise {
  final int id;
  final String title;
  final int duration;
  final String image;

  Exercise({
    required this.id,
    required this.title,
    required this.duration,
    required this.image,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      id: json['id'],
      title: json['title'],
      duration: json['duration'],
      image: json['image'],
    );
  }
}