class ApiUrl {
  // ignore: non_constant_identifier_names
  static String API_BASE_URL = "https://api.dhlez.sa/api";

  static String API_BASE_URL2= "https://8fdb-176-29-253-212.ngrok-free.app";

  // static String API_BASE_URL = "https://api.dhlez.sa/api";

  static String tokenLogin =
      'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJFbWFpbCI6IiIsIlBob25lIjoiMDc5MTkzNzg1NyIsIk5hbWUiOiJ6YWlkIiwiUGVybWlzc2lvbiI6IkN1c3RvbWVyLkdldEFsbER0byIsImV4cCI6MTcwNjA5MjYxOH0.89CzeosH0GL5nDfgs7Jh0Q3gCZw1KFJJ4o-VfOciTZg';

  // ignore: non_constant_identifier_names
  static String LOGIN = "/Login";

  // ignore: non_constant_identifier_names
  static String REGISTER = "/Signup";

  // ignore: non_constant_identifier_names
  static String GetTransaction = "/api/Transaction/GetAllTransaction";

  // ignore: non_constant_identifier_names
  static String GetSubscriptions = "/api/Customer/GetSupscriptionByCustomerId";

  // ignore: non_constant_identifier_names
  static String GetStock = "/api/Stock/Find";

  // ignore: non_constant_identifier_names
  static String createTransaction = "/api/Transaction/Create";

  // ignore: non_constant_identifier_names
  static String addStock = "/api/Stock/CreateWithFile";

  // ignore: non_constant_identifier_names
  static String getWarehouses = "/api/Warehouse/Find";
}
