
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarkerInfo {
  final String id;
  final LatLng position;
  final String nameWarehouse;
  final String capacity;
  final double pricePerMeter;
  final int numberOfMeter;
  final String phone;
  final String address;
  final double transportationFees;

  MarkerInfo({
    required this.id,
    required this.position,
    required this.nameWarehouse,
    required this.capacity,
    required this.pricePerMeter,
    required this.numberOfMeter,
    required this.phone,
    required this.address,
    required this.transportationFees,
  });
}