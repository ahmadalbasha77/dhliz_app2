import 'dart:convert';

RegisterModel registerModelFromJson(String str) =>
    RegisterModel.fromJson(json.decode(str));

String registerModelToJson(RegisterModel data) => json.encode(data.toJson());

class RegisterModel {
  RegisterModel({
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

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
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
