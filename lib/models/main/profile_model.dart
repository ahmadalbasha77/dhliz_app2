// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

ProfileModel profileModelFromJson(String str) => ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  List<ProfileDataModel> response;
  List<String> error;
  bool isSuccess;


  ProfileModel({
    required this.response,
    required this.error,
    required this.isSuccess,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    response: List<ProfileDataModel>.from(json["response"].map((x) => ProfileDataModel.fromJson(x))),
    error: List<String>.from(json["error"].map((x) => x)),
    isSuccess: json["isSuccess"],
  );

  Map<String, dynamic> toJson() => {
    "response": List<dynamic>.from(response.map((x) => x.toJson())),
    "error": List<dynamic>.from(error.map((x) => x)),
    "isSuccess": isSuccess,
  };
}

class ProfileDataModel {
  String businessName;
  String businessCompetence;
  InfoModel info;
  bool accountDhlizApp;
  int id;

  ProfileDataModel({
    required this.businessName,
    required this.businessCompetence,
    required this.info,
    required this.accountDhlizApp,
    required this.id,
  });

  factory ProfileDataModel.fromJson(Map<String, dynamic> json) => ProfileDataModel(
    businessName: json["businessName"]??'',
    businessCompetence: json["businessCompetence"]??'',
    info: InfoModel.fromJson(json["info"]),
    accountDhlizApp: json["accountDhlizApp"]??false,
    id: json["id"]??'',
  );

  Map<String, dynamic> toJson() => {
    "businessName": businessName,
    "businessCompetence": businessCompetence,
    "info": info.toJson(),
    "accountDhlizApp": accountDhlizApp,
    "id": id,
  };
}

class InfoModel {
  int id;
  String name;
  String phone;
  String password;
  String email;
  String phone2;
  List<dynamic> documents;
  AddressModel? address;

  InfoModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.password,
    required this.email,
    required this.phone2,
    required this.documents,
    required this.address,
  });

  factory InfoModel.fromJson(Map<String, dynamic> json) => InfoModel(
    id: json["id"]??'',
    name: json["name"]??'',
    phone: json["phone"]??'',
    password: json["password"]??'',
    email: json["email"]??'',
    phone2: json["phone2"]??'',
    documents: List<dynamic>.from(json["documents"].map((x) => x)),
    address: json["address"] == null ? null : AddressModel.fromJson(json["address"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "phone": phone,
    "password": password,
    "email": email,
    "phone2": phone2,
    "documents": List<dynamic>.from(documents.map((x) => x)),
    "address": address!.toJson(),
  };
}

class AddressModel {
  String city;
  String state;
  String street;
  dynamic lat;
  dynamic lot;
  int id;

  AddressModel({
    required this.city,
    required this.state,
    required this.street,
    required this.lat,
    required this.lot,
    required this.id,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
    city: json["city"]??'',
    state: json["state"]??'',
    street: json["street"]??'',
    lat: json["lat"]??'',
    lot: json["lot"]??'',
    id: json["id"]??'',
  );

  Map<String, dynamic> toJson() => {
    "city": city,
    "state": state,
    "street": street,
    "lat": lat,
    "lot": lot,
    "id": id,
  };
}
