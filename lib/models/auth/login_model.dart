import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    required this.accessToken,
    required this.applicationId,
    required this.role,
    required this.fullName,
    required this.image,
  });

  String accessToken;
  String applicationId;
  String role;
  String fullName;
  String image;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        accessToken: json["accessToken"] ?? "",
        applicationId: json["applicationId"] ?? "",
        role: json["role"] ?? "",
        fullName: json["fullName"] ?? "",
        image: json["image"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "accessToken": accessToken,
        "applicationId": applicationId,
        "role": role,
        "fullName": fullName,
        "image": image,
      };
}
