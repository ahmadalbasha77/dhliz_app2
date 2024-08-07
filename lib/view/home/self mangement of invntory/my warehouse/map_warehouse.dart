import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapWarehouseScreen extends StatefulWidget {
  final double lat;
  final double lon;
  final String nameWh;

  const MapWarehouseScreen(
      {Key? key, required this.lat, required this.lon, required this.nameWh})
      : super(key: key);

  @override
  State<MapWarehouseScreen> createState() => _MapWarehouseScreenState();
}

class _MapWarehouseScreenState extends State<MapWarehouseScreen> {
  BitmapDescriptor? customIcon;

  Future<void> _createCustomIcon() async {
    try {
      if (Platform.isIOS) {
        customIcon = await BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(devicePixelRatio: 2.5),
          'image/ios/warehoues.png',
        );
      } else {
        customIcon = await BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(devicePixelRatio: 1.5),
          'image/map/warehoues.png',
        );
      }
    } catch (e) {
      log('$e');
    }
  }

  @override
  void initState() {
    _createCustomIcon().then((_) {
      // Ensure that the map is rebuilt after the custom icon is loaded.
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          widget.nameWh,
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: customIcon == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : GoogleMap(
              myLocationButtonEnabled: false,
              initialCameraPosition: CameraPosition(
                target: LatLng(widget.lat, widget.lon),
                zoom: 15,
              ),
              markers: {
                Marker(
                  icon: customIcon!,
                  markerId: const MarkerId('your_marker_id'),
                  position: LatLng(widget.lat, widget.lon),
                  infoWindow: InfoWindow(title: widget.nameWh),
                ),
              },
            ),
    );
  }
}
