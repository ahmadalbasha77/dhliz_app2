// To parse this JSON data, do
//
//     final addStockModel = addStockModelFromJson(jsonString);

import 'dart:convert';

AddStockModel addStockModelFromJson(String str) =>
    AddStockModel.fromJson(json.decode(str));

String addStockModelToJson(AddStockModel data) => json.encode(data.toJson());

class AddStockModel {
  AddStockDataModel response;
  bool isSuccess;

  AddStockModel({
    required this.response,
    required this.isSuccess,
  });

  factory AddStockModel.fromJson(Map<String, dynamic> json) => AddStockModel(
        response: AddStockDataModel.fromJson(json["response"]),
        isSuccess: json["isSuccess"],
      );

  Map<String, dynamic> toJson() => {
        "response": response.toJson(),
        "isSuccess": isSuccess,
      };
}

class AddStockDataModel {
  String code;
  String brand;
  String upc;
  String photo;
  String description;
  Temperature temperature;
  int subscriptionId;
  int id;
  String name;
  int capacity;

  AddStockDataModel({
    required this.code,
    required this.brand,
    required this.upc,
    required this.photo,
    required this.description,
    required this.temperature,
    required this.subscriptionId,
    required this.id,
    required this.name,
    required this.capacity,
  });

  factory AddStockDataModel.fromJson(Map<String, dynamic> json) =>
      AddStockDataModel(
        code: json["code"],
        brand: json["brand"],
        upc: json["upc"],
        photo: json["photo"],
        description: json["description"],
        temperature: Temperature.fromJson(json["temperature"]),
        subscriptionId: json["subscriptionId"],
        id: json["id"],
        name: json["name"],
        capacity: json["capacity"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "brand": brand,
        "upc": upc,
        "photo": photo,
        "description": description,
        "temperature": temperature.toJson(),
        "subscriptionId": subscriptionId,
        "id": id,
        "name": name,
        "capacity": capacity,
      };
}

class Temperature {
  bool high;
  bool cold;
  bool freezing;
  bool dry;
  int id;
  DateTime createdDate;
  dynamic updateDate;
  dynamic createdBy;
  dynamic updateBy;

  Temperature({
    required this.high,
    required this.cold,
    required this.freezing,
    required this.dry,
    required this.id,
    required this.createdDate,
    required this.updateDate,
    required this.createdBy,
    required this.updateBy,
  });

  factory Temperature.fromJson(Map<String, dynamic> json) => Temperature(
        high: json["high"],
        cold: json["cold"],
        freezing: json["freezing"],
        dry: json["dry"],
        id: json["id"],
        createdDate: DateTime.parse(json["createdDate"]),
        updateDate: json["updateDate"],
        createdBy: json["createdBy"],
        updateBy: json["updateBy"],
      );

  Map<String, dynamic> toJson() => {
        "high": high,
        "cold": cold,
        "freezing": freezing,
        "dry": dry,
        "id": id,
        "createdDate": createdDate.toIso8601String(),
        "updateDate": updateDate,
        "createdBy": createdBy,
        "updateBy": updateBy,
      };
}
