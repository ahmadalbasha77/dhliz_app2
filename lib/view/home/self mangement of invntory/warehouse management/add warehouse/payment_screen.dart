import 'dart:convert';

import 'package:dhliz_app/view/home/self%20mangement%20of%20invntory/warehouse%20management/my_warehouse_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moyasar/moyasar.dart';
import 'package:quickalert/quickalert.dart';

import 'package:http/http.dart' as http;
import '../../../../../config/shared_prefs_client.dart';
import '../../../../../network/api_url.dart';
import '../../../../../widgets/payment.dart';

class PaymentScreen extends StatefulWidget {
  int amount;
  int customerId;
  String warehouseId;
  int capacity;

  PaymentScreen(
      {super.key,
      required this.amount,
      required this.customerId,
      required this.capacity,
      required this.warehouseId});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  PaymentConfig? paymentConfig;

  void postData() async {
    final String apiUrl = '${ApiUrl.API_BASE_URL}/Subscription/Create';

    Map<String, dynamic> requestBody = {
      "ReservedSpace": widget.capacity.toString(),
      "CustomerId": '4',
      "WarehouseId": widget.warehouseId,
    };

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Authorization': 'Bearer ${sharedPrefsClient.accessToken}',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      print("POST request successful!");
      print("Response: ${response.body}");
      Get.off(() => MyWareHouseScreen());
      QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        text: 'new subscription added successfully!',
        showConfirmBtn: false,
      );
      // Get.off(InvoiceScreen(
      //   warehouseId: widget.warehouseId,
      //   warehouseName: widget.warehouseName,
      //   space: widget.space,
      //   address: widget.address,
      //   total: totalPrice.toDouble(),
      //   fromDate: widget.from,
      //   toDate: widget.to,
      //   dry: widget.dry,
      //   cold: widget.cold,
      //   freezing: widget.freezing,
      // ));
    } else {
      print("Failed to make POST request. Status code: ${response.statusCode}");
      print("Response: ${response.body}");
      print("Request Body: $requestBody");
    }
  }

  // final paymentConfig = PaymentConfig(
  //     publishableApiKey: 'pk_test_UcyrYkYmFtUSViCZvHphAJ1EfG59BxhREzHDQtNc',
  //     amount: widget.amount,
  //     // SAR 1
  //     description: 'order #1324',
  //     metadata: {'size': '250g'},
  //     creditCard: CreditCardConfig(saveCard: false, manual: false),
  //     applePay: ApplePayConfig(
  //         merchantId: 'merchant.mysr.fghurayri',
  //         label: 'Blue Coffee Beans',
  //         manual: false));

  void onPaymentResult(result) {
    if (result is PaymentResponse) {
      showToast(context, result.status.name);
      switch (result.status) {
        case PaymentStatus.paid:
          postData();

          // handle success.
          break;
        case PaymentStatus.failed:
          // handle failure.
          break;
        case PaymentStatus.authorized:
          // handle authorized.
          break;
        default:
      }
      return;
    }

    // handle failures.
    if (result is ApiError) {}
    if (result is AuthError) {}
    if (result is ValidationError) {}
    if (result is PaymentCanceledError) {}
    if (result is UnprocessableTokenError) {}
    if (result is TimeoutError) {}
    if (result is NetworkError) {}
    if (result is UnspecifiedError) {}
  }

  @override
  void initState() {
    super.initState();
    paymentConfig = PaymentConfig(
      publishableApiKey: 'pk_test_UcyrYkYmFtUSViCZvHphAJ1EfG59BxhREzHDQtNc',
      amount: widget.amount * 100,
      description: 'order #1324',
      metadata: {'size': '250g'},
      creditCard: CreditCardConfig(saveCard: false, manual: false),
      applePay: ApplePayConfig(
          merchantId: 'merchant.mysr.fghurayri',
          label: 'Blue Coffee Beans',
          manual: false),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        body: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: ListView(
              children: [
                Padding(
                    padding: EdgeInsets.all(70),
                    child: Image.asset(
                      'image/dehliz/logo_dhlez.png',
                    )),
                PaymentMethods(
                  paymentConfig: paymentConfig!,
                  onPaymentResult: onPaymentResult,
                ),
              ],
            ),
          ),
        ));
  }
}

void showToast(context, status) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      "Status: $status",
      style: const TextStyle(fontSize: 20),
    ),
  ));
}
