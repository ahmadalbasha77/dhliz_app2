// To parse this JSON data, do
//
//     final transactionModel = transactionModelFromJson(jsonString);

import 'dart:convert';

TransactionModel transactionModelFromJson(String str) =>
    TransactionModel.fromJson(json.decode(str));

String transactionModelToJson(TransactionModel data) =>
    json.encode(data.toJson());

class TransactionModel {
  List<TransactionDataModel> response;
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
        response: List<TransactionDataModel>.from(
            json["response"].map((x) => TransactionDataModel.fromJson(x))),
        error: List<String>.from(json["error"].map((x) => x)),
        isSuccess: json["isSuccess"] ?? false,
        count: json["count"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "response": List<dynamic>.from(response.map((x) => x.toJson())),
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
  String phone;
  String stockName;
  int quantity;
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
    required this.phone,
    required this.stockName,
    required this.quantity,
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
        transactionId: json["transactionId"] ?? 0,
        fromStockId: json["fromStockId"] ?? 0,
        toStockId: json["toStockId"] ?? 0,
        customerName: json["customerName"] ?? '',
        phone: json["phone"] ?? '',
        stockName: json["stockName"] ?? '',
        quantity: json["quantity"] ?? 0,
        fromWarehouse: json["fromWarehouse"] ?? '',
        fromSubscriptionId: json["fromSubscriptionId"] ?? 0,
        toSubscriptionId: json["toSubscriptionId"] ?? 0,
        toWarehouse: json["toWarehouse"] ?? '',
        fromWarehouseId: json["fromWarehouseId"] ?? 0,
        toWarehouseId: json["toWarehouseId"] ?? 0,
        actionType: json["actionType"] ?? 0,
        status: json["status"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "transactionId": transactionId,
        "fromStockId": fromStockId,
        "toStockId": toStockId,
        "customerName": customerName,
        "phone": phone,
        "stockName": stockName,
        "quantity": quantity,
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
