import 'dart:convert';

MyWarehouseModel myWarehouseModelFromJson(String str) =>
    MyWarehouseModel.fromJson(json.decode(str));

String myWarehouseModelToJson(MyWarehouseModel data) =>
    json.encode(data.toJson());

class MyWarehouseModel {
  MyWarehouseModel({
    required this.totalCount,
    required this.data,
  });

  int totalCount;
  List<MyWarehouseDataModel> data;

  factory MyWarehouseModel.fromJson(Map<String, dynamic> json) =>
      MyWarehouseModel(
        totalCount: json["totalCount"] ?? 0,
        data: json["data"] == null
            ? []
            : List<MyWarehouseDataModel>.from(
            json["data"].map((x) => MyWarehouseDataModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "totalCount": totalCount,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class MyWarehouseDataModel {
  MyWarehouseDataModel({
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

  factory MyWarehouseDataModel.fromJson(Map<String, dynamic> json) =>
      MyWarehouseDataModel(
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
