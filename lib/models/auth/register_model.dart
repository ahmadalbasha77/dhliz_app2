// To parse this JSON data, do
//
//     final registerModel = registerModelFromJson(jsonString);

import 'dart:convert';

RegisterModel registerModelFromJson(String str) =>
    RegisterModel.fromJson(json.decode(str));

String registerModelToJson(RegisterModel data) => json.encode(data.toJson());

class RegisterModel {
  List<Response> response;
  bool isSuccess;

  RegisterModel({
    required this.response,
    required this.isSuccess,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
    response: List<Response>.from(
        json["response"].map((x) => Response.fromJson(x))),
    isSuccess: json["isSuccess"],
  );

  Map<String, dynamic> toJson() => {
    "response": List<dynamic>.from(response.map((x) => x.toJson())),
    "isSuccess": isSuccess,
  };
}

class Response {
  String username;
  String email;
  String phone;
  int userId;
  int warehouseId;
  String token;
  int userType;
  int customerId;
  bool isActive;

  Response({
    required this.username,
    required this.email,
    required this.phone,
    required this.userId,
    required this.warehouseId,
    required this.token,
    required this.userType,
    required this.customerId,
    required this.isActive,
  });

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    username: json["username"],
    email: json["email"],
    phone: json["phone"],
    userId: json["userId"],
    warehouseId: json["warehouseId"],
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
    "token": token,
    "userType": userType,
    "customerId": customerId,
    "isActive": isActive,
  };
}
