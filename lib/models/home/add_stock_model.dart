// To parse this JSON data, do
//
//     final addStockModel = addStockModelFromJson(jsonString);

import 'dart:convert';

AddStockModel addStockModelFromJson(String str) => AddStockModel.fromJson(json.decode(str));

String addStockModelToJson(AddStockModel data) => json.encode(data.toJson());

class AddStockModel {
  AddStockDataModel response;
  List<String> error;
  bool isSuccess;

  AddStockModel({
    required this.response,
    required this.error,
    required this.isSuccess,
  });

  factory AddStockModel.fromJson(Map<String, dynamic> json) => AddStockModel(
    response: AddStockDataModel.fromJson(json["response"]),
    error: List<String>.from(json["error"].map((x) => x)),
    isSuccess: json["isSuccess"],
  );

  Map<String, dynamic> toJson() => {
    "response": response.toJson(),
    "error": List<dynamic>.from(error.map((x) => x)),
    "isSuccess": isSuccess,
  };
}
class AddStockDataModel {
  String code;
  String brand;
  String upc;
  String photo;
  int subscriptionId;
  int status;
  String name;
  int capacity;
  String description;
  int id;

  AddStockDataModel({
    required this.code,
    required this.brand,
    required this.upc,
    required this.photo,
    required this.subscriptionId,
    required this.status,
    required this.name,
    required this.capacity,
    required this.description,
    required this.id,
  });

  factory AddStockDataModel.fromJson(Map<String, dynamic> json) => AddStockDataModel(
    code: json["code"] ?? '',
    brand: json["brand"] ?? '',
    upc: json["upc"] ?? '',
    photo: json["photo"] ?? '',
    subscriptionId: json["subscriptionId"] ?? 0,
    status: json["status"] is int ? json["status"] : int.tryParse(json["status"]?.toString() ?? '0') ?? 0,
    name: json["name"] ?? '',
    capacity: json["capacity"] ?? 0,
    description: json["description"] ?? '',
    id: json["id"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "brand": brand,
    "upc": upc,
    "photo": photo,
    "subscriptionId": subscriptionId,
    "status": status,
    "name": name,
    "capacity": capacity,
    "description": description,
    "id": id,
  };
}


