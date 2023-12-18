import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geocoding/geocoding.dart';

import 'pay_screen.dart';

class WarehouseDetails extends StatefulWidget {
  final String id;
  final String warehouseName;
  final String warehouseCap;
  final String phone;
  final double price;
  final String distance;
  final String from;
  final String to;
  final String address;
  final int capacity;
  final LatLng warehouseLocation;
  final LatLng inventoryLocation;
  bool dry;
  bool cold;
  bool freezing;

   WarehouseDetails({
    super.key,
    required this.id,
    required this.warehouseName,
    required this.warehouseCap,
    required this.phone,
    required this.dry,
    required this.cold,
    required this.freezing,
    required this.capacity,
    required this.address,
    required this.from,
    required this.to,
    required this.price,
    required this.distance,
    required this.warehouseLocation,
    required this.inventoryLocation,
  });

  @override
  _WarehouseDetailsState createState() => _WarehouseDetailsState();
}

class _WarehouseDetailsState extends State<WarehouseDetails> {
  BitmapDescriptor? customIcon1;
  BitmapDescriptor? customIconPickedLocation;

  GoogleMapController? mapController;
  PolylinePoints polylinePoints = PolylinePoints();
  List<LatLng> polylineCoordinates = [];

  @override
  void initState() {
    super.initState();
    _loadCustomIcons();
    _drawRoute();
    _getAddressFromLatLng();
  }

  void _loadCustomIcons() async {
    customIcon1 = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: 2.5),
      'image/map/warehoues.png',
    );

    customIconPickedLocation = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: 2.5),
      'image/map/inventory.png',
    );

    setState(() {});
  }

  void _drawRoute() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      'AIzaSyBGZuAzlhiW9_ZzL7n3A6wtHnye5uNvvYM',
      // Replace with your Google Maps API key
      PointLatLng(widget.inventoryLocation.latitude,
          widget.inventoryLocation.longitude),
      PointLatLng(widget.warehouseLocation.latitude,
          widget.warehouseLocation.longitude),
      travelMode: TravelMode.driving,
    );

    if (result.status == 'OK') {
      polylineCoordinates.clear();
      for (PointLatLng point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }

      setState(() {});
    }
  }

  String address = '';

  Future<void> _getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        widget.inventoryLocation.latitude,
        widget.inventoryLocation.longitude,
      );

      if (placemarks != null && placemarks.isNotEmpty) {
        Placemark placemark = placemarks[0];
        setState(() {
          address =
              '${placemark.locality} , ${placemark.administrativeArea}, ${placemark.street},';
          print(address);
        });
      } else {
        setState(() {
          address = 'Could not fetch the address';
        });
      }
    } catch (e) {
      print(e);
      setState(() {
        address = 'Error occurred while fetching the address $e';
        print(address);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Warehouse details'.tr),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${'Warehouse name'.tr}: ${widget.warehouseName}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              '${'phone'.tr}: ${widget.phone} ',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              '${'the cost'.tr}: ${widget.price} ${'SR'.tr}',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              '${'capacity'.tr}: ${widget.warehouseCap} ',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              '${'distance'.tr}: ${widget.distance} ${'km'.tr}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              '${'Inventory location'.tr}:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              '${'Address'.tr} :  ',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              address,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 40),
            Container(
              height: 350,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: widget.warehouseLocation,
                  zoom: 13,
                ),
                markers: {
                  if (customIcon1 != null)
                    Marker(
                      markerId: MarkerId('warehouseLocation'),
                      position: widget.warehouseLocation,
                      icon: customIcon1!,
                    ),
                  if (customIconPickedLocation != null)
                    Marker(
                      markerId: MarkerId('inventoryLocation'),
                      position: widget.inventoryLocation,
                      icon: customIconPickedLocation!,
                    ),
                },
                polylines: {
                  if (polylineCoordinates.isNotEmpty)
                    Polyline(
                      polylineId: PolylineId('route'),
                      color: Colors.blue,
                      points: polylineCoordinates,
                      width: 5,
                    ),
                },
                onMapCreated: (controller) {
                  if (controller != null) {
                    mapController = controller;
                  }
                },
              ),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                width: 250,
                height: 55,
                child: ElevatedButton(
                  style: ButtonStyle(
                    elevation: MaterialStatePropertyAll(0),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
                    backgroundColor: MaterialStateProperty.all(
                      Color.fromRGBO(38, 50, 56, 1),
                    ),
                  ),
                  onPressed: () async {
                    int? customerId = await getSavedIdFromSharedPreferences();
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => PayScreen(
                        customerId: customerId ?? 0,
                        warehouseId: widget.id,
                        capacity: widget.capacity,
                        warehouseName: widget.warehouseName,
                        address: widget.address,
                        price: widget.price,
                        expiredDate: '14/12/2023',
                        space: widget.capacity.toString(),
                        dry: widget.dry,
                        cold: widget.cold,
                        freezing: widget.freezing,
                        from: widget.from,
                        to: widget.to,
                      ),
                    ));
                  },
                  child: Text(
                    'Continue'.tr,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<int?> getSavedIdFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('postId');
  }
}
