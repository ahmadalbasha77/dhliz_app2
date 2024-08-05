import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapWarehouseScreen extends StatefulWidget {
  double lat;
  double lon;
  String nameWh;

  MapWarehouseScreen(
      {Key? key, required this.lat, required this.lon, required this.nameWh})
      : super(key: key);

  @override
  State<MapWarehouseScreen> createState() => _MapWarehouseScreenState();
}

class _MapWarehouseScreenState extends State<MapWarehouseScreen> {
  BitmapDescriptor? customIcon;

  Future<void> _createCustomIcon() async {
    try {
      customIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 1.5),
        'image/map/warehoues.png',
      );
    } catch (e) {
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
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          widget.nameWh,
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: customIcon == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(widget.lat, widget.lon),
                zoom: 15,
              ),
              markers: {
                Marker(
                  icon: customIcon!,
                  markerId: MarkerId('your_marker_id'),
                  position: LatLng(widget.lat, widget.lon),
                  infoWindow: InfoWindow(title: widget.nameWh),
                ),
              },
            ),
    );
  }
}
