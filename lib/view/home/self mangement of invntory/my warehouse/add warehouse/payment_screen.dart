import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moyasar/moyasar.dart';
import 'package:quickalert/quickalert.dart';

import 'package:http/http.dart' as http;
import '../../../../../config/shared_prefs_client.dart';
import '../../../../../models/home/subscriptions_model.dart';
import '../../../../../network/api_url.dart';
import '../../../../../widgets/payment.dart';
import 'invoice_screen.dart';

class PaymentScreen extends StatefulWidget {
  final int totalAmount;
  final SubscriptionDataModel? data;

  const PaymentScreen({
    super.key,
    required this.totalAmount,
    required this.data,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool loading = false;
  PaymentConfig? paymentConfig;

  void financialCreditor() async {
    final String apiUrl =
        '${ApiUrl.API_BASE_URL2}/api/Finantial/Creditor?id=${widget.data!.warehouse.id}&balance=${widget.totalAmount}';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer ${sharedPrefsClient.accessToken}',
        },
      );

      if (response.statusCode == 200) {
      } else {}
    } catch (e) {
      log('$e');
    }
  }

  void postData() async {
    final String apiUrl =
        '${ApiUrl.API_BASE_URL2}/api/Subscription/Pay?subscriptionId=${widget.data!.id}';

    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'Authorization': 'Bearer ${sharedPrefsClient.accessToken}',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      financialCreditor();
      // Get.off(() => MyWareHouseScreen());
      Get.off(InvoiceScreen(
        totalAmount: widget.totalAmount,
        data: widget.data,
      ));
      QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        text: 'Payment completed!',
        showConfirmBtn: false,
      );
    } else {
      Get.back();
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        text: 'Payment error!',
        showConfirmBtn: false,
      );
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
    int parsedAmount = double.parse(widget.totalAmount.toString()).toInt();
    int finalAmount = parsedAmount * 100;
    super.initState();
    paymentConfig = PaymentConfig(
      publishableApiKey: 'pk_test_UcyrYkYmFtUSViCZvHphAJ1EfG59BxhREzHDQtNc',
      amount: finalAmount,
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
                    padding: const EdgeInsets.all(70),
                    child: Image.asset(
                      'image/home/dhlez_app_logo_without_bg.png',
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
