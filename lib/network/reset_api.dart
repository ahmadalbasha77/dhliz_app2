import 'dart:convert';
import 'package:dhliz_app/models/api_response.dart';
import 'package:dhliz_app/models/home/inventory_model.dart';
import 'package:dhliz_app/models/home/withdrawal_model.dart';
import 'package:dhliz_app/network/api_url.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import '../config/constant.dart';
import '../config/shared_prefs_client.dart';
import 'dart:developer' as developer;
import '../models/auth/login_model.dart';
import '../models/auth/register_model.dart';
import '../models/home/my_warehouse_model.dart';
import '../models/home/transfer_model.dart';
import '../models/home/transfer_warehouse_model.dart';
import '../models/home/withdrawal_warehouse_model.dart';
import '../models/main/notification_model.dart';
import '../models/main/profile_model.dart';
import '../models/main/transaction_model.dart';


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

    if (sharedPrefsClient.isLogin) {
      requestHeaders
          .addAll({'Authorization': "Bearer ${sharedPrefsClient.accessToken}"});
    }

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

    if (sharedPrefsClient.isLogin) {
      requestHeads
          .addAll({'Authorization': "Bearer ${sharedPrefsClient.accessToken}"});
    }

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
  static Future<ApiResponse<LoginModel>> signIn(
      {required String username, required String password}) async {
    var body = jsonEncode({
      "username": username,
      "password": password,
      "deviceToken": sharedPrefsClient.deviceToken,
      "platform": platform,
      "version": version,
      "language": sharedPrefsClient.language,
    });
    final request = _post(ApiUrl.LOGIN, data: body);
    var response = await _executeRequest<LoginModel>(
        method: request, fromJsonModel: (json) => LoginModel.fromJson(json));
    return response;
  }

  static Future<ApiResponse<LoginModel>> forgotPassword(
      {required String firebaseToken,
        required String phoneNumber,
        required String password}) async {
    var body = jsonEncode({
      "firebaseToken": firebaseToken,
      "phoneNumber": phoneNumber,
      "password": password,
    });
    final request = _post(ApiUrl.FORGOT_PASSWORD, data: body);
    var response = await _executeRequest<LoginModel>(
        method: request, fromJsonModel: (json) => LoginModel.fromJson(json));
    return response;
  }

  static Future<ApiResponse<RegisterModel>> register({
    required String firebaseToken,
    required String username,
    required String password,
    required String fullName,
    required String phoneNumber,
    required String homeAddress,
    required String workAddress,
    required String email,
    required String syndicateNumber,
    // required PlatformFile? image,
  }) async {
    var body = {
      "FirebaseToken": firebaseToken,
      "Username": username,
      "Password": password,
      "FullName": fullName,
      "PhoneNumber": phoneNumber,
      "HomeAddress": homeAddress,
      "WorkAddress": workAddress,
      "Email": email,
      "SyndicateNumber": syndicateNumber,
      "DeviceToken": sharedPrefsClient.deviceToken,
      "Platform": platform,
      "Version": version,
      "Language": sharedPrefsClient.language,
      // if (image != null)
      //   "Image": MultipartFile.fromBytes(image.bytes!.toList(),
      //       filename: image.name),
    };
    FormData formData = FormData.fromMap(body);
    final request = _post(ApiUrl.REGISTER, data: formData);
    var response = await _executeRequest<RegisterModel>(
        method: request, fromJsonModel: (json) => RegisterModel.fromJson(json));
    return response;
  }

// -----------------start profile --------------------------

  static Future<ApiResponse<ProfileModel>> getProfile() async {
    final request = _get(ApiUrl.GET_PROFILE);
    var response = await _executeRequest<ProfileModel>(
        method: request, fromJsonModel: (json) => ProfileModel.fromJson(json));
    return response;
  }

  static Future<ApiResponse> changeProfile({
    required String fullName,
    required String homeAddress,
    required String workAddress,
    required String email,
    required String syndicateNumber,
    required PlatformFile? image,
  }) async {
    var body = {
      "FullName": fullName,
      "HomeAddress": homeAddress,
      "WorkAddress": workAddress,
      "Email": email,
      "SyndicateNumber": syndicateNumber,

      if (image != null)
        "Image": MultipartFile.fromBytes(image.bytes!.toList(),
            filename: image.name),
    };
    FormData formData = FormData.fromMap(body);
    final request = _post(ApiUrl.CHANGE_PROFILE, data: formData);
    var response = await _executeRequest(method: request);
    return response;
  }
// -----------------end profile --------------------------

// -------------------------notification --------------------------

  static Future<ApiResponse<NotificationModel>> getNotifications(
      {required int skip, required int take, required String search}) async {
    var queryParameters = {
      "skip": skip,
      "take": take,
      "search": search,
    };
    final request =
        _get(ApiUrl.GET_NOTIFICATIONS, queryParameters: queryParameters);
    var response = await _executeRequest<NotificationModel>(
        method: request,
        fromJsonModel: (json) => NotificationModel.fromJson(json));
    return response;
  }

  static Future<ApiResponse<NotificationModel>> getNotification(
      {required String id}) async {
    var body = jsonEncode({
      "id": id,
    });
    final request = _post(ApiUrl.GET_NOTIFICATION, data: body);
    var response = await _executeRequest<NotificationModel>(
        method: request,
        fromJsonModel: (json) => NotificationModel.fromJson(json));
    return response;
  }

  static Future<ApiResponse> deleteNotification({required String id}) async {
    var body = jsonEncode({
      "id": id,
    });
    final request = _post(ApiUrl.DELETE_NOTIFICATIONS, data: body);
    var response = await _executeRequest(method: request);
    return response;
  }

  static Future<ApiResponse> addEditNotification({
    String? id,
    required String title,
    required String description,
    required String url,
    required DateTime date,
    required bool isPro,
    required PlatformFile? image,
  }) async {
    var body = {
      if (id != null) "Id": id,
      "Title": title,
      "Description": description,
      "Url": url,
      "Date": date.toIso8601String(),
      "IsPro": isPro,
      if (image != null)
        "Image": MultipartFile.fromBytes(image.bytes!.toList(),
            filename: image.name),
    };
    FormData formData = FormData.fromMap(body);
    final request = _post(ApiUrl.ADD_EDIT_NOTIFICATIONS, data: formData);
    var response = await _executeRequest(method: request);
    return response;
  }

// -------------------------End notification --------------------------

// -------------------------withdrawal --------------------------

  static Future<ApiResponse<WithdrawalModel>> getWithdrawals(
      {required int skip, required int take, required String search}) async {
    var queryParameters = {
      "skip": skip,
      "take": take,
      "search": search,
    };
    final request =
        _get(ApiUrl.GET_WITHDRAWALS, queryParameters: queryParameters);
    var response = await _executeRequest<WithdrawalModel>(
        method: request,
        fromJsonModel: (json) => WithdrawalModel.fromJson(json));
    return response;
  }

  static Future<ApiResponse<WithdrawalModel>> getCertificate(
      {required String id}) async {
    var body = jsonEncode({
      "id": id,
    });
    final request = _post(ApiUrl.GET_WITHDRAWAL, data: body);
    var response = await _executeRequest<WithdrawalModel>(
        method: request,
        fromJsonModel: (json) => WithdrawalModel.fromJson(json));
    return response;
  }

  static Future<ApiResponse> deleteCertificate({required String id}) async {
    var body = jsonEncode({
      "id": id,
    });
    final request = _post(ApiUrl.DELETE_WITHDRAWALS, data: body);
    var response = await _executeRequest(method: request);
    return response;
  }

  static Future<ApiResponse> addEditCertificate({
    String? id,
    required String title,
    required String description,
    required String url,
    required DateTime date,
    required bool isPro,
    required PlatformFile? image,
  }) async {
    var body = {
      if (id != null) "Id": id,
      "Title": title,
      "Description": description,
      "Url": url,
      "Date": date.toIso8601String(),
      "IsPro": isPro,
      if (image != null)
        "Image": MultipartFile.fromBytes(image.bytes!.toList(),
            filename: image.name),
    };
    FormData formData = FormData.fromMap(body);
    final request = _post(ApiUrl.ADD_EDIT_WITHDRAWALS, data: formData);
    var response = await _executeRequest(method: request);
    return response;
  }

// -------------------------End withdrawal --------------------------

// -------------------------inventory --------------------------

  static Future<ApiResponse<InventoryModel>> getInventories(
      {required int skip, required int take, required String search}) async {
    var queryParameters = {
      "skip": skip,
      "take": take,
      "search": search,
    };
    final request =
        _get(ApiUrl.GET_NOTIFICATIONS, queryParameters: queryParameters);
    var response = await _executeRequest<InventoryModel>(
        method: request,
        fromJsonModel: (json) => InventoryModel.fromJson(json));
    return response;
  }

  static Future<ApiResponse<InventoryModel>> getInventory(
      {required String id}) async {
    var body = jsonEncode({
      "id": id,
    });
    final request = _post(ApiUrl.GET_INVENTORY, data: body);
    var response = await _executeRequest<InventoryModel>(
        method: request,
        fromJsonModel: (json) => InventoryModel.fromJson(json));
    return response;
  }

  static Future<ApiResponse> deleteInventory({required String id}) async {
    var body = jsonEncode({
      "id": id,
    });
    final request = _post(ApiUrl.DELETE_INVENTORIES, data: body);
    var response = await _executeRequest(method: request);
    return response;
  }

  static Future<ApiResponse> addEditInventory({
    String? id,
    required String title,
    required String description,
    required String url,
    required DateTime date,
    required bool isPro,
    required PlatformFile? image,
  }) async {
    var body = {
      if (id != null) "Id": id,
      "Title": title,
      "Description": description,
      "Url": url,
      "Date": date.toIso8601String(),
      "IsPro": isPro,
      if (image != null)
        "Image": MultipartFile.fromBytes(image.bytes!.toList(),
            filename: image.name),
    };
    FormData formData = FormData.fromMap(body);
    final request = _post(ApiUrl.ADD_EDIT_INVENTORIES, data: formData);
    var response = await _executeRequest(method: request);
    return response;
  }

// -------------------------End inventory --------------------------

// -------------------------transfer --------------------------

  static Future<ApiResponse<TransferModel>> getTransfers(
      {required int skip, required int take, required String search}) async {
    var queryParameters = {
      "skip": skip,
      "take": take,
      "search": search,
    };
    final request =
        _get(ApiUrl.GET_NOTIFICATIONS, queryParameters: queryParameters);
    var response = await _executeRequest<TransferModel>(
        method: request, fromJsonModel: (json) => TransferModel.fromJson(json));
    return response;
  }

  static Future<ApiResponse<TransferModel>> getTransfer(
      {required String id}) async {
    var body = jsonEncode({
      "id": id,
    });
    final request = _post(ApiUrl.GET_INVENTORY, data: body);
    var response = await _executeRequest<TransferModel>(
        method: request, fromJsonModel: (json) => TransferModel.fromJson(json));
    return response;
  }

  static Future<ApiResponse> deleteTransfer({required String id}) async {
    var body = jsonEncode({
      "id": id,
    });
    final request = _post(ApiUrl.DELETE_INVENTORIES, data: body);
    var response = await _executeRequest(method: request);
    return response;
  }

  static Future<ApiResponse> addEditTransfer({
    String? id,
    required String title,
    required String description,
    required String url,
    required DateTime date,
    required bool isPro,
    required PlatformFile? image,
  }) async {
    var body = {
      if (id != null) "Id": id,
      "Title": title,
      "Description": description,
      "Url": url,
      "Date": date.toIso8601String(),
      "IsPro": isPro,
      if (image != null)
        "Image": MultipartFile.fromBytes(image.bytes!.toList(),
            filename: image.name),
    };
    FormData formData = FormData.fromMap(body);
    final request = _post(ApiUrl.ADD_EDIT_INVENTORIES, data: formData);
    var response = await _executeRequest(method: request);
    return response;
  }

// -------------------------End inventory --------------------------



// -------------------------transfer --------------------------

  static Future<ApiResponse<TransactionModel>> getTransactions(
      {required int skip, required int take, required String search}) async {
    var queryParameters = {
      "skip": skip,
      "take": take,
      "search": search,
    };
    final request =
    _get(ApiUrl.GET_TRANSACTIONS, queryParameters: queryParameters);
    var response = await _executeRequest<TransactionModel>(
        method: request, fromJsonModel: (json) => TransactionModel.fromJson(json));
    return response;
  }

  static Future<ApiResponse<TransactionModel>> getTransaction(
      {required String id}) async {
    var body = jsonEncode({
      "id": id,
    });
    final request = _post(ApiUrl.GET_TRANSACTION, data: body);
    var response = await _executeRequest<TransactionModel>(
        method: request, fromJsonModel: (json) => TransactionModel.fromJson(json));
    return response;
  }

  static Future<ApiResponse> deleteTransactions({required String id}) async {
    var body = jsonEncode({
      "id": id,
    });
    final request = _post(ApiUrl.DELETE_TRANSACTIONS, data: body);
    var response = await _executeRequest(method: request);
    return response;
  }

  static Future<ApiResponse> addEditTransactions({
    String? id,
    required String title,
    required String description,
    required String url,
    required DateTime date,
    required bool isPro,
    required PlatformFile? image,
  }) async {
    var body = {
      if (id != null) "Id": id,
      "Title": title,
      "Description": description,
      "Url": url,
      "Date": date.toIso8601String(),
      "IsPro": isPro,
      if (image != null)
        "Image": MultipartFile.fromBytes(image.bytes!.toList(),
            filename: image.name),
    };
    FormData formData = FormData.fromMap(body);
    final request = _post(ApiUrl.ADD_EDIT_TRANSACTIONS, data: formData);
    var response = await _executeRequest(method: request);
    return response;
  }

// -------------------------End inventory --------------------------




// -------------------------my warehouse --------------------------

  static Future<ApiResponse<MyWarehouseModel>> getMyWarehouses(
      {required int skip, required int take, required String search}) async {
    var queryParameters = {
      "skip": skip,
      "take": take,
      "search": search,
    };
    final request =
    _get(ApiUrl.GET_TRANSACTIONS, queryParameters: queryParameters);
    var response = await _executeRequest<MyWarehouseModel>(
        method: request, fromJsonModel: (json) => MyWarehouseModel.fromJson(json));
    return response;
  }

  static Future<ApiResponse<MyWarehouseModel>> getMyWarehouse(
      {required String id}) async {
    var body = jsonEncode({
      "id": id,
    });
    final request = _post(ApiUrl.GET_TRANSACTION, data: body);
    var response = await _executeRequest<MyWarehouseModel>(
        method: request, fromJsonModel: (json) => MyWarehouseModel.fromJson(json));
    return response;
  }

  static Future<ApiResponse> deleteTMyWarehouses({required String id}) async {
    var body = jsonEncode({
      "id": id,
    });
    final request = _post(ApiUrl.DELETE_TRANSACTIONS, data: body);
    var response = await _executeRequest(method: request);
    return response;
  }

  static Future<ApiResponse> addEditMyWarehouses({
    String? id,
    required String title,
    required String description,
    required String url,
    required DateTime date,
    required bool isPro,
    required PlatformFile? image,
  }) async {
    var body = {
      if (id != null) "Id": id,
      "Title": title,
      "Description": description,
      "Url": url,
      "Date": date.toIso8601String(),
      "IsPro": isPro,
      if (image != null)
        "Image": MultipartFile.fromBytes(image.bytes!.toList(),
            filename: image.name),
    };
    FormData formData = FormData.fromMap(body);
    final request = _post(ApiUrl.ADD_EDIT_TRANSACTIONS, data: formData);
    var response = await _executeRequest(method: request);
    return response;
  }

// -------------------------End my warehouse --------------------------




// -------------------------withdrawal warehouse --------------------------

  static Future<ApiResponse<WithdrawalWarehouseModel>> getWithdrawalWarehouses(
      {required int skip, required int take, required String search}) async {
    var queryParameters = {
      "skip": skip,
      "take": take,
      "search": search,
    };
    final request =
    _get(ApiUrl.GET_TRANSACTIONS, queryParameters: queryParameters);
    var response = await _executeRequest<WithdrawalWarehouseModel>(
        method: request, fromJsonModel: (json) => WithdrawalWarehouseModel.fromJson(json));
    return response;
  }

  static Future<ApiResponse<WithdrawalWarehouseModel>> getWithdrawalWarehouse(
      {required String id}) async {
    var body = jsonEncode({
      "id": id,
    });
    final request = _post(ApiUrl.GET_TRANSACTION, data: body);
    var response = await _executeRequest<WithdrawalWarehouseModel>(
        method: request, fromJsonModel: (json) => WithdrawalWarehouseModel.fromJson(json));
    return response;
  }

  static Future<ApiResponse> deleteWithdrawalWarehouses({required String id}) async {
    var body = jsonEncode({
      "id": id,
    });
    final request = _post(ApiUrl.DELETE_TRANSACTIONS, data: body);
    var response = await _executeRequest(method: request);
    return response;
  }

  static Future<ApiResponse> addEditWithdrawalWarehouses({
    String? id,
    required String title,
    required String description,
    required String url,
    required DateTime date,
    required bool isPro,
    required PlatformFile? image,
  }) async {
    var body = {
      if (id != null) "Id": id,
      "Title": title,
      "Description": description,
      "Url": url,
      "Date": date.toIso8601String(),
      "IsPro": isPro,
      if (image != null)
        "Image": MultipartFile.fromBytes(image.bytes!.toList(),
            filename: image.name),
    };
    FormData formData = FormData.fromMap(body);
    final request = _post(ApiUrl.ADD_EDIT_TRANSACTIONS, data: formData);
    var response = await _executeRequest(method: request);
    return response;
  }

// -------------------------End withdrawal warehouse --------------------------





// -------------------------transfer warehouse --------------------------

  static Future<ApiResponse<TransferWarehouseModel>> getTransferWarehouses(
      {required int skip, required int take, required String search}) async {
    var queryParameters = {
      "skip": skip,
      "take": take,
      "search": search,
    };
    final request =
    _get(ApiUrl.GET_TRANSACTIONS, queryParameters: queryParameters);
    var response = await _executeRequest<TransferWarehouseModel>(
        method: request, fromJsonModel: (json) => TransferWarehouseModel.fromJson(json));
    return response;
  }

  static Future<ApiResponse<TransferWarehouseModel>> getTransferWarehouse(
      {required String id}) async {
    var body = jsonEncode({
      "id": id,
    });
    final request = _post(ApiUrl.GET_TRANSACTION, data: body);
    var response = await _executeRequest<TransferWarehouseModel>(
        method: request, fromJsonModel: (json) => TransferWarehouseModel.fromJson(json));
    return response;
  }

  static Future<ApiResponse> deleteTransferWarehouses({required String id}) async {
    var body = jsonEncode({
      "id": id,
    });
    final request = _post(ApiUrl.DELETE_TRANSACTIONS, data: body);
    var response = await _executeRequest(method: request);
    return response;
  }

  static Future<ApiResponse> addEditTransferWarehouses({
    String? id,
    required String title,
    required String description,
    required String url,
    required DateTime date,
    required bool isPro,
    required PlatformFile? image,
  }) async {
    var body = {
      if (id != null) "Id": id,
      "Title": title,
      "Description": description,
      "Url": url,
      "Date": date.toIso8601String(),
      "IsPro": isPro,
      if (image != null)
        "Image": MultipartFile.fromBytes(image.bytes!.toList(),
            filename: image.name),
    };
    FormData formData = FormData.fromMap(body);
    final request = _post(ApiUrl.ADD_EDIT_TRANSACTIONS, data: formData);
    var response = await _executeRequest(method: request);
    return response;
  }

// -------------------------End transfer warehouse --------------------------
}
