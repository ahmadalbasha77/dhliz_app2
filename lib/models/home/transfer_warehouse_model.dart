import 'dart:convert';

TransferWarehouseModel transferWarehouseModelFromJson(String str) =>
    TransferWarehouseModel.fromJson(json.decode(str));

String transferWarehouseModelToJson(TransferWarehouseModel data) =>
    json.encode(data.toJson());

class TransferWarehouseModel {
  TransferWarehouseModel({
    required this.totalCount,
    required this.data,
  });

  int totalCount;
  List<TransferWarehouseDataModel> data;

  factory TransferWarehouseModel.fromJson(Map<String, dynamic> json) =>
      TransferWarehouseModel(
        totalCount: json["totalCount"] ?? 0,
        data: json["data"] == null
            ? []
            : List<TransferWarehouseDataModel>.from(
            json["data"].map((x) => TransferWarehouseDataModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "totalCount": totalCount,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class TransferWarehouseDataModel {
  TransferWarehouseDataModel({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.url,
    required this.isPro,
    required this.date,
  });

  String id;
  String title;
  String description;
  String image;
  String url;
  bool isPro;
  DateTime? date;

  factory TransferWarehouseDataModel.fromJson(Map<String, dynamic> json) =>
      TransferWarehouseDataModel(
        id: json["id"] ?? "",
        title: json["title"] ?? "",
        description: json["description"] ?? "",
        image: json["image"] ?? "",
        url: json["url"] ?? "",
        isPro: json["isPro"] ?? false,
        date: DateTime.tryParse(json["date"] ?? ""),
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "image": image,
    "url": url,
    "isPro": isPro,
    "datePublication": date?.toIso8601String() ?? '',
  };
}
