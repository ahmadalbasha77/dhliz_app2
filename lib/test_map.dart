import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TestMap extends StatefulWidget {
  const TestMap({Key? key}) : super(key: key);

  @override
  _TestMapState createState() => _TestMapState();
}

class _TestMapState extends State<TestMap> {
  List<dynamic> data = [];
  List<Marker> markers = [];
  TextEditingController capacityController = TextEditingController();
  GoogleMapController? mapController;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData({int? capacity, String? address = 'Address'}) async {
    final Map<String, String> headers = {
      'ngrok-skip-browser-warning': 'latest',
    };
    final Uri uri = Uri.parse(
        'https://1706-46-248-204-177.ngrok-free.app/api/Warehouse/Find');

    // Initialize queryParameters with the 'Capacity' parameter
    final Map<String, dynamic> queryParameters =
        capacity != null ? {'Capacity': capacity.toString()} : {};

    // Add 'include' parameter to queryParameters if address is provided
    queryParameters['include'] = address;

    final Uri filteredUri = uri.replace(queryParameters: queryParameters);

    try {
      final response = await http.get(filteredUri, headers: headers);

      if (response.statusCode == 200) {
        print('Request successful');
        Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['isSuccess']) {
          data = responseData['response'][0];

          // Clear the markers list before adding new markers
          markers.clear();

          // Extract and store coordinates from the 'address' part
          for (final item in data) {
            if (item['address'] != null &&
                item['address'] is Map<String, dynamic>) {
              Map<String, dynamic> address = item['address']!;

              double? lat =
                  address['lat'] != null ? double.parse(address['lat']) : null;
              double? lon =
                  address['lot'] != null ? double.parse(address['lot']) : null;

              if (lat != null && lon != null) {
                // Add markers for each coordinate
                markers.add(
                  Marker(
                    markerId: MarkerId(item['id'].toString()),
                    position: LatLng(lat, lon),
                    infoWindow: InfoWindow(
                      title: item['name'] ?? '',
                      snippet: 'Capacity: ${item['capacity'] ?? ''}',
                    ),
                  ),
                );
              } else {
                print('Latitude or longitude is null for item: $item');
              }
            } else {
              print(
                  'Address is null or not in the expected format for item: $item');
            }
          }

          // Move the camera to fit all markers
          if (markers.isNotEmpty) {
            LatLngBounds bounds = boundsFromLatLngList(
                markers.map((marker) => marker.position).toList());
            mapController
                ?.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50.0));
          }

          // Trigger a rebuild to display the updated data
          setState(() {});
        } else {
          print('API returned an error: ${responseData['error']}');
        }
      } else {
        print('Request failed');
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (error) {
      print('Error during HTTP request: $error');
      // Handle errors here
    }
  }

  LatLngBounds boundsFromLatLngList(List<LatLng> list) {
    double? x0, x1, y0, y1;

    for (LatLng latLng in list) {
      if (x0 == null || latLng.latitude < x0) x0 = latLng.latitude;
      if (x1 == null || latLng.latitude > x1) x1 = latLng.latitude;
      if (y0 == null || latLng.longitude < y0) y0 = latLng.longitude;
      if (y1 == null || latLng.longitude > y1) y1 = latLng.longitude;
    }

    return LatLngBounds(
        northeast: LatLng(x1!, y1!), southwest: LatLng(x0!, y0!));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter API Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: capacityController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Enter Capacity',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                int? capacity = int.tryParse(capacityController.text);
                if (capacity != null) {
                  fetchData(capacity: capacity);
                } else {
                  print('Invalid capacity value');
                }
              },
              child: Text('Fetch Data'),
            ),
            SizedBox(height: 20),
            data.isEmpty
                ? CircularProgressIndicator()
                : Expanded(
                    child: GoogleMap(
                      onMapCreated: (GoogleMapController controller) {
                        mapController = controller;
                      },
                      initialCameraPosition: CameraPosition(
                        target: LatLng(31, 20),
                        zoom: 10.0,
                      ),
                      markers: Set.from(markers),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
