// To parse this JSON data, do
//
//     final subscriptionsModel = subscriptionsModelFromJson(jsonString);

import 'dart:convert';

SubscriptionsModel subscriptionsModelFromJson(String str) =>
    SubscriptionsModel.fromJson(json.decode(str));

String subscriptionsModelToJson(SubscriptionsModel data) =>
    json.encode(data.toJson());

class SubscriptionsModel {
  List<SubscriptionDataModel> response;
  bool isSuccess;

  SubscriptionsModel({
    required this.response,
    required this.isSuccess,
  });

  factory SubscriptionsModel.fromJson(Map<String, dynamic> json) =>
      SubscriptionsModel(
        response: List<SubscriptionDataModel>.from(
            json["response"].map((x) => SubscriptionDataModel.fromJson(x))),
        isSuccess: json["isSuccess"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "response": List<dynamic>.from(response.map((x) => x.toJson())),
        "isSuccess": isSuccess,
      };
}

class SubscriptionDataModel {
  int customerId;
  String startDate;
  String endDate;
  int reservedSpace;
  int spaceUsed;
  int availableSpace;
  Warehouse warehouse;
  Temperature temperature;
  String phone;
  String phone2;
  String rejectReason;
  int status;
  String inventoryDescription;
  Address address;
  int id;

  SubscriptionDataModel({
    required this.customerId,
    required this.startDate,
    required this.endDate,
    required this.reservedSpace,
    required this.spaceUsed,
    required this.availableSpace,
    required this.warehouse,
    required this.temperature,
    required this.phone,
    required this.phone2,
    required this.rejectReason,
    required this.status,
    required this.inventoryDescription,
    required this.address,
    required this.id,
  });

  factory SubscriptionDataModel.fromJson(Map<String, dynamic> json) =>
      SubscriptionDataModel(
        customerId: json["customerId"] ?? 0,
        startDate: json["startDate"] ?? '',
        endDate: json["endDate"] ?? '',
        reservedSpace: json["reservedSpace"] ?? 0,
        spaceUsed: json["spaceUsed"] ?? 0,
        availableSpace: json["availableSpace"] ?? 0,
        warehouse: json["warehouse"] == null
            ? Warehouse.fromJson({})
            : Warehouse.fromJson(json["warehouse"]),
        temperature: json["temperature"] == null
            ? Temperature.fromJson({})
            : Temperature.fromJson(json["temperature"]),
        phone: json["phone"] ?? '',
        phone2: json["phone2"] ?? '',
        rejectReason: json["rejectReason"] ?? '',
        status: json["status"] ?? 0,
        inventoryDescription: json["inventoryDescription"] ?? '',
        address: json["address"] == null
            ? Address.fromJson({})
            : Address.fromJson(json["address"]),
        id: json["id"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "customerId": customerId,
        "startDate": startDate,
        "endDate": endDate,
        "reservedSpace": reservedSpace,
        "spaceUsed": spaceUsed,
        "availableSpace": availableSpace,
        "warehouse": warehouse.toJson(),
        "phone": phone,
        "phone2": phone2,
        "rejectReason": rejectReason,
        "status": status,
        "inventoryDescription": inventoryDescription,
        "address": address.toJson(),
        "id": id,
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

class Temperature {
  int fromTemperature;
  int toTemperature;
  double cost;
  int id;

  Temperature({
    required this.fromTemperature,
    required this.toTemperature,
    required this.cost,
    required this.id,
  });

  factory Temperature.fromJson(Map<String, dynamic> json) => Temperature(
        fromTemperature: json["fromTemperature"] ?? 0,
        toTemperature: json["toTemperature"] ?? 0,
        cost: json["cost"] ?? 0,
        id: json["id"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "fromTemperature": fromTemperature,
        "toTemperature": toTemperature,
        "cost": cost,
        "id": id,
      };
}

class Warehouse {
  int id;
  String name;

  Warehouse({
    required this.id,
    required this.name,
  });

  factory Warehouse.fromJson(Map<String, dynamic> json) => Warehouse(
        id: json["id"] ?? 0,
        name: json["name"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
