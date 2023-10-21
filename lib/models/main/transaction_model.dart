import 'dart:convert';

TransactionModel transactionModelFromJson(String str) =>
    TransactionModel.fromJson(json.decode(str));

String transactionModelToJson(TransactionModel data) =>
    json.encode(data.toJson());

class TransactionModel {
  TransactionModel({
    required this.totalCount,
    required this.data,
  });

  int totalCount;
  List<TransactionDataModel> data;

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      TransactionModel(
        totalCount: json["totalCount"] ?? 0,
        data: json["data"] == null
            ? []
            : List<TransactionDataModel>.from(
            json["data"].map((x) => TransactionDataModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "totalCount": totalCount,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class TransactionDataModel {
  TransactionDataModel({
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

  factory TransactionDataModel.fromJson(Map<String, dynamic> json) =>
      TransactionDataModel(
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
