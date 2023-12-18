import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DeliveryLocationScreen extends StatefulWidget {
  const DeliveryLocationScreen({super.key});

  @override
  State<DeliveryLocationScreen> createState() => _DeliveryLocationScreenState();
}

class _DeliveryLocationScreenState extends State<DeliveryLocationScreen> {
  late Position cl;
  CameraPosition? _kGooglePlex;

  Set<Marker> marker = {};

  Future<void> getPosition() async {
    bool service;
    service = await Geolocator.isLocationServiceEnabled();
    LocationPermission per =
        LocationPermission.denied; // Initialize with a default value

    try {
      per = await Geolocator.checkPermission();
      if (per == LocationPermission.denied) {
        per = await Geolocator.requestPermission();
        showDialog(
          context: context,
          builder: (context) {
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        );
      }
    } catch (e) {
      print("Error checking or requesting permission: $e");
    }

    if (service && per == LocationPermission.whileInUse) {
      cl = await Geolocator.getCurrentPosition();
      marker.add(
        Marker(
          draggable: true,
          markerId: MarkerId('1'),
          position: LatLng(cl.latitude, cl.longitude),
        ),
      );
      // Move the camera to the current location
      _kGooglePlex = CameraPosition(
        zoom: 14.5,
        target: LatLng(cl.latitude, cl.longitude),
      );
    }

    setState(() {});
  }

  @override
  void initState() {
    getPosition();
    super.initState();
  }

  late LatLng myLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _kGooglePlex == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Stack(
                children: [
                  GoogleMap(
                    markers: marker,
                    mapType: MapType.normal,
                    initialCameraPosition: _kGooglePlex!,
                    onMapCreated: (GoogleMapController controller) {},
                    onTap: (myLocation) {
                      marker.clear();
                      marker.add(Marker(
                          position: myLocation, markerId: MarkerId('1')));
                      setState(() {
                        print('=====================');
                        print(myLocation.latitude);
                        print(myLocation.longitude);
                      });
                    },
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                          Color.fromARGB(255, 35, 37, 56),
                        )),
                        onPressed: () {
                          print(myLocation.latitude);
                          print(myLocation.longitude);
                          print('Button Pressed!');
                          Get.back();
                        },
                        child: Text('Confirm location'.tr),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
