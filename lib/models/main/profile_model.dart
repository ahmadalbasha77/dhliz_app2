// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

ProfileModel profileModelFromJson(String str) => ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  ProfileDataModel response;
  List<String> error;
  bool isSuccess;
  int count;

  ProfileModel({
    required this.response,
    required this.error,
    required this.isSuccess,
    required this.count,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    response: ProfileDataModel.fromJson(json["response"]),
    error: List<String>.from(json["error"].map((x) => x)),
    isSuccess: json["isSuccess"],
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "response": response.toJson(),
    "error": List<dynamic>.from(error.map((x) => x)),
    "isSuccess": isSuccess,
    "count": count,
  };
}

class ProfileDataModel {
  String businessName;
  String businessCompetence;
  InfoModel info;
  int id;

  ProfileDataModel({
    required this.businessName,
    required this.businessCompetence,
    required this.info,
    required this.id,
  });

  factory ProfileDataModel.fromJson(Map<String, dynamic> json) => ProfileDataModel(
    businessName: json["businessName"]??'',
    businessCompetence: json["businessCompetence"]??'',
    info: InfoModel.fromJson(json["info"]),
    id: json["id"]??'',
  );

  Map<String, dynamic> toJson() => {
    "businessName": businessName,
    "businessCompetence": businessCompetence,
    "info": info.toJson(),
    "id": id,
  };
}

class InfoModel {
  int id;
  String name;
  String phone;
  String email;
  String phone2;
  List<dynamic> documents;
  dynamic address;

  InfoModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.phone2,
    required this.documents,
    required this.address,
  });

  factory InfoModel.fromJson(Map<String, dynamic> json) => InfoModel(
    id: json["id"]??'',
    name: json["name"]??'',
    phone: json["phone"]??'',
    email: json["email"]??'',
    phone2: json["phone2"]??'',
    documents:json["documents"]==null?[]: List<dynamic>.from(json["documents"].map((x) => x)),
    address: json["address"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "phone": phone,
    "email": email,
    "phone2": phone2,
    "documents": List<dynamic>.from(documents.map((x) => x)),
    "address": address,
  };
}
