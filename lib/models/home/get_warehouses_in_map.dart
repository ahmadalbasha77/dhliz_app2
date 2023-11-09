

class WarehouseInMapModel {
  WarehouseInMapModel({
    required this.id,
    required this.name,
    required this.price,
    required this.lat,
    required this.lot,
    required this.meter,
    required this.woodenPallets,
  });

  String id;
  String name;
  double price;
  String lat;
  String lot;
  int meter;
  int woodenPallets;

  factory WarehouseInMapModel.fromJson(Map<String, dynamic> json) =>
      WarehouseInMapModel(
        id: json["id"] ?? "",
        name: json["name"] ?? "",
        price: json["price"] ?? 0.0,
        lat: json["lat"] ?? "",
        lot: json["lot"] ?? "",
        meter: json["meter"] ?? 0,
        woodenPallets: json["woodenPallets"] ?? 0,

      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "price": price,
    "lat": lat,
    "lot": lot,
    "meter": meter,
    "woodenPallets": woodenPallets,
  };
}
