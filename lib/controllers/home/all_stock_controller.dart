import 'package:dhliz_app/models/home/stock_model.dart';
import 'package:dhliz_app/network/reset_api.dart';
import 'package:get/get.dart';

class AllStockController extends GetxController {
  static AllStockController get to => Get.isRegistered<AllStockController>()
      ? Get.find<AllStockController>()
      : Get.put(AllStockController());

  String? selectedStockId;

  // Method to update the selected stock ID
  void setSelectedStockId(String? id) {
    selectedStockId = id;
    update(); // Notify listeners about the change
  }

  List<StockDataModel> allStocks = [];

  @override
  void onInit() {
    super.onInit();
    getAllStockByCustomer();
  }

  void getAllStockByCustomer() async {
    allStocks = await RestApi.getAllStockByCustomer();
    update(); // This will trigger UI updates
  }
}
