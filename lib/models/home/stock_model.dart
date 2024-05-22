// To parse this JSON data, do
//
//     final stockModel = stockModelFromJson(jsonString);

import 'dart:convert';

StockModel stockModelFromJson(String str) =>
    StockModel.fromJson(json.decode(str));

String stockModelToJson(StockModel data) => json.encode(data.toJson());

class StockModel {
  Result result;

  StockModel({
    required this.result,
  });

  factory StockModel.fromJson(Map<String, dynamic> json) =>
      StockModel(
        result: Result.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() =>
      {
        "result": result.toJson(),
      };
}

class Result {
  List<StockDataModel> response;
  List<String> error;
  bool isSuccess;

  Result({
    required this.response,
    required this.error,
    required this.isSuccess,
  });

  factory Result.fromJson(Map<String, dynamic> json) =>
      Result(
        response: List<StockDataModel>.from(
            json["response"].map((x) => StockDataModel.fromJson(x))),
        error: List<String>.from(json["error"].map((x) => x)),
        isSuccess: json["isSuccess"],
      );

  Map<String, dynamic> toJson() =>
      {
        "response": List<dynamic>.from(response.map((x) => x.toJson())),

        "error": List<dynamic>.from(error.map((x) => x)),
        "isSuccess": isSuccess,
      };
}

class StockDataModel {
  String name;
  String code;
  String brand;
  String upc;
  String photo;
  String description;
  int capacity;
  int subscriptionId;
  int id;

  StockDataModel({
    required this.name,
    required this.code,
    required this.brand,
    required this.upc,
    required this.photo,
    required this.description,
    required this.capacity,
    required this.subscriptionId,
    required this.id,
  });

  factory StockDataModel.fromJson(Map<String, dynamic> json) =>
      StockDataModel(
        name: json["name"] ?? '',
        code: json["code"] ?? '',
        brand: json["brand"] ?? '',
        upc: json["upc"] ?? '',
        photo: json["photo"] ?? '',
        description: json["description"] ?? '',
        capacity: json["capacity"] ?? 0,
        subscriptionId: json["subscriptionId"] ?? 0,
        id: json["id"] ?? 0,
      );

  Map<String, dynamic> toJson() =>
      {
        "name": name,
        "code": code,
        "brand": brand,
        "upc": upc,
        "photo": photo,
        "description": description,
        "capacity": capacity,
        "subscriptionId": subscriptionId,
        "id": id,
      };
}
