import 'package:dhliz_app/config/shared_prefs_client.dart';
import 'package:dhliz_app/config/utils.dart';

class ApiUrl {
  static String API_BASE_URL =
      "https://api.doctors.association.faistec.com/${Utils.isEmpty(sharedPrefsClient.language) ? 'default' : sharedPrefsClient.language == 'en' ? 'en-US' : 'ar-JO'}/api";

  static String LOGIN = "/Auth/Login";

// -----------------start notification --------------------------
  // ignore: non_constant_identifier_names
  static String GET_NOTIFICATIONS = "/Event/GetEvents";

  // ignore: non_constant_identifier_names
  static String GET_NOTIFICATION = "/Event/GetEvent";

  // ignore: non_constant_identifier_names
  static String DELETE_NOTIFICATIONS = "/Event/DeleteEvent";

  // ignore: non_constant_identifier_names
  static String ADD_EDIT_NOTIFICATIONS = "/Event/AddEditEvent";

// -----------------End notification --------------------------



// -----------------start WITHDRAWAL --------------------------
  // ignore: non_constant_identifier_names
  static String GET_WITHDRAWALS = "/Event/GetEvents";

  // ignore: non_constant_identifier_names
  static String GET_WITHDRAWAL = "/Event/GetEvent";

  // ignore: non_constant_identifier_names
  static String DELETE_WITHDRAWALS = "/Event/DeleteEvent";

  // ignore: non_constant_identifier_names
  static String ADD_EDIT_WITHDRAWALS = "/Event/AddEditEvent";

// -----------------End WITHDRAWAL --------------------------


// -----------------start inventory --------------------------
  // ignore: non_constant_identifier_names
  static String GET_INVENTORIES = "/Event/GetEvents";

  // ignore: non_constant_identifier_names
  static String GET_INVENTORY = "/Event/GetEvent";

  // ignore: non_constant_identifier_names
  static String DELETE_INVENTORIES = "/Event/DeleteEvent";

  // ignore: non_constant_identifier_names
  static String ADD_EDIT_INVENTORIES = "/Event/AddEditEvent";

// -----------------End inventory --------------------------


// -----------------start transfer --------------------------
  // ignore: non_constant_identifier_names
  static String GET_TRANSFERS = "/Event/GetEvents";

  // ignore: non_constant_identifier_names
  static String GET_TRANSFER = "/Event/GetEvent";

  // ignore: non_constant_identifier_names
  static String DELETE_TRANSFERS = "/Event/DeleteEvent";

  // ignore: non_constant_identifier_names
  static String ADD_EDIT_TRANSFERS = "/Event/AddEditEvent";

// -----------------End transfer --------------------------


// -----------------start transaction --------------------------
  // ignore: non_constant_identifier_names
  static String GET_TRANSACTIONS = "/Event/GetEvents";

  // ignore: non_constant_identifier_names
  static String GET_TRANSACTION = "/Event/GetEvent";

  // ignore: non_constant_identifier_names
  static String DELETE_TRANSACTIONS = "/Event/DeleteEvent";

  // ignore: non_constant_identifier_names
  static String ADD_EDIT_TRANSACTIONS = "/Event/AddEditEvent";

// -----------------End transaction --------------------------



// -----------------start my warehouse --------------------------
  // ignore: non_constant_identifier_names
  static String GET_MY_WAREHOUSES = "/Event/GetEvents";

  // ignore: non_constant_identifier_names
  static String GET_MY_WAREHOUSE = "/Event/GetEvent";

  // ignore: non_constant_identifier_names
  static String DELETE_MY_WAREHOUSE = "/Event/DeleteEvent";

  // ignore: non_constant_identifier_names
  static String ADD_EDIT_MY_WAREHOUSE = "/Event/AddEditEvent";

// -----------------End warehouse --------------------------

// -----------------start withdrawal warehouse --------------------------
  // ignore: non_constant_identifier_names
  static String GET_WITHDRAWAL_WAREHOUSES = "/Event/GetEvents";

  // ignore: non_constant_identifier_names
  static String GET_WITHDRAWAL_WAREHOUSE = "/Event/GetEvent";

  // ignore: non_constant_identifier_names
  static String DELETE_WITHDRAWAL_WAREHOUSE = "/Event/DeleteEvent";

  // ignore: non_constant_identifier_names
  static String ADD_EDIT_WITHDRAWAL_WAREHOUSE = "/Event/AddEditEvent";

// -----------------End withdrawal warehouse --------------------------




// -----------------start transfer warehouse --------------------------
  // ignore: non_constant_identifier_names
  static String GET_TRANSFER_WAREHOUSES = "/Event/GetEvents";

  // ignore: non_constant_identifier_names
  static String GET_TRANSFER_WAREHOUSE = "/Event/GetEvent";

  // ignore: non_constant_identifier_names
  static String DELETE_TRANSFER_WAREHOUSE = "/Event/DeleteEvent";

  // ignore: non_constant_identifier_names
  static String ADD_EDIT_TRANSFER_WAREHOUSE = "/Event/AddEditEvent";

// -----------------End transfer warehouse --------------------------
}
