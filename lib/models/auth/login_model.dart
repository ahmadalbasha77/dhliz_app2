// To parse this JSON data, do
//
//     final userResponse = userResponseFromJson(jsonString);

import 'dart:convert';

UserResponse userResponseFromJson(String str) => UserResponse.fromJson(json.decode(str));

String userResponseToJson(UserResponse data) => json.encode(data.toJson());

class UserResponse {
  Users response;
  bool isSuccess;

  UserResponse({
    required this.response,
    required this.isSuccess,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
    response: Users.fromJson(json["response"]),
    isSuccess: json["isSuccess"],
  );

  Map<String, dynamic> toJson() => {
    "response": response.toJson(),
    "isSuccess": isSuccess,
  };
}

class Users {
  String username;
  String email;
  String phone;
  int userId;
  int warehouseId;
  List<String> permissions;
  String token;
  int userType;
  int customerId;
  bool isActive;

  Users({
    required this.username,
    required this.email,
    required this.phone,
    required this.userId,
    required this.warehouseId,
    required this.permissions,
    required this.token,
    required this.userType,
    required this.customerId,
    required this.isActive,
  });

  factory Users.fromJson(Map<String, dynamic> json) => Users(
    username: json["username"],
    email: json["email"],
    phone: json["phone"],
    userId: json["userId"],
    warehouseId: json["warehouseId"],
    permissions: List<String>.from(json["permissions"].map((x) => x)),
    token: json["token"],
    userType: json["userType"],
    customerId: json["customerId"],
    isActive: json["isActive"],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "email": email,
    "phone": phone,
    "userId": userId,
    "warehouseId": warehouseId,
    "permissions": List<dynamic>.from(permissions.map((x) => x)),
    "token": token,
    "userType": userType,
    "customerId": customerId,
    "isActive": isActive,
  };
}
