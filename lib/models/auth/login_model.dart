class UserResponse {
  final List<User> response;
  final String error;
  final bool isSuccess;

  UserResponse({required this.response, required this.error, required this.isSuccess});

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      response: json['response'] != null
          ? List<User>.from(json['response'].map((user) => User.fromJson(user)))
          : [],
      error: json['error'],
      isSuccess: json['isSuccess'],
    );
  }
}

class User {
  final String username;
  final String email;
  final String phone;
  final int userId;

  final String token;

  User(
      {required this.username,
        required this.email,
        required this.phone,
        required this.userId,
        required this.token});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      email: json['email'],
      phone: json['phone'],
      userId: json['userId'],
      token: json['token'],
    );
  }
}
