// To parse this JSON data, do
//
//     final stockModel = stockModelFromJson(jsonString);

import 'dart:convert';

StockModel stockModelFromJson(String str) =>
    StockModel.fromJson(json.decode(str));

String stockModelToJson(StockModel data) => json.encode(data.toJson());

class StockModel {
  List<StockDataModel> response;
  List<String> error;
  bool isSuccess;
  int count;

  StockModel({
    required this.response,
    required this.error,
    required this.isSuccess,
    required this.count,
  });

  factory StockModel.fromJson(Map<String, dynamic> json) => StockModel(
        response: List<StockDataModel>.from(
            json["response"].map((x) => StockDataModel.fromJson(x))),
        error: List<String>.from(json["error"].map((x) => x)),
        isSuccess: json["isSuccess"],
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "response": List<dynamic>.from(response.map((x) => x.toJson())),
        "error": List<dynamic>.from(error.map((x) => x)),
        "isSuccess": isSuccess,
        "count": count,
      };
}

class StockDataModel {
  String code;
  String brand;
  String upc;
  String photo;
  int subscriptionId;
  String? rejectReason;
  int status;
  List<DocumentsStatus> documentsStatus;
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
    required this.rejectReason,
    required this.status,
    required this.documentsStatus,
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
        rejectReason: json["rejectReason"] ?? '',
        status: json["status"] ?? 0,
        documentsStatus: List<DocumentsStatus>.from(
            json["documentsStatus"].map((x) => DocumentsStatus.fromJson(x))),
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
        "rejectReason": rejectReason,
        "status": status,
        "documentsStatus":
            List<dynamic>.from(documentsStatus.map((x) => x.toJson())),
        "name": name,
        "capacity": capacity,
        "description": description,
        "id": id,
      };
}

class DocumentsStatus {
  String name;
  String filePath;
  int id;

  DocumentsStatus({
    required this.name,
    required this.filePath,
    required this.id,
  });

  factory DocumentsStatus.fromJson(Map<String, dynamic> json) =>
      DocumentsStatus(
        name: json["name"] ?? '',
        filePath: json["filePath"] ?? "",
        id: json["id"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "filePath": filePath,
        "id": id,
      };
}
