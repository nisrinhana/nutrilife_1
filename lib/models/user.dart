class User {
  final int userId;
  final String email;
  final String username;

  User({required this.userId, required this.email, required this.username});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['user_id'],
      email: json['email'],
      username: json['username'],
    );
  }
}