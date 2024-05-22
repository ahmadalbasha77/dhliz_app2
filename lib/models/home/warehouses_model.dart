// To parse this JSON data, do
//
//     final warehousesModel = warehousesModelFromJson(jsonString);

import 'dart:convert';

WarehousesModel warehousesModelFromJson(String str) =>
    WarehousesModel.fromJson(json.decode(str));

String warehousesModelToJson(WarehousesModel data) =>
    json.encode(data.toJson());

class WarehousesModel {
  List<WarehousesDataModel> response;
  List<String> error;
  bool isSuccess;
  int count;

  WarehousesModel({
    required this.response,
    required this.error,
    required this.isSuccess,
    required this.count,
  });

  factory WarehousesModel.fromJson(Map<String, dynamic> json) =>
      WarehousesModel(
        response: List<WarehousesDataModel>.from(
            json["response"].map((x) => WarehousesDataModel.fromJson(x))),
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

class WarehousesDataModel {
  int id;
  String name;
  String phone;
  DateTime dateAddend;
  int cost;
  int commission;
  int transportationFees;
  int capacity;
  Address address;

  WarehousesDataModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.dateAddend,
    required this.cost,
    required this.commission,
    required this.transportationFees,
    required this.capacity,
    required this.address,
  });

  factory WarehousesDataModel.fromJson(Map<String, dynamic> json) =>
      WarehousesDataModel(
        id: json["id"] ?? 0,
        name: json["name"] ?? '',
        phone: json["phone"] ?? '',
        dateAddend: DateTime.parse(json["dateAddend"]),
        cost: json["cost"] ?? 0,
        commission: json["commission"] ?? 0,
        transportationFees: json["transportationFees"] ?? 0,
        capacity: json["capacity"] ?? 0,
        address: json["address"] != null
            ? Address.fromJson(json["address"])
            : Address.fromJson({}),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone": phone,
        "dateAddend":
            "${dateAddend.year.toString().padLeft(4, '0')}-${dateAddend.month.toString().padLeft(2, '0')}-${dateAddend.day.toString().padLeft(2, '0')}",
        "cost": cost,
        "commission": commission,
        "transportationFees": transportationFees,
        "capacity": capacity,
        "address": address.toJson(),
      };
}

class Address {
  String city;
  String state;
  String street;
  String lat;
  String lot;
  int id;

  Address({
    required this.city,
    required this.state,
    required this.street,
    required this.lat,
    required this.lot,
    required this.id,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        city: json["city"] ?? '',
        state: json["state"] ?? '',
        street: json["street"] ?? '',
        lat: json["lat"] ?? '',
        lot: json["lot"] ?? '',
        id: json["id"] ?? 0,
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
