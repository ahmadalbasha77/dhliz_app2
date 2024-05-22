import 'dart:convert';

// Deserialize JSON string to SubscriptionsModel object
SubscriptionsModel subscriptionsModelFromJson(String str) =>
    SubscriptionsModel.fromJson(json.decode(str));

// Serialize SubscriptionsModel object to JSON string
String subscriptionsModelToJson(SubscriptionsModel data) =>
    json.encode(data.toJson());

class SubscriptionsModel {
  List<SubscriptionsDataModel> response;
  List<String> error;
  bool isSuccess;
  int count;

  SubscriptionsModel({
    required this.response,
    required this.error,
    required this.isSuccess,
    required this.count,
  });

  factory SubscriptionsModel.fromJson(Map<String, dynamic> json) =>
      SubscriptionsModel(
        response: List<SubscriptionsDataModel>.from(
            json["response"].map((x) => SubscriptionsDataModel.fromJson(x))),
        error: json["error"] == null
            ? []
            : List<String>.from(json["error"].map((x) => x ?? "")),
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

class SubscriptionsDataModel {
  int id;
  int customerId;
  String startDate;
  String endDate;
  int reservedSpace;
  int status;
  Warehouse warehouse;

  SubscriptionsDataModel({
    required this.id,
    required this.customerId,
    required this.startDate,
    required this.endDate,
    required this.reservedSpace,
    required this.status,
    required this.warehouse,
  });

  factory SubscriptionsDataModel.fromJson(Map<String, dynamic> json) =>
      SubscriptionsDataModel(
        id: json["id"] ?? 0,
        customerId: json["customerId"] ?? 0,
        startDate: json["startDate"] ?? '',
        endDate: json["endDate"] ?? '',
        reservedSpace: json["reservedSpace"] ?? 0,
        status: json["status"] ?? 0,
        warehouse: json["warehouse"] == null
            ? Warehouse.empty()
            : Warehouse.fromJson(json["warehouse"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "customerId": customerId,
        "startDate": startDate,
        "endDate": endDate,
        "reservedSpace": reservedSpace,
        "status": status,
        "warehouse": warehouse.toJson(),
      };

  // Provides a default empty object to handle potential nulls gracefully
  static SubscriptionsDataModel empty() => SubscriptionsDataModel(
        id: 0,
        customerId: 0,
        startDate: '',
        endDate: '',
        reservedSpace: 0,
        status: 0,
        warehouse: Warehouse.empty(),
      );
}

class Warehouse {
  int id;
  String name;
  String phone;
  String phone2;
  Address address;
  Temperature temperature;
  int capacity;
  List<Price> price;
  int spaceUsed;

  Warehouse({
    required this.id,
    required this.name,
    required this.phone,
    required this.phone2,
    required this.address,
    required this.temperature,
    required this.capacity,
    required this.price,
    required this.spaceUsed,
  });

  factory Warehouse.fromJson(Map<String, dynamic> json) => Warehouse(
        id: json["id"] ?? 0,
        name: json["name"] ?? "",
        phone: json["phone"] ?? "",
        phone2: json["phone2"] ?? "",
        address: json["address"] == null
            ? Address.empty()
            : Address.fromJson(json["address"]),
        temperature: json["temperature"] == null
            ? Temperature.empty()
            : Temperature.fromJson(json["temperature"]),
        capacity: json["capacity"] ?? 0,
        price: json["price"] == null
            ? []
            : List<Price>.from(json["price"]
                .map((x) => x == null ? Price.empty() : Price.fromJson(x))),
        spaceUsed: json["spaceUsed"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone": phone,
        "phone2": phone2,
        "address": address.toJson(),
        "temperature": temperature.toJson(),
        "capacity": capacity,
        "price": List<dynamic>.from(price.map((x) => x.toJson())),
        "spaceUsed": spaceUsed,
      };

  // Provides a default empty object
  static Warehouse empty() => Warehouse(
        id: 0,
        name: "",
        phone: "",
        phone2: "",
        address: Address.empty(),
        temperature: Temperature.empty(),
        capacity: 0,
        price: [],
        spaceUsed: 0,
      );
}

class Address {
  String city;
  String state;
  String street;
  String lat;
  String lot;
  int id;

  Address({
    required this.city,
    required this.state,
    required this.street,
    required this.lat,
    required this.lot,
    required this.id,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        city: json["city"] ?? "",
        state: json["state"] ?? "",
        street: json["street"] ?? "",
        lat: json["lat"] ?? "",
        lot: json["lot"] ?? "",
        id: json["id"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "city": city,
        "state": state,
        "street": street,
        "lat": lat,
        "lot": lot,
        "id": id,
      };

  // Provides a default empty object
  static Address empty() => Address(
        city: "",
        state: "",
        street: "",
        lat: "",
        lot: "",
        id: 0,
      );
}

class Price {
  double cost;
  double commission;
  double transportationFees;
  int id;

  Price({
    required this.cost,
    required this.commission,
    required this.transportationFees,
    required this.id,
  });

  factory Price.fromJson(Map<String, dynamic> json) => Price(
        cost: json["cost"] ?? 0.0,
        commission: json["commission"] ?? 0.0,
        transportationFees: json["transportationFees"] ?? 0.0,
        id: json["id"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "cost": cost,
        "commission": commission,
        "transportationFees": transportationFees,
        "id": id,
      };

  // Provides a default empty object
  static Price empty() => Price(
        cost: 0.0,
        commission: 0.0,
        transportationFees: 0.0,
        id: 0,
      );
}

class Temperature {
  bool high;
  bool cold;
  bool freezing;
  bool dry;
  int id;

  Temperature({
    required this.high,
    required this.cold,
    required this.freezing,
    required this.dry,
    required this.id,
  });

  factory Temperature.fromJson(Map<String, dynamic> json) => Temperature(
        high: json["high"] ?? false,
        cold: json["cold"] ?? false,
        freezing: json["freezing"] ?? false,
        dry: json["dry"] ?? false,
        id: json["id"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "high": high,
        "cold": cold,
        "freezing": freezing,
        "dry": dry,
        "id": id,
      };

  // Provides a default empty object
  static Temperature empty() => Temperature(
        high: false,
        cold: false,
        freezing: false,
        dry: false,
        id: 0,
      );
}
