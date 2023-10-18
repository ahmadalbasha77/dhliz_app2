
import 'dart:convert';

import 'package:dhliz_app/models/api_response.dart';
import 'package:dhliz_app/network/api_url.dart';
import 'package:dio/dio.dart';

import '../config/shared_prefs_client.dart';

import 'dart:developer' as developer;
class RestApi {



  static final Map<String, dynamic> _headers = {
    'Content-Type': 'application/json',
  };

  static final Dio restDio = Dio(BaseOptions(
    baseUrl: ApiUrl.API_BASE_URL,
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
  ));

  static void _traceError(DioError e) {
    String trace = '════════════════════════════════════════ \n'
        '╔╣ Dio [ERROR] info ==> \n'
        '╟ BASE_URL: ${e.requestOptions.baseUrl}\n'
        '╟ PATH: ${e.requestOptions.path}\n'
        '╟ Method: ${e.requestOptions.method}\n'
        '╟ Params: ${e.requestOptions.queryParameters}\n'
        '╟ Body: ${e.requestOptions.data}\n'
        '╟ Header: ${e.requestOptions.headers}\n'
        '╟ statusCode: ${e.response == null ? '' : e.response!.statusCode}\n'
        '╟ RESPONSE: ${e.response == null ? '' : e.response!.data} \n'
        '╟ stackTrace: ${e.stackTrace} \n'
        '╚ [END] ════════════════════════════════════════╝';
    developer.log(trace);
  }

  static void _traceCatch(e) {
    String trace = '════════════════════════════════════════ \n'
        '╔╣ Dio [Catch] info ==> \n'
        '╟ Runtime Type: ${e.runtimeType}\n'
        '╟ Catch: ${e.toString()}\n'
        '╚ [END] ════════════════════════════════════════╝';
    developer.log(trace);
  }

  static void _networkLog(Response response) {
    String trace = '════════════════════════════════════════ \n'
        '╔╣ Dio [RESPONSE] info ==> \n'
        '╟ BASE_URL: ${response.requestOptions.baseUrl}\n'
        '╟ PATH: ${response.requestOptions.path}\n'
        '╟ Method: ${response.requestOptions.method}\n'
        '╟ Params: ${response.requestOptions.queryParameters}\n'
        '╟ Body: ${response.requestOptions.data is FormData ? [
      ...response.requestOptions.data.fields,
      response.requestOptions.data.files
    ] : response.requestOptions.data}\n'
        '╟ Header: ${response.requestOptions.headers}\n'
        '╟ statusCode: ${response.statusCode}\n'
        '╟ RESPONSE: ${jsonEncode(response.data)} \n'
        '╚ [END] ════════════════════════════════════════╝';
    developer.log(trace);
  }

  static Future<Response<dynamic>> _post(String path,
      {dynamic data,
        Map<String, dynamic>? headers,
        Map<String, dynamic>? queryParameters}) {
    Map<String, dynamic> requestHeaders;

    if (headers == null) {
      requestHeaders = _headers;
    } else {
      requestHeaders = headers;
    }
    //
    // if (sharedPrefsClient.isLogin) {
    //   requestHeaders
    //       .addAll({'Authorization': "Bearer ${sharedPrefsClient.accessToken}"});
    // }

    restDio.options.headers = requestHeaders;
    return restDio.post(path, data: data, queryParameters: queryParameters);
  }

  static Future<Response<dynamic>> _get(String path,
      {Map<String, dynamic>? headers, Map<String, dynamic>? queryParameters}) {
    Map<String, dynamic> requestHeads;

    if (headers == null) {
      requestHeads = _headers;
    } else {
      requestHeads = headers;
    }

    // if (sharedPrefsClient.isLogin) {
    //   requestHeads
    //       .addAll({'Authorization': "Bearer ${sharedPrefsClient.accessToken}"});
    // }

    restDio.options.headers = requestHeads;
    return restDio.get(path, queryParameters: queryParameters);
  }

  static Future<ApiResponse<T>> _executeRequest<T>(
      {required Future<Response> method, Function? fromJsonModel}) async {
    try {
      final response = await method;
      _networkLog(response);
      ApiResponse<T> apiResponse =
      await _responseHandler(response, fromJsonModel);
      return apiResponse;
    } on DioError catch (e) {
      _traceError(e);
      ApiResponse<T> apiResponse =
      await _responseHandler(e.response, fromJsonModel);
      return apiResponse;
    } catch (e) {
      _traceCatch(e);
      ApiResponse<T> apiResponse = ApiResponse<T>.fromJson({}, fromJsonModel);
      return apiResponse;
    }
  }

  static Future<String> _errorMessageHandler(Response response) async {
    final message =
    (response.data is Map && response.data.containsKey('message'))
        ? response.data["message"]
        : "ErrorMessage";
    return message;
  }

  static Future<ApiResponse<T>> _responseHandler<T>(
      Response? response, Function? fromJsonModel) async {
    int statusCode = response?.statusCode ?? 600;
    if (statusCode == 200 && response != null && response.data != null) {
      statusCode = response.data['code'];
    }
    switch (statusCode) {
      case 200:
      case 201:
      case 204:
        return ApiResponse<T>.fromJson(response!.data, fromJsonModel);
      case 400:
        final String errorHandler = response!.data == null
            ? 'BadRequestException'
            : await _errorMessageHandler(response);
        return ApiResponse<T>.fromError(statusCode, errorHandler);
      case 401:
        final String errorHandler = response!.data == null
            ? 'Unauthorized'
            : await _errorMessageHandler(response);
        return ApiResponse<T>.fromError(statusCode, errorHandler);
      case 403:
        final String errorHandler = response!.data == null
            ? 'Forbidden'
            : await _errorMessageHandler(response);
        return ApiResponse<T>.fromError(statusCode, errorHandler);
      case 404:
        final String errorHandler = response!.data == null
            ? 'NotFoundException'
            : await _errorMessageHandler(response);
        return ApiResponse<T>.fromError(statusCode, errorHandler);
      case 406:
        final String errorHandler = response!.data == null
            ? 'Not Acceptable'
            : await _errorMessageHandler(response);
        return ApiResponse<T>.fromError(statusCode, errorHandler);
      case 412:
        final String errorHandler = response!.data == null
            ? 'PreconditionFailed'
            : await _errorMessageHandler(response);
        return ApiResponse<T>.fromError(statusCode, errorHandler);
      case 422:
        final String errorHandler = response!.data == null
            ? 'UnprocessableEntity'
            : await _errorMessageHandler(response);
        return ApiResponse<T>.fromError(statusCode, errorHandler);
      case 500:
        final String errorHandler = response!.data == null
            ? 'ServerException'
            : await _errorMessageHandler(response);
        return ApiResponse<T>.fromError(statusCode, errorHandler);
      case 600:
        const String errorHandler =
            'SocketException'; // 'There is no Internet!'
        return ApiResponse<T>.fromError(statusCode, errorHandler);
      default:
        final String errorHandler = response!.data == null
            ? 'SocketException'
            : await _errorMessageHandler(response); // 'There is no Internet!'
        return ApiResponse<T>.fromError(statusCode, errorHandler);
    }
  }



}