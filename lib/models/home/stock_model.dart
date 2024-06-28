// To parse this JSON data, do
//
//     final stockModel = stockModelFromJson(jsonString);

import 'dart:convert';

StockModel stockModelFromJson(String str) =>
    StockModel.fromJson(json.decode(str));

String stockModelToJson(StockModel data) => json.encode(data.toJson());

class StockModel {
  List<StockDataModel> response;
  bool isSuccess;

  StockModel({
    required this.response,
    required this.isSuccess,
  });

  factory StockModel.fromJson(Map<String, dynamic> json) => StockModel(
        response: List<StockDataModel>.from(
            json["response"].map((x) => StockDataModel.fromJson(x))),
        isSuccess: json["isSuccess"],
      );

  Map<String, dynamic> toJson() => {
        "response": List<dynamic>.from(response.map((x) => x.toJson())),
        "isSuccess": isSuccess,
      };
}

class StockDataModel {
  String code;
  String brand;
  String upc;
  String photo;
  int subscriptionId;
  String name;
  int capacity;
  String description;
  int id;

  StockDataModel({
    required this.code,
    required this.brand,
    required this.upc,
    required this.photo,
    required this.subscriptionId,
    required this.name,
    required this.capacity,
    required this.description,
    required this.id,
  });

  factory StockDataModel.fromJson(Map<String, dynamic> json) => StockDataModel(
        code: json["code"] ?? '',
        brand: json["brand"] ?? '',
        upc: json["upc"] ?? '',
        photo: json["photo"] ?? '',
        subscriptionId: json["subscriptionId"] ?? 0,
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
        "name": name,
        "capacity": capacity,
        "description": description,
        "id": id,
      };
}

