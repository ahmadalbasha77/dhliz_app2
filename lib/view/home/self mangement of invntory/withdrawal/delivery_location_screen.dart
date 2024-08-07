import 'dart:developer';

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
  LatLng myLocation = const LatLng(0.0, 0.0);
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
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        );
      }
    } catch (e) {
      log('$e');
    }

    if (service && per == LocationPermission.whileInUse) {
      cl = await Geolocator.getCurrentPosition();
      marker.add(
        Marker(
          draggable: true,
          markerId: const MarkerId('1'),
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

  // late LatLng myLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _kGooglePlex == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Stack(
                children: [
                  GoogleMap(
                    markers: marker,
                    mapType: MapType.normal,
                    initialCameraPosition: _kGooglePlex!,
                    onMapCreated: (GoogleMapController controller) {},
                    onTap: (tapLocation) {
                      marker.clear();
                      marker.add(Marker(
                          position: myLocation, markerId: const MarkerId('1')));
                      setState(() {
                        myLocation = tapLocation;
                      });
                    },
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ElevatedButton(
                        style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                          Color.fromARGB(255, 35, 37, 56),
                        )),
                        onPressed: () {
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
