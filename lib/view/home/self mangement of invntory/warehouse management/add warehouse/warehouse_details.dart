import 'package:dhliz_app/config/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';

import 'map_screen.dart';
import 'pay_screen.dart';

class WarehouseDetails extends StatefulWidget {
  final double totalAmount;
  final double cost;
  final String from;
  final String to;
  final String inventoryDescription;
  final int capacity;
  final LatLng inventoryLocation;
  final String temp;
  final int tempId;
  final MarkerInfo info;

  const WarehouseDetails({
    super.key,
    required this.totalAmount,
    required this.cost,
    required this.temp,
    required this.capacity,
    required this.inventoryDescription,
    required this.from,
    required this.to,
    required this.inventoryLocation,
    required this.tempId,
    required this.info,
  });

  @override
  WarehouseDetailsState createState() => WarehouseDetailsState();
}

class WarehouseDetailsState extends State<WarehouseDetails> {
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
      const ImageConfiguration(devicePixelRatio: 2.5),
      'image/ios/warehoues.png',
    );

    customIconPickedLocation = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(devicePixelRatio: 2.5),
      'image/ios/inventory.png',
    );

    setState(() {});
  }

  void _drawRoute() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      'AIzaSyBGZuAzlhiW9_ZzL7n3A6wtHnye5uNvvYM',
      // Replace with your Google Maps API key
      PointLatLng(widget.inventoryLocation.latitude,
          widget.inventoryLocation.longitude),
      PointLatLng(
          widget.info.position.latitude, widget.info.position.longitude),
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

      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks[0];
        setState(() {
          address =
              '${placemark.locality} , ${placemark.administrativeArea}, ${placemark.street},';
        });
      } else {
        setState(() {
          address = 'Could not fetch the address';
        });
      }
    } catch (e) {
      setState(() {
        address = 'Error occurred while fetching the address $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.buttonColor,
        title: Text('Warehouse details'.tr),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${'Warehouse Name'.tr}: ${widget.info.nameWarehouse}',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 6.h,
              ),
              Text(
                '${'phone'.tr}: ${widget.info.phone} ',
                style: const TextStyle(fontSize: 16),
              ),
              SizedBox(
                height: 6.h,
              ),
              Text(
                '${'The cost'.tr}: ${widget.cost} ${'SAR/M²'.tr}',
                style: const TextStyle(fontSize: 16),
              ),
              // SizedBox(
              //   height: 6.h,
              // ),
              // Text(
              //   '${'Capacity'.tr}: ${widget.capacity} M²',
              //   style: TextStyle(fontSize: 16),
              // ),
              SizedBox(
                height: 6.h,
              ),
              // Text(
              //   '${'Transportation Fees'.tr}: ${0} SR',
              //   style: TextStyle(fontSize: 16),
              // ),
              SizedBox(
                height: 7.h,
              ),
              Text(
                '${'Temperature'.tr}: ${widget.temp} ${'°C'.tr}',
                style: const TextStyle(fontSize: 16),
              ),
              SizedBox(
                height: 7.h,
              ),
              Text(
                '${'warehouse location'.tr}:',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 7.h,
              ),
              Text(
                '${'Address'.tr} :  ',
                style: const TextStyle(fontSize: 16),
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                widget.info.address,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 40),
              SizedBox(
                height: 350,
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: widget.info.position,
                    zoom: 13,
                  ),
                  markers: {
                    if (customIcon1 != null)
                      Marker(
                        markerId: const MarkerId('warehouseLocation'),
                        position: widget.info.position,
                        icon: customIcon1!,
                      ),
                    if (customIconPickedLocation != null)
                      Marker(
                        markerId: const MarkerId('inventoryLocation'),
                        position: widget.inventoryLocation,
                        icon: customIconPickedLocation!,
                      ),
                  },
                  polylines: {
                    if (polylineCoordinates.isNotEmpty)
                      Polyline(
                        polylineId: const PolylineId('route'),
                        color: Colors.blue,
                        points: polylineCoordinates,
                        width: 5,
                      ),
                  },
                  onMapCreated: (controller) {
                    mapController = controller;
                                    },
                ),
              ),
              Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  width: 250.w,
                  height: 45.h,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      elevation: const MaterialStatePropertyAll(0),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      )),
                      backgroundColor: MaterialStateProperty.all(
                        AppColor.buttonColor,
                      ),
                    ),
                    onPressed: () async {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => PayScreen(
                          info: widget.info,
                          cost: widget.cost,
                          inventoryDescription: widget.inventoryDescription,
                          totalAmount: widget.totalAmount,
                          capacity: widget.capacity,
                          temp: widget.temp,
                          tempId: widget.tempId,
                          from: widget.from,
                          to: widget.to,
                        ),
                      ));
                    },
                    child: Text(
                      'Continue'.tr,
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
