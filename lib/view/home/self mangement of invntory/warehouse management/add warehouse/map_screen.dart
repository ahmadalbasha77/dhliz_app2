import 'dart:convert';
import 'dart:math';
import 'package:dhliz_app/config/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:search_map_place_updated/search_map_place_updated.dart';

import '../../../../../config/shared_prefs_client.dart';
import '../../../../../network/api_url.dart';
import 'warehouse_details.dart';

class MarkerInfo {
  final String id;
  final LatLng position;
  final String nameWarehouse;
  final String capacity;
  final double pricePerMeter;
  final int numberOfMeter;
  final String phone;
  final String address;

  MarkerInfo({
    required this.id,
    required this.position,
    required this.nameWarehouse,
    required this.capacity,
    required this.pricePerMeter,
    required this.numberOfMeter,
    required this.phone,
    required this.address,
  });
}

class RouteInfo {
  final double distance; // بالكيلومترات
  final int estimatedHours; // بالساعات
  final int estimatedMinutes; // بالدقائق

  RouteInfo(this.distance, this.estimatedHours, this.estimatedMinutes);
}

class MapScreen extends StatefulWidget {
  int space;
  bool dry;
  bool cold;
  bool freezing;
  String from;
  String to;
  String days;

  MapScreen(
      {Key? key,
      required this.space,
      required this.cold,
      required this.dry,
      required this.freezing,
      required this.from,
      required this.to,
      required this.days})
      : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng _pickedLocation = LatLng(0, 0);
  MarkerInfo? selectWarehouse;
  final LatLng _center = const LatLng(31.959414984821176, 35.85732029979889);
  List<dynamic> data = [];
  List<Marker> markers = [];
  GoogleMapController? mapController;
  late BitmapDescriptor customIcon1 = BitmapDescriptor.defaultMarker;
  late BitmapDescriptor customIcon2 = BitmapDescriptor.defaultMarker;
  late BitmapDescriptor customIconPickedLocation =
      BitmapDescriptor.defaultMarker;
  late Position currentPosition;
  List<LatLng> polylineCoordinates = [];
  late PolylinePoints polylinePoints;
  RouteInfo routeInfo = RouteInfo(0, 0, 0);

  @override
  void initState() {
    super.initState();
    _determinePosition();
    _loadCustomIcons();
    fetchData();
    print(widget.to);
    print(widget.from);
    polylinePoints = PolylinePoints();
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<void> getLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        currentPosition = position;
      });

      // عرض الموقع الحالي على الخريطة
      mapController!.animateCamera(
        CameraUpdate.newLatLng(
          LatLng(position.latitude, position.longitude),
        ),
      );

      // قم بتحديث الماركر
      // markers.clear();
      markers.add(
        Marker(
          icon: await BitmapDescriptor.fromAssetImage(
            ImageConfiguration(devicePixelRatio: 1.5),
            'image/map/user.png',
          ),
          markerId: MarkerId('selectedLocation'),
          position: LatLng(position.latitude, position.longitude),
          onTap: () {
            // Handle marker tap
            final LatLng position = markers.first.position;
            final double lat = position.latitude;
            final double lng = position.longitude;
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Selected Location'),
                  content: Text('Latitude: $lat\nLongitude: $lng'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('OK'.tr),
                    ),
                  ],
                );
              },
            );
          },
        ),
      );
    } catch (e) {
      print('Error getting location : $e');
    }
  }

  Future<void> fetchData({String? address = 'Address'}) async {
    final Map<String, String> headers = {
      'Authorization': 'Bearer ${sharedPrefsClient.accessToken}'
    };
    final Uri uri = Uri.parse('${ApiUrl.API_BASE_URL}/Warehouse/Find');

    // Initialize queryParameters with the 'Capacity' parameter
    final Map<String, dynamic> queryParameters =
        widget.space != null ? {'Capacity': widget.space.toString()} : {};

    // Add 'include' parameter to queryParameters if address is provided
    queryParameters['include'] = address;
    queryParameters['Temperature.High'] = widget.dry ? 'false' : '';
    queryParameters['Temperature.Cold'] = widget.cold ? 'false' : '';
    queryParameters['Temperature.Freezing'] = widget.freezing ? 'false' : '';

    final Uri filteredUri = uri.replace(queryParameters: queryParameters);

    try {
      final response = await http.get(filteredUri, headers: headers);

      if (response.statusCode == 200) {
        print('Request successful');
        Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['isSuccess']) {
          data = responseData['response'][0];
          if (data.isNotEmpty) {
            Map<String, dynamic> firstItem = data[0];
          } else {
            print('Response array is empty');
          }

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
                    icon: customIcon1,
                    infoWindow: InfoWindow(
                      onTap: () {
                        _showStoreDetailsDialog(MarkerInfo(
                          address:
                              '${item['address']['city']} ,${item['address']['state']} , ${item['address']['street']} ',
                          id: item['id'].toString(),
                          position: LatLng(lat, lon),
                          nameWarehouse: item['name'] ?? '',
                          capacity: ' ${item['capacity'] ?? ''}',
                          pricePerMeter: item['cost']?.toDouble() ?? 0.0,
                          numberOfMeter: 5,
                          phone: item['phone'] ?? '',
                        ));
                      },
                      title: item['name'],
                      snippet: 'اضغط هنا لعرض نفاصيل المخزن',
                    ),
                    onTap: () {
                      setState(() {
                        selectWarehouse = MarkerInfo(
                          address:
                              '${item['address']['city']} ,${item['address']['state']} , ${item['address']['street']} ',
                          id: item['id'].toString(),
                          position: LatLng(lat, lon),
                          nameWarehouse: item['name'] ?? '',
                          capacity: '${item['capacity'] ?? ''}',
                          pricePerMeter: item['cost']?.toDouble() ?? 0.0,
                          numberOfMeter: 5,
                          phone: item['phone'] ?? '',
                        );
                        _drawRoute();
                      });
                    },
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

          // Call the method to update camera position
          updateCameraPosition();

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

  void updateCameraPosition() {
    if (markers.isNotEmpty && mapController != null) {
      LatLngBounds bounds = boundsFromLatLngList(
          markers.map((marker) => marker.position).toList());
      mapController?.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50.0));
    }
  }

  void _showStoreDetailsDialog(MarkerInfo info) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('${info.nameWarehouse} ', style: TextStyle(fontSize: 26)),
          content: SizedBox(
            height: 200,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${'capacity'.tr} : ${info.capacity}'),
                  SizedBox(
                    height: 20,
                  ),
                  Text("${'phone'.tr} : ${info.phone}"),
                  SizedBox(
                    height: 20,
                  ),
                  Text("${'price Per Meter'.tr} : ${info.pricePerMeter}"),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                      "${'Total price'.tr} : ${info.pricePerMeter * widget.space * int.parse(widget.days)} "),
                ],
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll(Color.fromRGBO(38, 50, 56, 1))),
              child: Text('cancel'.tr),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  LatLngBounds boundsFromLatLngList(List<LatLng> list) {
    double? x0, x1, y0, y1;

    for (LatLng latLng in list) {
      if (x0 == null || latLng.latitude < x0!) x0 = latLng.latitude;
      if (x1 == null || latLng.latitude > x1!) x1 = latLng.latitude;
      if (y0 == null || latLng.longitude < y0!) y0 = latLng.longitude;
      if (y1 == null || latLng.longitude > y1!) y1 = latLng.longitude;
    }

    return LatLngBounds(
        northeast: LatLng(x1!, y1!), southwest: LatLng(x0!, y0!));
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.buttonColor,
        onPressed: () {
          getLocation();
        },
        child: Icon(Icons.my_location_rounded),
      ),
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              margin: EdgeInsets.all(5),
              height: MediaQuery.of(context).size.height,
              child: GoogleMap(
                myLocationButtonEnabled: false,
                myLocationEnabled: true,
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 15.0,
                ),
                markers: Set.from(markers),
                onTap: (value) {
                  setState(() {
                    markers.add(
                      Marker(
                        markerId: MarkerId("pickedLocation"),
                        position: value,
                        icon: customIconPickedLocation,
                        // الأيقونة المخصصة للموقع المحدد
                        infoWindow: InfoWindow(
                          title: 'PIKED LOCATION',
                          snippet: 'الموقع المحدد',
                        ),
                      ),
                    );
                    _pickedLocation = value;
                    selectWarehouse = null;
                  });
                  polylineCoordinates.clear();
                },
                polylines: Set<Polyline>.of(
                  <Polyline>[
                    Polyline(
                      polylineId: PolylineId('route'),
                      color: Color.fromRGBO(38, 50, 56, 1),
                      points: polylineCoordinates,
                      width: 5,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 5),
            DraggableScrollableSheet(
              initialChildSize: 0.25, // Initial size when sheet is closed
              minChildSize: 0.25, // Minimum size when sheet is closed
              maxChildSize: 0.25, // Maximum size when sheet is fully expanded
              builder: (context, controller) {
                return Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 40,
                          offset: Offset(0, 0),
                          color: Colors.black26)
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  child: SingleChildScrollView(
                    controller: controller,
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(
                            '${'distance'.tr}: ${routeInfo.distance.toStringAsFixed(2)} كم',
                            textAlign: TextAlign.right,
                          ),
                          // subtitle: Text(
                          //     'الزمن المتوقع: ${routeInfo.estimatedHours} ساعة و ${routeInfo.estimatedMinutes} دقيقة'  , textAlign: TextAlign.right),
                        ),
                        ListTile(
                          title: _pickedLocation != LatLng(0.0, 0.0)
                              ? Text(
                                  'You have selected the inventory location'.tr,
                                  style: TextStyle(fontSize: 14),
                                  textAlign: TextAlign.center,
                                )
                              : Text(
                                  'Locate inventory'.tr,
                                  style: TextStyle(fontSize: 14),
                                  textAlign: TextAlign.center,
                                ),
                          subtitle: Text('', textAlign: TextAlign.right),
                          leading: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      _pickedLocation == LatLng(0.0, 0.0)
                                          ? Color.fromRGBO(38, 50, 56, 0.2)
                                          : AppColor.buttonColor)),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text(
                                        'Locate inventory on the map'.tr,
                                        textAlign: TextAlign.right,
                                      ),
                                      content: Container(
                                        height: 220,
                                        child: Column(
                                          children: [
                                            Image.asset(
                                              'image/map/inventory.png',
                                              width: 90,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                'Click on any location on the map to choose the inventory location'
                                                    .tr,
                                                textAlign: TextAlign.right,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(
                                                context); // إغلاق الرسالة
                                          },
                                          child: Text('cancel'.tr),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            if (_pickedLocation !=
                                                LatLng(0.0, 0.0)) {
                                              setState(() {
                                                _pickedLocation =
                                                    LatLng(0.0, 0.0);
                                                markers.remove(
                                                    MarkerId('pickedLocation'));
                                                polylineCoordinates.clear();
                                              });
                                              print(_pickedLocation);
                                            } else {
                                              _pickedLocation = _pickedLocation;
                                            }
                                            Navigator.pop(context);
                                          },
                                          child: _pickedLocation !=
                                                  LatLng(0.0, 0.0)
                                              ? Text('change Inventory location'
                                                  .tr)
                                              : Text('Locate inventory'.tr),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: _pickedLocation != LatLng(0.0, 0.0)
                                  ? Text('change Inventory location'.tr)
                                  : Text('Locate inventory'.tr),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width - 0.4,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 90),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            10.0), // Set your desired border radius
                                      ),
                                    ),
                                    backgroundColor: MaterialStateProperty.all(
                                        selectWarehouse != null &&
                                                _pickedLocation !=
                                                    LatLng(0.0, 0.0)
                                            ? AppColor.buttonColor
                                            : Color.fromRGBO(38, 50, 56, 0.2))),
                                onPressed: () {
                                  // هنا يمكنك وضع الكود الذي تريد تنفيذه بعد الضغط على الزر
                                  // قد ترغب في فتح شاشة جديدة أو إجراء أي عملية إضافية.

                                  if (selectWarehouse != null) {
                                    _pickedLocation == LatLng(0.0, 0.0)
                                        ? showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: Text(
                                                    'Please select a inventory location'
                                                        .tr),
                                                content: Text(
                                                    'Locate your inventory on the map now'
                                                        .tr),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(
                                                          context); // إغلاق الرسالة
                                                    },
                                                    child: Text('cancel'.tr),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text('Ok'.tr),
                                                  ),
                                                ],
                                              );
                                            },
                                          )
                                        : showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: Text(
                                                    'Confirm the operation'.tr),
                                                content: Text(
                                                    '${'Do you want to store in the warehouse'.tr} :  ${selectWarehouse!.nameWarehouse} ${'?'.tr}'),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(
                                                          context); // إغلاق الرسالة
                                                    },
                                                    child: Text('cancel'.tr),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                      Get.off(
                                                        () => WarehouseDetails(
                                                          totalAmount:
                                                              selectWarehouse!
                                                                      .pricePerMeter *
                                                                  widget.space *
                                                                  int.parse(
                                                                      widget
                                                                          .days),
                                                          address:
                                                              selectWarehouse!
                                                                  .address,
                                                          capacity:
                                                              widget.space,
                                                          phone:
                                                              selectWarehouse!
                                                                  .phone,
                                                          warehouseCap:
                                                              selectWarehouse!
                                                                  .capacity,
                                                          id: selectWarehouse!
                                                              .id,
                                                          warehouseName:
                                                              selectWarehouse!
                                                                  .nameWarehouse,
                                                          price: selectWarehouse!
                                                              .pricePerMeter,
                                                          distance: routeInfo
                                                              .distance
                                                              .toStringAsFixed(
                                                                  2),
                                                          warehouseLocation:
                                                              selectWarehouse!
                                                                  .position,
                                                          inventoryLocation:
                                                              _pickedLocation,
                                                          dry: widget.dry,
                                                          cold: widget.cold,
                                                          freezing:
                                                              widget.freezing,
                                                          from: widget.from,
                                                          to: widget.to,
                                                        ),
                                                      );
                                                    },
                                                    child: Text('Ok'.tr),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                  } else {
                                    _pickedLocation == LatLng(0.0, 0.0)
                                        ? ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                            SnackBar(
                                              content:
                                                  Text('Locate inventory'.tr),
                                            ),
                                          )
                                        : ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  'Select the warehouse to continue'
                                                      .tr),
                                            ),
                                          );
                                  }
                                },
                                child: Text('continue'.tr),
                              ),
                            ),

                            // Padding(
                            //   padding: const EdgeInsets.all(8.0),
                            //   child: ElevatedButton(
                            //       onPressed: () {
                            //         getLocation();
                            //       },
                            //       child: Text('حدد موقعك')),
                            // )
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
            Positioned(
              top: 20,
              child: SearchMapPlaceWidget(
                iconColor: Colors.black,
                bgColor: Colors.white,
                textColor: Colors.black,
                hasClearButton: false,
                apiKey: 'AIzaSyBGZuAzlhiW9_ZzL7n3A6wtHnye5uNvvYM',
                placeType: PlaceType.address,
                placeholder: 'Search Location'.tr,
                onSelected: (Place place) async {
                  Geolocation? geolocation = await place.geolocation;
                  mapController!.animateCamera(
                    CameraUpdate.newLatLng(geolocation!.coordinates),
                  );
                  mapController!.animateCamera(
                    CameraUpdate.newLatLngBounds(
                      geolocation.bounds,
                      0,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _drawRoute() async {
    if (selectWarehouse != null) {
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        'AIzaSyBGZuAzlhiW9_ZzL7n3A6wtHnye5uNvvYM',
        PointLatLng(_pickedLocation.latitude, _pickedLocation.longitude),
        PointLatLng(selectWarehouse!.position.latitude,
            selectWarehouse!.position.longitude),
        travelMode: TravelMode.driving,
      );

      if (result.status == 'OK') {
        print('========================');
        polylineCoordinates.clear();
        for (PointLatLng point in result.points) {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        }

        double distance = 0;
        for (int i = 0; i < result.points.length - 1; i++) {
          distance += _calculateDistance(
            result.points[i].latitude,
            result.points[i].longitude,
            result.points[i + 1].latitude,
            result.points[i + 1].longitude,
          );
        }

        double estimatedTimeInHours =
            distance / 60.0; // افتراض معدل السرعة 60 كم/ساعة
        int estimatedHours = estimatedTimeInHours.toInt();
        int estimatedMinutes =
            ((estimatedTimeInHours - estimatedHours) * 60).toInt();

        setState(() {
          routeInfo = RouteInfo(distance, estimatedHours, estimatedMinutes);
        });
      } else {
        print('Directions API error - Status: ${result.status}');
        print('Error Message: ${result.errorMessage}');
        print('***************************');
      }
    }
  }

  double _calculateDistance(lat1, lon1, lat2, lon2) {
    const double pi = 3.1415926535897932;
    const double radius = 6371; // Earth radius in kilometers

    double dLat = (lat2 - lat1) * (pi / 180);
    double dLon = (lon2 - lon1) * (pi / 180);
    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(lat1 * (pi / 180)) *
            cos(lat2 * (pi / 180)) *
            sin(dLon / 2) *
            sin(dLon / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    double distance = radius * c;

    return distance;
  }
}
