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
    required this.startDate,
    required this.endDate,
    required this.reservedSpace,

  });

  String id;
  String startDate;
  String endDate;
  int reservedSpace;

  factory MyWarehouseDataModel.fromJson(Map<String, dynamic> json) =>
      MyWarehouseDataModel(
        id: json["id"] ?? "",
        startDate: json["startDate"] ?? "",
        endDate: json["endDate"] ?? "",
        reservedSpace: json["reservedSpace"] ?? "",

      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "startDate": startDate,
    "endDate": endDate,
    "reservedSpace": reservedSpace,

  };
}
