import 'dart:convert';

ProfileModel profileModelFromJson(String str) =>
    ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  ProfileModel({
    required this.fullName,
    required this.phoneNumber,
    required this.homeAddress,
    required this.workAddress,
    required this.email,
    required this.image,
    required this.syndicateNumber,
    required this.deviceToken,
    required this.applicationId,
    required this.role,
    required this.licenseExpiry,
    required this.researches,
  });

  String fullName;
  String phoneNumber;
  String homeAddress;
  String workAddress;
  String email;
  String image;
  String syndicateNumber;
  String deviceToken;
  String applicationId;
  String role;
  DateTime? licenseExpiry;
  List<ResearchProfileModel> researches;

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        fullName: json["fullName"] ?? "",
        phoneNumber: json["phoneNumber"] ?? "",
        homeAddress: json["homeAddress"] ?? "",
        workAddress: json["workAddress"] ?? "",
        email: json["email"] ?? "",
        image: json["image"] ?? "",
        syndicateNumber: json["syndicateNumber"] ?? "",
        deviceToken: json["deviceToken"] ?? "",
        applicationId: json["applicationId"] ?? "",
        role: json["role"] ?? "",
        licenseExpiry: DateTime.tryParse(json["licenseExpiry"] ?? ""),
        researches: json["researchs"] == null
            ? []
            : List<ResearchProfileModel>.from(
                json["researchs"].map((x) => ResearchProfileModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "fullName": fullName,
        "phoneNumber": phoneNumber,
        "homeAddress": homeAddress,
        "workAddress": workAddress,
        "email": email,
        "image": image,
        "syndicateNumber": syndicateNumber,
        "deviceToken": deviceToken,
        "applicationId": applicationId,
        "role": role,
        "licenseExpiry": licenseExpiry?.toIso8601String(),
        "researchs": List<dynamic>.from(researches.map((x) => x.toJson())),
      };
}

class ResearchProfileModel {
  ResearchProfileModel({
    required this.id,
    required this.title,
    required this.description,
    required this.pdf,
    required this.datePublication,
  });

  String id;
  String title;
  String description;
  String pdf;
  DateTime? datePublication;

  factory ResearchProfileModel.fromJson(Map<String, dynamic> json) =>
      ResearchProfileModel(
        id: json["id"] ?? "",
        title: json["title"] ?? "",
        description: json["description"] ?? "",
        pdf: json["pdf"] ?? "",
        datePublication: DateTime.tryParse(json["datePublication"] ?? ""),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "pdf": pdf,
        "datePublication": datePublication?.toIso8601String(),
      };
}
