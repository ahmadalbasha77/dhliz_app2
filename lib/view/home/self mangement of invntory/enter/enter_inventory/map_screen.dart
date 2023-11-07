import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:search_map_place_updated/search_map_place_updated.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'dart:math';

import '../../../../../config/app_color.dart';
import 'warehouse_details.dart';

class MarkerInfo {
  final String id;

  final LatLng position;
  final String title;
  final String snippet;

  final double pricePerMeter;

  final int numberOfMeter;

  final int numberOfWp;

  MarkerInfo({
    required this.id,
    required this.position,
    required this.title,
    required this.snippet,
    required this.pricePerMeter,
    required this.numberOfMeter,
    required this.numberOfWp,
  });
}

class RouteInfo {
  final double distance; // بالكيلومترات
  final int estimatedHours; // بالساعات
  final int estimatedMinutes; // بالدقائق

  RouteInfo(this.distance, this.estimatedHours, this.estimatedMinutes);
}

class MapScreen extends StatefulWidget {
  String temp;

  String fromDate;

  String toDate;
  String numberOfDays;

  String stockType;

  MapScreen(
      {required this.temp,
      required this.fromDate,
      required this.toDate,
      required this.numberOfDays,
      required this.stockType,
      super.key});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  LatLng _center = LatLng(31.959414984821176, 35.85732029979889);
  late BitmapDescriptor customIcon1 = BitmapDescriptor.defaultMarker;
  late BitmapDescriptor customIcon2 = BitmapDescriptor.defaultMarker;
  late BitmapDescriptor customIconPickedLocation =
      BitmapDescriptor.defaultMarker;

  LatLng _pickedLocation = LatLng(0, 0);
  MarkerInfo? selectWarehouse;
  Set<Marker> markers = {};
  List<MarkerInfo> markerInfoList = [
    MarkerInfo(
      id: 'w1',
      position: LatLng(31.003440015132856, 34.85960476038715),
      title: 'مخزن 1',
      snippet: 'وصف المخزن 1',
      pricePerMeter: 10.5,
      numberOfMeter: 1,
      numberOfWp: 3,
    ),
    MarkerInfo(
      id: 'w2',
      position: LatLng(31.96636860276579, 35.87890932894158),
      title: 'مخزن 2',
      snippet: ' وصف مخزن 2',
      pricePerMeter: 12.90,
      numberOfMeter: 1,
      numberOfWp: 9,
    ),
  ];

  late PolylinePoints polylinePoints;
  List<LatLng> polylineCoordinates = [];
  RouteInfo routeInfo = RouteInfo(0, 0, 0);

  @override
  void initState() {
    super.initState();
    _determinePosition();
    _loadCustomIcons();
    polylinePoints = PolylinePoints();
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

  late Position currentPosition;

  Future<void> getLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        currentPosition = position;
      });

      // عرض الموقع الحالي على الخريطة
      mapController.animateCamera(
        CameraUpdate.newLatLng(
          LatLng(position.latitude, position.longitude),
        ),
      );

      // قم بتحديث الماركر
      markers.clear();
      markers.add(
        Marker(
          icon: await BitmapDescriptor.fromAssetImage(
            ImageConfiguration(devicePixelRatio: 2.5),
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
                      child: Text('OK'),
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

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }

  void _showStoreDetailsDialog(MarkerInfo markerInfo) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(markerInfo.title),
          content: SizedBox(
            height: 70,
            child: Column(
              children: [
                Text("السعر لكل متر  : ${markerInfo.pricePerMeter}"),
                SizedBox(
                  height: 20,
                ),
                Text(
                    "${markerInfo.numberOfMeter} M² = ${markerInfo.numberOfWp} Woorden Pallets"),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll(Color.fromRGBO(38, 50, 56, 1))),
              child: Text('إغلاق'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Set<Marker> _createMarkers() {
    for (var markerInfo in markerInfoList) {
      markers.add(
        Marker(
          markerId: MarkerId(markerInfo.title),
          position: markerInfo.position,
          icon: customIcon1,
          infoWindow: InfoWindow(
            onTap: () {
              _showStoreDetailsDialog(markerInfo);
            },
            title: markerInfo.title,
            snippet: 'اضغط هنا لعرض نفاصيل المخزن',
          ),
          onTap: () {
            setState(() {
              selectWarehouse = markerInfo;

              _drawRoute();
            });
          },
        ),
      );
    }

    markers.add(
      Marker(
        markerId: MarkerId("pickedLocation"),
        position: _pickedLocation,
        icon: customIconPickedLocation, // الأيقونة المخصصة للموقع المحدد
        infoWindow: InfoWindow(
          title: 'PIKED LOCATION',
          snippet: 'الموقع المحدد',
        ),
      ),
    );

    return markers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(38, 50, 56, 1),
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
                markers: _createMarkers(),
                onTap: (value) {
                  setState(() {
                    _pickedLocation = value;
                    selectWarehouse = null;
                  });
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
                            'المسافة: ${routeInfo.distance.toStringAsFixed(2)} كم',
                            textAlign: TextAlign.right,
                          ),
                          // subtitle: Text(
                          //     'الزمن المتوقع: ${routeInfo.estimatedHours} ساعة و ${routeInfo.estimatedMinutes} دقيقة'  , textAlign: TextAlign.right),
                        ),
                        ListTile(
                          title: _pickedLocation != LatLng(0.0, 0.0)
                              ? Text('لقد قمت باختيار موقع المخزون')
                              : Text(' حدد موقع المخزون'),
                          subtitle: Text('', textAlign: TextAlign.right),
                          leading: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      _pickedLocation == LatLng(0.0, 0.0)
                                          ? Color.fromRGBO(38, 50, 56, 0.2)
                                          : Color.fromRGBO(38, 50, 56, 1))),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text(
                                        'تحديد موقع المخزون على الخريطة',
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
                                                'قم بالضغط على اي موقع على الخريطة للاختيار موقع المخزون',
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
                                          child: Text('إلغاء'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            if (_pickedLocation !=
                                                LatLng(0.0, 0.0)) {
                                              setState(() {
                                                _pickedLocation =
                                                    LatLng(0.0, 0.0);
                                                markers.clear();
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
                                              ? Text('تغير موقع المخزون')
                                              : Text('حدد موقع المخزون'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: _pickedLocation != LatLng(0.0, 0.0)
                                  ? Text('تغير موقع المخزون')
                                  : Text('حدد موقع المخزون'),
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
                                            ? Color.fromRGBO(38, 50, 56, 1)
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
                                                    'يرجى اختيار موقع المخزون'),
                                                content: Text(
                                                    'قم بتحديد موقع المخزون على الخريطة الان'),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(
                                                          context); // إغلاق الرسالة
                                                    },
                                                    child: Text('إلغاء'),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text('موافق'),
                                                  ),
                                                ],
                                              );
                                            },
                                          )
                                        : showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: Text('تأكيد العملية'),
                                                content: Text(
                                                    'هل تريد التخزين في المخزن :  ${selectWarehouse!.title}؟'),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(
                                                          context); // إغلاق الرسالة
                                                    },
                                                    child: Text('إلغاء'),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pushReplacement(
                                                              MaterialPageRoute(
                                                        builder: (context) => WarehouseDetails(
                                                            id: selectWarehouse!
                                                                .id,
                                                            warehouseName:
                                                                selectWarehouse!
                                                                    .title,
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
                                                                _pickedLocation),
                                                      ));
                                                    },
                                                    child: Text('موافق'),
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
                                              content: Text(
                                                  'قم بتحديد موقع المخزون'),
                                            ),
                                          )
                                        : ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  'قم بأختيار المخزن للاستمرار'),
                                            ),
                                          );
                                  }
                                },
                                child: Text('استمرار'),
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
                placeholder: 'Search Location',
                onSelected: (Place place) async {
                  Geolocation? geolocation = await place.geolocation;
                  mapController.animateCamera(
                    CameraUpdate.newLatLng(geolocation!.coordinates),
                  );
                  mapController.animateCamera(
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
