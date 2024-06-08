// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

ProfileModel profileModelFromJson(String str) => ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  ProfileDataModel response;
  List<String> error;
  dynamic validatorError;
  bool isSuccess;
  int count;
  dynamic param;

  ProfileModel({
    required this.response,
    required this.error,
    required this.validatorError,
    required this.isSuccess,
    required this.count,
    required this.param,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    response: ProfileDataModel.fromJson(json["response"]),
    error: List<String>.from(json["error"].map((x) => x)),
    validatorError: json["validatorError"],
    isSuccess: json["isSuccess"],
    count: json["count"],
    param: json["param"],
  );

  Map<String, dynamic> toJson() => {
    "response": response.toJson(),
    "error": List<dynamic>.from(error.map((x) => x)),
    "validatorError": validatorError,
    "isSuccess": isSuccess,
    "count": count,
    "param": param,
  };
}

class ProfileDataModel {
  String businessName;
  String businessCompetence;
  InfoModel info;
  dynamic warehouseId;
  bool accountDhlizApp;
  int id;
  DateTime createdDate;

  ProfileDataModel({
    required this.businessName,
    required this.businessCompetence,
    required this.info,
    required this.warehouseId,
    required this.accountDhlizApp,
    required this.id,
    required this.createdDate,
  });

  factory ProfileDataModel.fromJson(Map<String, dynamic> json) => ProfileDataModel(
    businessName: json["businessName"],
    businessCompetence: json["businessCompetence"],
    info: InfoModel.fromJson(json["info"]),
    warehouseId: json["warehouseId"],
    accountDhlizApp: json["accountDhlizApp"],
    id: json["id"],
    createdDate: DateTime.parse(json["createdDate"]),
  );

  Map<String, dynamic> toJson() => {
    "businessName": businessName,
    "businessCompetence": businessCompetence,
    "info": info.toJson(),
    "warehouseId": warehouseId,
    "accountDhlizApp": accountDhlizApp,
    "id": id,
    "createdDate": createdDate.toIso8601String(),
  };
}

class InfoModel {
  int id;
  DateTime createdDate;
  String name;
  String phone;
  String password;
  String email;
  String phone2;
  List<dynamic> documents;
  dynamic address;

  InfoModel({
    required this.id,
    required this.createdDate,
    required this.name,
    required this.phone,
    required this.password,
    required this.email,
    required this.phone2,
    required this.documents,
    required this.address,
  });

  factory InfoModel.fromJson(Map<String, dynamic> json) => InfoModel(
    id: json["id"],
    createdDate: DateTime.parse(json["createdDate"]),
    name: json["name"],
    phone: json["phone"],
    password: json["password"],
    email: json["email"],
    phone2: json["phone2"],
    documents: List<dynamic>.from(json["documents"].map((x) => x)),
    address: json["address"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "createdDate": createdDate.toIso8601String(),
    "name": name,
    "phone": phone,
    "password": password,
    "email": email,
    "phone2": phone2,
    "documents": List<dynamic>.from(documents.map((x) => x)),
    "address": address,
  };
}
