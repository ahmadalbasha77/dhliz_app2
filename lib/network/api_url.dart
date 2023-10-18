import 'package:dhliz_app/config/shared_prefs_client.dart';
import 'package:dhliz_app/config/utils.dart';

class ApiUrl {

  static String API_BASE_URL = "https://api.doctors.association.faistec.com/${Utils.isEmpty(sharedPrefsClient.language) ? 'default' : sharedPrefsClient.language == 'en' ? 'en-US' : 'ar-JO'}/api";

  static String LOGIN = "/Auth/Login";

}