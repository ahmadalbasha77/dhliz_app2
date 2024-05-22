import 'dart:convert';

import 'package:dhliz_app/config/shared_prefs_client.dart';
import 'package:dhliz_app/models/home/stock_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../network/api_url.dart';

class AllStockController extends GetxController {
  static AllStockController get to => Get.isRegistered<AllStockController>()
      ? Get.find<AllStockController>()
      : Get.put(AllStockController());

  @override
  void onInit() {
    getAllStock();
    super.onInit();
  }

  List<Map<String, dynamic>> dataAllStock = [];

  Future<void> getAllStock() async {
    final response = await http.get(
        Uri.parse(
            '${ApiUrl.API_BASE_URL}/Stock/Find?CustomerName=${sharedPrefsClient.fullName}&PageIndex=0&PageSize=100'),
        headers: {'Authorization': 'Bearer ${sharedPrefsClient.accessToken}'});

    print(response.body);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final responseData = jsonResponse['result']['response'][0];

      if (responseData != null) {


            dataAllStock = List<Map<String, dynamic>>.from(responseData);
        update();
      } else {
        print('Invalid response structure');
      }
    } else {
      throw Exception('Failed to load data');
    }
  }
}
