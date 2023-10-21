import 'dart:convert';

WithdrawalWarehouseModel withdrawalWarehouseModelFromJson(String str) =>
    WithdrawalWarehouseModel.fromJson(json.decode(str));

String withdrawalWarehouseModelToJson(WithdrawalWarehouseModel data) =>
    json.encode(data.toJson());

class WithdrawalWarehouseModel {
  WithdrawalWarehouseModel({
    required this.totalCount,
    required this.data,
  });

  int totalCount;
  List<WithdrawalWarehouseDataModel> data;

  factory WithdrawalWarehouseModel.fromJson(Map<String, dynamic> json) =>
      WithdrawalWarehouseModel(
        totalCount: json["totalCount"] ?? 0,
        data: json["data"] == null
            ? []
            : List<WithdrawalWarehouseDataModel>.from(
            json["data"].map((x) => WithdrawalWarehouseDataModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "totalCount": totalCount,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class WithdrawalWarehouseDataModel {
  WithdrawalWarehouseDataModel({
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

  factory WithdrawalWarehouseDataModel.fromJson(Map<String, dynamic> json) =>
      WithdrawalWarehouseDataModel(
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
