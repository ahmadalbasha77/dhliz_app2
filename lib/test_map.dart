import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';


class TestMap extends StatefulWidget {
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

  Future<void> fetchData({int? capacity}) async {
    final Map<String, String> headers = {'ngrok-skip-browser-warning': 'latest'};
    final Uri uri = Uri.parse('https://10bf-81-253-114-36.ngrok-free.app/api/Warehouse/GetAllWarehouseLabelDto');

    final Map<String, dynamic> queryParameters = capacity != null ? {'Capacity': capacity.toString()} : {};
    final Uri filteredUri = uri.replace(queryParameters: queryParameters);

    final response = await http.get(filteredUri, headers: headers);

    if (response.statusCode == 200) {
      print('Request successful');
      Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['isSuccess']) {
        data = responseData['response'][0];

        // Clear the markers list before adding new markers
        markers.clear();

        // Extract and store coordinates
        for (final item in data) {
          double lat = double.parse(item['lat'].toString());
          double lon = double.parse(item['lot'].toString());

          // Add markers for each coordinate
          markers.add(
            Marker(
              markerId: MarkerId(item['id'].toString()),
              position: LatLng(lat, lon),
              infoWindow: InfoWindow(
                title: item['name'],
                snippet: 'Capacity: ${item['capacity']}',
              ),
            ),
          );
        }

        // Move the camera to fit all markers
        if (markers.isNotEmpty) {
          LatLngBounds bounds = boundsFromLatLngList(markers.map((marker) => marker.position).toList());
          mapController?.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50.0));
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
  }

  LatLngBounds boundsFromLatLngList(List<LatLng> list) {
    double? x0, x1, y0, y1;

    for (LatLng latLng in list) {
      if (x0 == null || latLng.latitude < x0!) x0 = latLng.latitude;
      if (x1 == null || latLng.latitude > x1!) x1 = latLng.latitude;
      if (y0 == null || latLng.longitude < y0!) y0 = latLng.longitude;
      if (y1 == null || latLng.longitude > y1!) y1 = latLng.longitude;
    }

    return LatLngBounds(northeast: LatLng(x1!, y1!), southwest: LatLng(x0!, y0!));
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
                  target: LatLng(0, 0),
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

