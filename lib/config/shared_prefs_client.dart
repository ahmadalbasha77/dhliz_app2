import 'package:get_storage/get_storage.dart';


final sharedPrefsClient = SharedPrefsClient();

const String keyDeviceToken = "key_device_token";
const String keyAccessToken = "key_access_token";
const String keyApplicationId = "key_application_id";
const String keyCustomerId = 'key_customer_Id';
const String keyFullName = "key_full_name";
const String keyEmail = "key_email";
const String keyImage = "key_image";
const String keyIsLogin = "key_is_login";
const String keyIsOpen = "key_is_open";
const String keyLanguage = "key_language";
const String keyUserRole = "key_user_role";
const String keyIsGMS = "key_is_gms";

class SharedPrefsClient {
  static const String _storageName = "MyPref";

  static final GetStorage _storage = GetStorage(_storageName);

  init() async {
    await GetStorage.init(_storageName);
  }

  void clearProfile() {
    isLogin = false;
    accessToken = "";
    customerId = 0;
    applicationId = "";
    fullName = "";
    email = "";
    image = "";
  }

  String get deviceToken => _storage.read(keyDeviceToken) ?? "";

  set deviceToken(String value) {
    _storage.write(keyDeviceToken, value);
  }

  String get accessToken => _storage.read(keyAccessToken) ?? "";

  set accessToken(String value) {
    _storage.write(keyAccessToken, value);
  }

  int get customerId => _storage.read(keyCustomerId) ?? 0;

  set customerId(int value) {
    _storage.write(keyCustomerId, value);
  }

  String get applicationId => _storage.read(keyApplicationId) ?? "";

  set applicationId(String value) {
    _storage.write(keyApplicationId, value);
  }

  String get fullName => _storage.read(keyFullName) ?? "";

  set fullName(String value) {
    _storage.write(keyFullName, value);
  }

  String get email => _storage.read(keyEmail) ?? "";

  set email(String value) {
    _storage.write(keyEmail, value);
  }

  String get image => _storage.read(keyImage) ?? "";

  set image(String value) {
    _storage.write(keyImage, value);
  }

  String get language => _storage.read(keyLanguage) ?? "";

  set language(String value) {
    _storage.write(keyLanguage, value);
  }


  bool get isLogin => _storage.read(keyIsLogin) ?? false;

  set isLogin(bool value) {
    _storage.write(keyIsLogin, value);
  }

  bool get isOpen => _storage.read(keyIsOpen) ?? false;

  set isOpen(bool value) {
    _storage.write(keyIsOpen, value);
  }
  // UserRoleEnum get userRole => UserRoleEnum.values.firstWhere(
  //     (element) => element.value == (_storage.read(keyUserRole) ?? 0));
  //
  // set userRole(UserRoleEnum roleEnum) {
  //   _storage.write(keyUserRole, roleEnum.value);
  // }

  bool get isGMS => _storage.read(keyIsGMS) ?? true;

  set isGMS(bool value) {
    _storage.write(keyIsGMS, value);
  }
}
