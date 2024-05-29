import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dhliz_app/config/shared_prefs_client.dart';
import 'package:dhliz_app/models/auth/register_model.dart';
import 'package:dhliz_app/models/home/warehouses_model.dart';
import 'package:dhliz_app/models/main/profile_model.dart';
import 'package:dhliz_app/network/api_url.dart';
import 'package:http/http.dart' as http;
import '../config/utils.dart';
import '../models/auth/login_model.dart';
import '../models/home/add_stock_model.dart';
import '../models/home/stock_model.dart';
import '../models/home/subscriptions_model.dart';
import '../models/main/transaction_model.dart';

class RestApi {
  static Future<UserResponse?> login(var body) async {
    String url = '${ApiUrl.API_BASE_URL2}${ApiUrl.LOGIN}';
    Uri uri = Uri.parse(url);
    var headers = {
      'accept': 'text/plain',
      'Content-Type': 'application/json',
    };
    http.Response response = await http.post(uri, headers: headers, body: body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      log(response.body);
      UserResponse userResponse =
          UserResponse.fromJson(jsonDecode(response.body));
      return userResponse;
    } else if (response.statusCode == 400) {
      Utils.showSnackbar('Please try again', 'Email or password is incorrect');
      return null;
    } else {
      Utils.showSnackbar('Please try again', 'Check your internet connection');
      return null;
    }
  }

  static Future<RegisterModel?> register(var body) async {
    String url = '${ApiUrl.API_BASE_URL2}${ApiUrl.REGISTER}';
    Uri uri = Uri.parse(url);
    var headers = {'Content-Type': 'application/json; charset=UTF-8'};
    http.Response response = await http.post(uri, headers: headers, body: body);
    log(response.statusCode.toString());
    log(body);
    log(response.body);
    if (response.statusCode == 200) {
      log(response.body);
      RegisterModel registerModel =
          RegisterModel.fromJson(jsonDecode(response.body));
      return registerModel;
    } else if (response.statusCode == 400) {
      Utils.showSnackbar(
          'Please try again', 'The email already exists. Use another email');
      return null;
    } else {
      Utils.showSnackbar('Please try again', 'Check your internet connection');
      return null;
    }
  }

  static Future<TransactionModel?> getTransaction(
      {required int skip, required int take}) async {
    String url =
        '${ApiUrl.API_BASE_URL2}${ApiUrl.GetTransaction}?CustomerName=${sharedPrefsClient.fullName}&PageIndex=$skip&PageSize=$take';
    Uri uri = Uri.parse(url);

    print(url);
    var headers = {
      'accept': '*/*',
      'Authorization': 'Bearer ${sharedPrefsClient.accessToken}'
    };

    http.Response response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      TransactionModel transactionModel =
          TransactionModel.fromJson(jsonDecode(response.body));

      return transactionModel;
    } else {
      throw Exception('Failed to load transaction data');
    }
  }

  static Future<ProfileModel?> getProfile() async {
    String url =
        'https://api.dhlez.sa/api/Customer/GetById?id=${sharedPrefsClient.customerId}';
    Uri uri = Uri.parse(url);

    var headers = {
      'accept': '*/*',
      'Authorization': 'Bearer ${sharedPrefsClient.accessToken}'
    };

    http.Response response = await http.get(uri, headers: headers);
    print(response.body);
    if (response.statusCode == 200) {
      ProfileModel profileModel =
          ProfileModel.fromJson(jsonDecode(response.body));
      return profileModel;
    } else {
      throw Exception('Failed to load transaction data');
    }
  }

  static Future<SubscriptionsModel?> getSubscriptions() async {
    String url =
        '${ApiUrl.API_BASE_URL2}${ApiUrl.GetSubscriptions}?id=${sharedPrefsClient.customerId}';
    Uri uri = Uri.parse(url);
    print(sharedPrefsClient.accessToken);
    var headers = {
      'accept': '*/*',
      'Authorization': 'Bearer ${sharedPrefsClient.accessToken}'
    };

    http.Response response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      log(response.body);
      SubscriptionsModel subscriptionsModel =
          SubscriptionsModel.fromJson(jsonDecode(response.body));

      return subscriptionsModel;
    } else {
      throw Exception('Failed to load subscriptions data');
    }
  }

  static Future<StockModel?> getStock(
      {required String id, required int skip, required int take}) async {
    String url =
        '${ApiUrl.API_BASE_URL2}${ApiUrl.GetStock}?SubscriptionId=$id&PageIndex=$skip&PageSize=$take';
    Uri uri = Uri.parse(url);

    var headers = {
      'accept': '*/*',
      'Authorization': 'Bearer ${sharedPrefsClient.accessToken}'
    };

    http.Response response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      log(response.body);
      StockModel stockModel = StockModel.fromJson(jsonDecode(response.body));

      return stockModel;
    } else {
      throw Exception('Failed to load Stock data');
    }
  }

  static Future<StockDataModel?> getAllStock() async {
    String url =
        '${ApiUrl.API_BASE_URL2}${ApiUrl.GetStock}?CustomerName=${sharedPrefsClient.fullName}&PageIndex=0&PageSize=1000';
    Uri uri = Uri.parse(url);

    var headers = {
      'accept': '*/*',
      'Authorization': 'Bearer ${sharedPrefsClient.accessToken}'
    };

    http.Response response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      log(response.body);
      StockDataModel stockDataModel =
          StockDataModel.fromJson(jsonDecode(response.body));

      return stockDataModel;
    } else {
      throw Exception('Failed to load Stock data');
    }
  }

  static Future<WarehousesModel?> getWarehouse() async {
    String url =
        '${ApiUrl.API_BASE_URL2}${ApiUrl.getWarehouses}?PageIndex=0&PageSize=1000';
    Uri uri = Uri.parse(url);

    var headers = {
      'accept': '*/*',
      'Authorization': 'Bearer ${sharedPrefsClient.accessToken}'
    };

    http.Response response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      log(response.body);
      WarehousesModel warehousesModel =
          WarehousesModel.fromJson(jsonDecode(response.body));

      return warehousesModel;
    } else {
      throw Exception('Failed to load Stock data');
    }
  }

  static Future<bool> createTransaction(var body) async {
    String url = '${ApiUrl.API_BASE_URL2}${ApiUrl.createTransaction}';
    Uri uri = Uri.parse(url);

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${sharedPrefsClient.accessToken}'
    };

    http.Response response = await http.post(uri, body: body, headers: headers);
    print(body);

    print(response.body);
    if (response.statusCode == 200) {
      log(response.body);

      return true;
    } else {
      return false;
    }
  }

  static Future<AddStockModel?> addStock({
    required Map<String, String> fields,
    required String filePath,
  }) async {
    var url = Uri.parse('${ApiUrl.API_BASE_URL2}${ApiUrl.addStock}');
    var request = http.MultipartRequest('POST', url);
    request.headers.addAll({
      HttpHeaders.authorizationHeader:
          'Bearer ${sharedPrefsClient.accessToken}',
      HttpHeaders.contentTypeHeader: 'multipart/form-data',
    });

    fields.forEach((key, value) {
      request.fields[key] = value;
    });

    print(fields);
    request.files.add(await http.MultipartFile.fromPath(
      'File',
      filePath,
    ));

    var response = await request.send();

    print('*******************');
    print(response.statusCode);
    print(response.statusCode);
    print('*****************');
    if (response.statusCode == 200) {
      final responseData = await response.stream.toBytes();
      final responseString = utf8.decode(responseData);
      Map<String, dynamic> jsonResponse = json.decode(responseString);
      AddStockModel addStockModel =
          AddStockModel.fromJson(jsonDecode(responseString));
      return addStockModel;
    } else {
      print('Failed to create stock. Status code: ${response.statusCode}');
      return null;
    }
  }
}
