import 'dart:convert';

TransferModel transferModelFromJson(String str) =>
    TransferModel.fromJson(json.decode(str));

String transferModelToJson(TransferModel data) =>
    json.encode(data.toJson());

class TransferModel {
  TransferModel({
    required this.totalCount,
    required this.data,
  });

  int totalCount;
  List<TransferDataModel> data;

  factory TransferModel.fromJson(Map<String, dynamic> json) =>
      TransferModel(
        totalCount: json["totalCount"] ?? 0,
        data: json["data"] == null
            ? []
            : List<TransferDataModel>.from(
            json["data"].map((x) => TransferDataModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "totalCount": totalCount,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class TransferDataModel {
  TransferDataModel({
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

  factory TransferDataModel.fromJson(Map<String, dynamic> json) =>
      TransferDataModel(
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
