import 'dart:convert';

NotificationModel notificationModelFromJson(String str) =>
    NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) =>
    json.encode(data.toJson());

class NotificationModel {
  NotificationModel({
    required this.totalCount,
    required this.data,
  });

  int totalCount;
  List<NotificationDataModel> data;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        totalCount: json["totalCount"] ?? 0,
        data: json["data"] == null
            ? []
            : List<NotificationDataModel>.from(
                json["data"].map((x) => NotificationDataModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "totalCount": totalCount,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class NotificationDataModel {
  NotificationDataModel({
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

  factory NotificationDataModel.fromJson(Map<String, dynamic> json) =>
      NotificationDataModel(
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
