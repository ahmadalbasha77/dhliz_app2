// To parse this JSON data, do
//
//     final transactionModel = transactionModelFromJson(jsonString);

import 'dart:convert';

TransactionModel transactionModelFromJson(String str) =>
    TransactionModel.fromJson(json.decode(str));

String transactionModelToJson(TransactionModel data) =>
    json.encode(data.toJson());

class TransactionModel {
  List<List<TransactionDataModel>> response;
  List<String> error;
  bool isSuccess;
  int count;

  TransactionModel({
    required this.response,
    required this.error,
    required this.isSuccess,
    required this.count,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      TransactionModel(
        response: List<List<TransactionDataModel>>.from(json["response"].map(
            (x) => List<TransactionDataModel>.from(
                x.map((x) => TransactionDataModel.fromJson(x))))),
        error: List<String>.from(json["error"].map((x) => x)),
        isSuccess: json["isSuccess"],
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "response": List<dynamic>.from(
            response.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
        "error": List<dynamic>.from(error.map((x) => x)),
        "isSuccess": isSuccess,
        "count": count,
      };
}

class TransactionDataModel {
  int transactionId;
  int fromStockId;
  int toStockId;
  String customerName;
  DateTime createDate;
  String phone;
  String stockName;
  int quantity;
  Temperature temperature;
  String fromWarehouse;
  int fromSubscriptionId;
  int toSubscriptionId;
  String toWarehouse;
  int fromWarehouseId;
  int toWarehouseId;
  int actionType;
  int status;

  TransactionDataModel({
    required this.transactionId,
    required this.fromStockId,
    required this.toStockId,
    required this.customerName,
    required this.createDate,
    required this.phone,
    required this.stockName,
    required this.quantity,
    required this.temperature,
    required this.fromWarehouse,
    required this.fromSubscriptionId,
    required this.toSubscriptionId,
    required this.toWarehouse,
    required this.fromWarehouseId,
    required this.toWarehouseId,
    required this.actionType,
    required this.status,
  });

  factory TransactionDataModel.fromJson(Map<String, dynamic> json) =>
      TransactionDataModel(
        transactionId: json["transactionId"],
        fromStockId: json["fromStockId"],
        toStockId: json["toStockId"],
        customerName: json["customerName"],
        createDate: DateTime.parse(json["createDate"]),
        phone: json["phone"],
        stockName: json["stockName"],
        quantity: json["quantity"],
        temperature: Temperature.fromJson(json["temperature"]),
        fromWarehouse: json["fromWarehouse"],
        fromSubscriptionId: json["fromSubscriptionId"],
        toSubscriptionId: json["toSubscriptionId"],
        toWarehouse: json["toWarehouse"],
        fromWarehouseId: json["fromWarehouseId"],
        toWarehouseId: json["toWarehouseId"],
        actionType: json["actionType"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "transactionId": transactionId,
        "fromStockId": fromStockId,
        "toStockId": toStockId,
        "customerName": customerName,
        "createDate": createDate.toIso8601String(),
        "phone": phone,
        "stockName": stockName,
        "quantity": quantity,
        "temperature": temperature.toJson(),
        "fromWarehouse": fromWarehouse,
        "fromSubscriptionId": fromSubscriptionId,
        "toSubscriptionId": toSubscriptionId,
        "toWarehouse": toWarehouse,
        "fromWarehouseId": fromWarehouseId,
        "toWarehouseId": toWarehouseId,
        "actionType": actionType,
        "status": status,
      };
}

class Temperature {
  bool high;
  bool cold;
  bool freezing;
  bool dry;
  int id;

  Temperature({
    required this.high,
    required this.cold,
    required this.freezing,
    required this.dry,
    required this.id,
  });

  factory Temperature.fromJson(Map<String, dynamic> json) => Temperature(
        high: json["high"],
        cold: json["cold"],
        freezing: json["freezing"],
        dry: json["dry"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "high": high,
        "cold": cold,
        "freezing": freezing,
        "dry": dry,
        "id": id,
      };
}
