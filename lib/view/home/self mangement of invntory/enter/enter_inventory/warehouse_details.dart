import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

import 'add_space.dart';

class WarehouseDetails extends StatefulWidget {
  final String id;
  final String warehouseName;
  final double price;
  final String distance;
  final LatLng warehouseLocation;
  final LatLng inventoryLocation;

  const WarehouseDetails({
    super.key,
    required this.id,
    required this.warehouseName,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('تفاصيل المخزن'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'اسم المخزن: ${widget.warehouseName}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'التكلفة: ${widget.price} ريال سعودي',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'المسافة: ${widget.distance} كم',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'موقع المخزن:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              'العرض: ${widget.warehouseLocation.latitude}',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'الطول: ${widget.warehouseLocation.longitude}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'موقع المخزون:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              'العرض: ${widget.inventoryLocation.latitude}',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'الطول: ${widget.inventoryLocation.longitude}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'الخريطة:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Container(
              height: 300,
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
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => AddSpace(),
                    ));
                  },
                  child: Text(
                    'Continue',
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
}
