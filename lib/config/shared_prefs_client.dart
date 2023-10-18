
import 'package:get_storage/get_storage.dart';
final sharedPrefsClient = SharedPrefsClient();

const String keyLanguage = "key_language";
const String keyIsGMS = "key_is_gms";



class SharedPrefsClient {
  static const String _storageName = "MyPref";

  static final GetStorage _storage = GetStorage(_storageName);

  init() async {
    await GetStorage.init(_storageName);
  }

  String get language => _storage.read(keyLanguage) ?? "";

  set language(String value) {
    _storage.write(keyLanguage, value);
  }


  bool get isGMS => _storage.read(keyIsGMS) ?? true;

  set isGMS(bool value) {
    _storage.write(keyIsGMS, value);
  }
}