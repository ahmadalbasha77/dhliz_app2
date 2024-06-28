import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:dhliz_app/config/app_color.dart';
import 'package:dhliz_app/config/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  double pricePerMeter;

  // final int numberOfMeter;
  final String phone;
  final String address;
  List categories;
  List transportationService;
  List temperatures;
  List<Map<String, dynamic>> dryTemperatures;
  List<Map<String, dynamic>> coldTemperatures;
  List<Map<String, dynamic>> freezingTemperatures;

  MarkerInfo({
    required this.id,
    required this.position,
    required this.nameWarehouse,
    required this.capacity,
    required this.pricePerMeter,
    // required this.numberOfMeter,
    required this.phone,
    required this.address,
    required this.categories,
    required this.transportationService,
    required this.temperatures,
    required this.dryTemperatures,
    required this.coldTemperatures,
    required this.freezingTemperatures,
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
  int temperatureType;
  String from;
  String to;
  String days;
  String inventoryDescription;

  MapScreen(
      {Key? key,
      required this.space,
      required this.temperatureType,
      required this.from,
      required this.to,
      required this.days,
      required this.inventoryDescription})
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
  bool isVisibleCategory = false;
  bool isVisibleTransportation = false;
  int? selectedRadio = 0;
  List checkListItems = [
    {
      "id": 1,
      "value": false,
      "title": "Dry".tr,
    },
    {
      "id": 2,
      "value": false,
      "title": "Cold".tr,
    },
    {
      "id": 3,
      "value": false,
      "title": "Freezing".tr,
    }
  ];

  int? selectedDryIndex;
  int? selectedColdIndex;
  int? selectedFreezingIndex;
  int? selectedServiceIndex;
  bool selectedDry = false;
  bool selectedCold = false;
  bool selectedFreezing = false;
  bool selectedService = false;
  double totalPrice = 0.0;
  double costService = 0.0;
  double cost = 0.0;
  String temp = '';
  int tempId = 0;

  @override
  void initState() {
    print('*****************************');
    print(widget.temperatureType);
    print('*****************************');
    super.initState();
    _determinePosition();
    _loadCustomIcons();
    fetchData();

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
            Platform.isIOS ? 'image/ios/user.png' : 'image/map/user.png',
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

  bool isLoading = false;

  Future<void> fetchData({String? address = 'Address'}) async {
    setState(() {
      isLoading = true;
    });
    print(sharedPrefsClient.accessToken);
    final Map<String, String> headers = {
      'Authorization': 'Bearer ${sharedPrefsClient.accessToken}'
    };
    final Uri uri = Uri.parse('${ApiUrl.API_BASE_URL2}/api/Warehouse/Find');

    // Initialize queryParameters with the 'Capacity' parameter
    final Map<String, dynamic> queryParameters =
        widget.space != null ? {'Capacity': widget.space.toString()} : {};

    // Add 'include' parameter to queryParameters if address is provided
    queryParameters['include'] = ['TransportationFees', address];
    queryParameters['TemperatureType'] = widget.temperatureType.toString();
    queryParameters['PageIndex'] = '0';
    queryParameters['PageSize'] = '60';

    final Uri filteredUri = uri.replace(queryParameters: queryParameters);
    print('******** URL *******************');
    print(uri);
    print(queryParameters);
    print('*********************************');
    try {
      final response = await http.get(filteredUri, headers: headers);

      if (response.statusCode == 200) {
        print(filteredUri);
        print(queryParameters);
        print('Request successful');
        Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['isSuccess']) {
          data = responseData['response'];
          if (data.isNotEmpty) {
            Map<String, dynamic> firstItem = data[0];
          } else {
            print('Response array is empty');
          }
          markers.clear();

          // Extract and store coordinates from the 'address' part
          for (final item in data) {
            if (item['address'] != null &&
                item['address'] is Map<String, dynamic>) {
              Map<String, dynamic> address = item['address']!;
              print('**********************************');
              print(address);
              print('***********************************');

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
                          // numberOfMeter: 5,
                          phone: item['phone'] ?? '',

                          categories: item['categories'] ?? [],
                          temperatures: item['temperatures'] ?? [],
                          transportationService:
                              item['transportationFees'] ?? [],
                          dryTemperatures: (item['temperatures']
                                  as List<dynamic>)
                              .where((temperature) =>
                                  temperature is Map<String, dynamic> &&
                                  temperature['temperatureType'] == 1 &&
                                  temperature.containsKey('supTemperature') &&
                                  temperature['supTemperature']
                                      is List<dynamic>)
                              .map((temperature) =>
                                  (temperature['supTemperature'] as List)
                                      .where((supTemp) =>
                                          supTemp is Map<String, dynamic>)
                                      .map((supTemp) =>
                                          supTemp as Map<String, dynamic>)
                                      .toList())
                              .expand((x) =>
                                  x) // Flatten the List<List<Map>> to List<Map>
                              .toList(),
                          coldTemperatures: (item['temperatures']
                                  as List<dynamic>)
                              .where((temperature) =>
                                  temperature is Map<String, dynamic> &&
                                  temperature['temperatureType'] == 2 &&
                                  temperature.containsKey('supTemperature') &&
                                  temperature['supTemperature']
                                      is List<dynamic>)
                              .map((temperature) =>
                                  (temperature['supTemperature'] as List)
                                      .where((supTemp) =>
                                          supTemp is Map<String, dynamic>)
                                      .map((supTemp) =>
                                          supTemp as Map<String, dynamic>)
                                      .toList())
                              .expand((x) =>
                                  x) // Flatten the List<List<Map>> to List<Map>
                              .toList(),
                          freezingTemperatures: (item['temperatures']
                                  as List<dynamic>)
                              .where((temperature) =>
                                  temperature is Map<String, dynamic> &&
                                  temperature['temperatureType'] == 3 &&
                                  temperature.containsKey('supTemperature') &&
                                  temperature['supTemperature']
                                      is List<dynamic>)
                              .map((temperature) =>
                                  (temperature['supTemperature'] as List)
                                      .where((supTemp) =>
                                          supTemp is Map<String, dynamic>)
                                      .map((supTemp) =>
                                          supTemp as Map<String, dynamic>)
                                      .toList())
                              .expand((x) =>
                                  x) // Flatten the List<List<Map>> to List<Map>
                              .toList(),
                        ));
                      },
                      title: item['name'],
                      snippet: 'اضغط هنا لعرض تفاصيل المخزن',
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
                            // numberOfMeter: 5,
                            phone: item['phone'] ?? '',
                            categories: item['categories'] ?? [],
                            transportationService:
                                item['transportationFees'] ?? [],
                            temperatures: item['temperatures'] ?? [],
                            dryTemperatures: (item['temperatures']
                                    as List<dynamic>)
                                .where((temperature) =>
                                    temperature is Map<String, dynamic> &&
                                    temperature['temperatureType'] == 1 &&
                                    temperature.containsKey('supTemperature') &&
                                    temperature['supTemperature']
                                        is List<dynamic>)
                                .map((temperature) => (temperature['supTemperature'] as List)
                                    .where((supTemp) =>
                                        supTemp is Map<String, dynamic>)
                                    .map((supTemp) =>
                                        supTemp as Map<String, dynamic>)
                                    .toList())
                                .expand((x) =>
                                    x) // Flatten the List<List<Map>> to List<Map>
                                .toList(),
                            coldTemperatures: (item['temperatures']
                                    as List<dynamic>)
                                .where((temperature) =>
                                    temperature is Map<String, dynamic> &&
                                    temperature['temperatureType'] == 2 &&
                                    temperature.containsKey('supTemperature') &&
                                    temperature['supTemperature'] is List<dynamic>)
                                .map((temperature) => (temperature['supTemperature'] as List).where((supTemp) => supTemp is Map<String, dynamic>).map((supTemp) => supTemp as Map<String, dynamic>).toList())
                                .expand((x) => x) // Flatten the List<List<Map>> to List<Map>
                                .toList(),
                            freezingTemperatures: (item['temperatures'] as List<dynamic>)
                                .where((temperature) => temperature is Map<String, dynamic> && temperature['temperatureType'] == 3 && temperature.containsKey('supTemperature') && temperature['supTemperature'] is List<dynamic>)
                                .map((temperature) => (temperature['supTemperature'] as List).where((supTemp) => supTemp is Map<String, dynamic>).map((supTemp) => supTemp as Map<String, dynamic>).toList())
                                .expand((x) => x) // Flatten the List<List<Map>> to List<Map>
                                .toList());
                        _drawRoute();
                      });
                    },
                  ),
                );
                setState(() {
                  isLoading = false;
                });
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
    if (Platform.isIOS) {
      customIcon1 = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'image/ios/warehoues.png',
      );
      customIconPickedLocation = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'image/ios/inventory.png',
      );
    }
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
    selectedDryIndex = -1;
    selectedColdIndex = -1;
    selectedFreezingIndex = -1;
    selectedServiceIndex = -1;
    selectedDry = false;
    selectedCold = false;
    selectedFreezing = false;
    totalPrice = 0;
    selectedRadio = 0;
    bool isVisibleCategory = false;
    bool isVisibleTransportation = false;

    List<String> list = <String>['One', 'Two', 'Three', 'Four'];

    String dropdownValue = list.first;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.zero,
          child: StatefulBuilder(
            builder: (context, setState) => Scaffold(
              appBar: AppBar(
                title: Text(info.nameWarehouse, style: TextStyle(fontSize: 22)),
                automaticallyImplyLeading: false,
                actions: [
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      selectedDryIndex = -1;
                      selectedColdIndex = -1;
                      selectedFreezingIndex = -1;
                      selectedServiceIndex = -1;
                      selectedDry = false;
                      selectedCold = false;
                      selectedFreezing = false;
                      totalPrice = 0;
                      costService = 0;
                      selectedRadio = 0;
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              bottomNavigationBar: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: selectedDry == false &&
                          selectedCold == false &&
                          selectedFreezing == false
                      ? Colors.grey[400]
                      : AppColor.buttonColor,
                ),
                child: ListTile(
                    title: Text('Confirm'.tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: selectedDry == false ||
                                    selectedCold == false ||
                                    selectedFreezing == false
                                ? Colors.white
                                : Colors.white)),
                    onTap: () {
                      print(info.pricePerMeter);
                      print(selectedDry);
                      print(selectedCold);
                      print(selectedFreezing);
                      if (selectedDry == false &&
                          selectedCold == false &&
                          selectedFreezing == false) {
                        Get.snackbar('warning', '',
                            messageText:
                                Text('Please enter the required temperature'));
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Confirm the operation'.tr),
                              content: Text(
                                  '${'Do you want to store in the warehouse'.tr} :  ${selectWarehouse!.nameWarehouse} ${'?'.tr}'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context); // إغلاق الرسالة
                                  },
                                  child: Text('cancel'.tr),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Get.off(
                                      () => WarehouseDetails(
                                        cost: cost,
                                        inventoryDescription:
                                            widget.inventoryDescription,
                                        totalAmount: totalPrice,
                                        capacity: widget.space,
                                        temp: temp,
                                        inventoryLocation: _pickedLocation,
                                        from: widget.from,
                                        to: widget.to,
                                        info: selectWarehouse!,
                                        tempId: tempId,
                                      ),
                                    );
                                  },
                                  child: Text('Ok'.tr),
                                ),
                              ],
                            );
                          },
                        );
                      }

                      print('aaaaaaaaaaaa');
                    }),
              ),
              body: SingleChildScrollView(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ListTile(
                                title:
                                    Text('${'capacity'.tr} : ${info.capacity}'),
                                leading: Icon(
                                  Icons.space_dashboard,
                                  color: AppColor.buttonColor,
                                ),
                                trailing: Text('M²'),
                              ),
                              ListTile(
                                title: Text(
                                    '${'space required'.tr} : ${widget.space}'),
                                leading: Icon(
                                  Icons.splitscreen,
                                  color: AppColor.buttonColor,
                                ),
                                trailing: Text('M²'),
                              ),
                              ListTile(
                                title: Text(
                                    '${'Booking days'.tr} : ${widget.days}'),
                                leading: Icon(
                                  Icons.date_range_rounded,
                                  color: AppColor.buttonColor,
                                ),
                                trailing: Text('days'),
                              ),
                              ListTile(
                                title: Text("${'phone'.tr} : ${info.phone}"),
                                leading: Icon(
                                  Icons.phone,
                                  color: AppColor.buttonColor,
                                ),
                                trailing: Text('+966'),
                              ),
                              // ListTile(
                              //   title: Text(
                              //       "${'price Per Meter'.tr} : ${info.pricePerMeter}"),
                              //   leading: Icon(
                              //     Icons.straighten,
                              //     color: AppColor.buttonColor,
                              //   ),
                              //   trailing: Text('SAR'),
                              // ),
                              // ListTile(
                              //   title: Text(
                              //       "${'Transportation Fees'.tr} : ${info.transportationFees}"),
                              //   leading: Icon(
                              //     Icons.airport_shuttle,
                              //     color: AppColor.buttonColor,
                              //   ),
                              //   trailing: Text('SAR'),
                              // ),
                              ListTile(
                                title: Text(
                                  "${'Total price'.tr} : ${totalPrice} ",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                leading: Icon(
                                  Icons.account_balance_wallet,
                                  color: AppColor.buttonColor,
                                ),
                                trailing: Text(
                                  'SAR',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('select temperatures ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18)),
                              ),
                              Container(
                                height: 50,
                                child: ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: checkListItems.length,
                                  itemBuilder: (context, index) => Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 25),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Radio<int>(
                                          value: checkListItems[index]['id'],
                                          groupValue: selectedRadio,
                                          onChanged: (int? value) {
                                            setState(() {
                                              selectedRadio = value;
                                              print(value.toString());
                                            });
                                          },
                                        ),
                                        Text(
                                          checkListItems[index]['title'],
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              selectedRadio == 1
                                  ? info.dryTemperatures.isEmpty
                                      ? Container(
                                          margin: EdgeInsets.symmetric(
                                              vertical: 20),
                                          child: Center(
                                            child: Text('No dry Temperatures'),
                                          ),
                                        )
                                      : ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemCount:
                                              info.dryTemperatures.length,
                                          itemBuilder: (context, index) {
                                            return Container(
                                              margin: EdgeInsets.symmetric(
                                                  vertical: 5, horizontal: 10),
                                              color: selectedDry == true
                                                  ? selectedDryIndex == index
                                                      ? Colors.blue[100]
                                                      : Colors.grey[100]
                                                  : Colors.grey[100],
                                              child: ListTile(
                                                onTap: () {
                                                  setState(() {
                                                    cost = info.dryTemperatures[
                                                        index]['cost'];
                                                    tempId =
                                                        info.dryTemperatures[
                                                            index]['id'];

                                                    temp =
                                                        '${info.dryTemperatures[index]['fromTemperature']} - ${info.dryTemperatures[index]['toTemperature']}';
                                                    selectedFreezingIndex = -1;
                                                    selectedColdIndex = -1;
                                                    totalPrice = 0.0;
                                                    selectedDry = true;
                                                    selectedDryIndex = index;
                                                    totalPrice =
                                                        info.dryTemperatures[
                                                                        index]
                                                                    ['cost'] *
                                                                widget.space *
                                                                int.parse(widget
                                                                    .days) +
                                                            costService;
                                                  });

                                                  print(index);
                                                },
                                                title: Text(
                                                    '${info.dryTemperatures[index]['fromTemperature']} - ${info.dryTemperatures[index]['toTemperature']} °C',
                                                    style: TextStyle(
                                                        fontSize: 16)),
                                                leading: Icon(
                                                    Icons.device_thermostat,
                                                    color:
                                                        AppColor.buttonColor),
                                                trailing: Text(
                                                    '${info.dryTemperatures[index]['cost']}  SAR/M²',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ),
                                            );
                                          },
                                        )
                                  : SizedBox.shrink(),
                              selectedRadio == 2
                                  ? info.coldTemperatures.isEmpty
                                      ? Container(
                                          margin: EdgeInsets.symmetric(
                                              vertical: 20),
                                          child: Center(
                                            child: Text('No cold Temperatures'),
                                          ),
                                        )
                                      : ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemCount:
                                              info.coldTemperatures.length,
                                          itemBuilder: (context, index) {
                                            return Container(
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 5,
                                                    horizontal: 10),
                                                color: Colors.grey[100],
                                                child: Container(
                                                  color: selectedCold == true
                                                      ? selectedColdIndex ==
                                                              index
                                                          ? Colors.blue[100]
                                                          : Colors.grey[100]
                                                      : Colors.grey[100],
                                                  // Highlight if selected
                                                  child: ListTile(
                                                    onTap: () {
                                                      setState(() {
                                                        cost =
                                                            info.coldTemperatures[
                                                                index]['cost'];
                                                        tempId =
                                                            info.coldTemperatures[
                                                                index]['id'];
                                                        print(
                                                            '*****************');
                                                        print(
                                                            info.pricePerMeter);
                                                        print(tempId);
                                                        print(
                                                            '*****************');
                                                        temp =
                                                            '${info.coldTemperatures[index]['fromTemperature']} - ${info.coldTemperatures[index]['toTemperature']}';
                                                        selectedFreezingIndex =
                                                            -1;
                                                        selectedDryIndex = -1;
                                                        totalPrice = 0.0;
                                                        selectedCold = true;
                                                        selectedColdIndex =
                                                            index;
                                                        totalPrice =
                                                            info.coldTemperatures[
                                                                            index]
                                                                        [
                                                                        'cost'] *
                                                                    widget
                                                                        .space *
                                                                    int.parse(widget
                                                                        .days) +
                                                                costService;
                                                        print(index);
                                                      });
                                                    },
                                                    title: Text(
                                                      '${info.coldTemperatures[index]['fromTemperature']} - ${info.coldTemperatures[index]['toTemperature']} °C',
                                                      style: TextStyle(
                                                          fontSize: 16),
                                                    ),
                                                    leading: Icon(
                                                        Icons.device_thermostat,
                                                        color: AppColor
                                                            .buttonColor),
                                                    trailing: Text(
                                                      '${info.coldTemperatures[index]['cost']}  SAR/M²',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ));
                                          },
                                        )
                                  : SizedBox.shrink(),
                              selectedRadio == 3
                                  ? info.freezingTemperatures.isEmpty
                                      ? Container(
                                          margin: EdgeInsets.symmetric(
                                              vertical: 20),
                                          child: Center(
                                            child: Text(
                                                'No Freezing Temperatures'),
                                          ),
                                        )
                                      : ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemCount:
                                              info.freezingTemperatures.length,
                                          itemBuilder: (context, index) {
                                            return Container(
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 5,
                                                    horizontal: 10),
                                                color: Colors.grey[100],
                                                child: Container(
                                                  color: selectedFreezing ==
                                                          true
                                                      ? selectedFreezingIndex ==
                                                              index
                                                          ? Colors.blue[100]
                                                          : Colors.grey[100]
                                                      : Colors.grey[100],
                                                  // Highlight if selected
                                                  child: ListTile(
                                                    onTap: () {
                                                      setState(() {
                                                        cost =
                                                            info.freezingTemperatures[
                                                                index]['cost'];
                                                        tempId =
                                                            info.freezingTemperatures[
                                                                index]['id'];
                                                        print(
                                                            '*****************');
                                                        print(
                                                            info.pricePerMeter);
                                                        print(tempId);
                                                        print(
                                                            '*****************');
                                                        temp =
                                                            '${info.freezingTemperatures[index]['fromTemperature']} - ${info.freezingTemperatures[index]['toTemperature']}';
                                                        selectedColdIndex = -1;
                                                        selectedDryIndex = -1;
                                                        totalPrice = 0.0;
                                                        selectedFreezing = true;
                                                        selectedFreezingIndex =
                                                            index;
                                                        totalPrice =
                                                            info.freezingTemperatures[
                                                                            index]
                                                                        [
                                                                        'cost'] *
                                                                    widget
                                                                        .space *
                                                                    int.parse(widget
                                                                        .days) +
                                                                costService;
                                                        print(index);
                                                      });
                                                    },
                                                    title: Text(
                                                      '${info.freezingTemperatures[index]['fromTemperature']} - ${info.freezingTemperatures[index]['toTemperature']} °C',
                                                      style: TextStyle(
                                                          fontSize: 16),
                                                    ),
                                                    leading: Icon(
                                                        Icons.device_thermostat,
                                                        color: AppColor
                                                            .buttonColor),
                                                    trailing: Text(
                                                      '${info.freezingTemperatures[index]['cost']}  SAR',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ));
                                          },
                                        )
                                  : SizedBox.shrink(),
                              SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text('show transportation services ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16)),
                                        // Text('(optional)  ',
                                        //     style: TextStyle(
                                        //         fontSize: 14,
                                        //         color: Colors.black54)),
                                      ],
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          setState(() {
                                            isVisibleTransportation =
                                                !isVisibleTransportation;
                                          });
                                        },
                                        icon: Icon(isVisibleTransportation
                                            ? Icons.arrow_drop_up
                                            : Icons.arrow_drop_down))
                                  ],
                                ),
                              ),

                              Visibility(
                                visible: isVisibleTransportation,
                                child: Container(
                                  child: info.transportationService.isEmpty
                                      ? Container(
                                          margin: EdgeInsets.symmetric(
                                              vertical: 15),
                                          child: Center(
                                              child: Text(
                                                  'No transportation services')))
                                      : ListView.builder(
                                          shrinkWrap: true,
                                          physics: ScrollPhysics(
                                              parent:
                                                  NeverScrollableScrollPhysics()),
                                          itemCount:
                                              info.transportationService.length,
                                          itemBuilder: (context, index) {
                                            var transportationService = info
                                                .transportationService[index];
                                            return Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 5, vertical: 5),
                                              color:
                                                  selectedServiceIndex == index
                                                      ? Colors.blue[100]
                                                      : Colors.grey[100],
                                              child: ListTile(
                                                // onTap: () {
                                                //   setState(() {
                                                //     if (selectedService ==
                                                //         true) {
                                                //       totalPrice = totalPrice -
                                                //           costService;
                                                //     }
                                                //     selectedService = true;
                                                //     selectedServiceIndex =
                                                //         index;
                                                //     costService = 0.0;
                                                //     costService =
                                                //         transportationService[
                                                //             'price'];
                                                //
                                                //     totalPrice = totalPrice +
                                                //         costService;
                                                //   });
                                                // },
                                                title: Text(
                                                    transportationService[
                                                        'name'],
                                                    style: TextStyle(
                                                        fontSize: 16)),
                                                subtitle: Text(
                                                  transportationService[
                                                      'description'],
                                                ),
                                                leading: Icon(
                                                    Icons.airport_shuttle,
                                                    color:
                                                        AppColor.buttonColor),
                                                trailing: Text(
                                                  '${transportationService['price'].toString()} SAR',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('View All Supported Categories ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16)),
                                    IconButton(
                                        onPressed: () {
                                          setState(() {
                                            isVisibleCategory =
                                                !isVisibleCategory;
                                          });
                                        },
                                        icon: Icon(isVisibleCategory
                                            ? Icons.arrow_drop_up
                                            : Icons.arrow_drop_down))
                                  ],
                                ),
                              ),

                              Visibility(
                                visible: isVisibleCategory,
                                child: Container(
                                  child: info.categories.isEmpty
                                      ? Container(
                                          margin: EdgeInsets.symmetric(
                                              vertical: 15),
                                          child: Center(
                                              child: Text('No Category')))
                                      : ListView.builder(
                                          shrinkWrap: true,
                                          physics: ScrollPhysics(
                                              parent:
                                                  NeverScrollableScrollPhysics()),
                                          itemCount: info.categories.length,
                                          itemBuilder: (context, index) {
                                            var category =
                                                info.categories[index];
                                            return ListTile(
                                              title: Text(category['name'],
                                                  style:
                                                      TextStyle(fontSize: 16)),
                                              leading: Icon(
                                                  Icons.category_outlined,
                                                  color: AppColor.buttonColor),
                                            );
                                          },
                                        ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
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
          print(isLoading);
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
            isLoading == true
                ? Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 0),
                      child: CircularProgressIndicator(),
                    ),
                  )
                : SizedBox.shrink(),
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
                        routeInfo.distance == 0
                            ? ListTile(
                                title: Text(
                                  '',
                                  textAlign: TextAlign.right,
                                ),
                                // subtitle: Text(
                                //     'الزمن المتوقع: ${routeInfo.estimatedHours} ساعة و ${routeInfo.estimatedMinutes} دقيقة'  , textAlign: TextAlign.right),
                              )
                            : ListTile(
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
                        selectWarehouse != null
                            ? SizedBox()
                            : Text('please select warehouse'),
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
                                        selectWarehouse != null
                                            // &&
                                            //     _pickedLocation !=
                                            //         LatLng(0.0, 0.0)
                                            ? AppColor.buttonColor
                                            : Color.fromRGBO(38, 50, 56, 0.2))),
                                onPressed: () {
                                  selectWarehouse == null
                                      ? Get.snackbar('warning', '',
                                          messageText:
                                              Text('please select warehouse'))
                                      : _showStoreDetailsDialog(
                                          selectWarehouse!);
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
                apiKey: 'AIzaSyDeH6nQy7GwB5hCPLYvF-Pbj5WH647Z-P4',
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
        'AIzaSyDeH6nQy7GwB5hCPLYvF-Pbj5WH647Z-P4',
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
