import 'dart:convert';

WithdrawalModel withdrawalModelFromJson(String str) =>
    WithdrawalModel.fromJson(json.decode(str));

String withdrawalModelToJson(WithdrawalModel data) =>
    json.encode(data.toJson());

class WithdrawalModel {
  WithdrawalModel({
    required this.totalCount,
    required this.data,
  });

  int totalCount;
  List<WithdrawalDataModel> data;

  factory WithdrawalModel.fromJson(Map<String, dynamic> json) =>
      WithdrawalModel(
        totalCount: json["totalCount"] ?? 0,
        data: json["data"] == null
            ? []
            : List<WithdrawalDataModel>.from(
            json["data"].map((x) => WithdrawalDataModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "totalCount": totalCount,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class WithdrawalDataModel {
  WithdrawalDataModel({
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

  factory WithdrawalDataModel.fromJson(Map<String, dynamic> json) =>
      WithdrawalDataModel(
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
