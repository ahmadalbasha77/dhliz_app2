import 'dart:convert';
import 'dart:developer';

import 'package:dhliz_app/config/shared_prefs_client.dart';
import 'package:dhliz_app/models/auth/register_model.dart';
import 'package:dhliz_app/models/main/profile_model.dart';
import 'package:dhliz_app/network/api_url.dart';
import 'package:http/http.dart' as http;
import '../config/utils.dart';
import '../models/auth/login_model.dart';
import '../models/main/transaction_model.dart';

class RestApi {
  static Future<UserResponse?> login(var body) async {
    String url = 'https://api.dhlez.sa/Login';
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
    print('3333333333333333333333333');
    String url = 'https://api.dhlez.sa/Signup';
    Uri uri = Uri.parse(url);
    var headers = {'Content-Type': 'application/json; charset=UTF-8'};
    http.Response response = await http.post(uri, headers: headers, body: body);
    print(response.statusCode);
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
        'https://api.dhlez.sa/api/Transaction/GetAllTransaction?PageIndex=$skip&PageSize=$take';
    Uri uri = Uri.parse(url);

    var headers = {
      'accept': '*/*',
      'Authorization': 'Bearer ${sharedPrefsClient.accessToken}'
    };

    http.Response response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      log(response.body);
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
}
