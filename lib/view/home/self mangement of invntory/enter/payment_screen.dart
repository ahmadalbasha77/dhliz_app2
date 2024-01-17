import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moyasar/moyasar.dart';

import '../../../../widgets/payment.dart';

class PaymentScreen extends StatefulWidget {
  int amount;

  PaymentScreen({super.key, required this.amount});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final paymentConfig = PaymentConfig(
      publishableApiKey: 'pk_test_UcyrYkYmFtUSViCZvHphAJ1EfG59BxhREzHDQtNc',
      amount: 100,
      // SAR 1
      description: 'order #1324',
      metadata: {'size': '250g'},
      creditCard: CreditCardConfig(saveCard: false, manual: false),
      applePay: ApplePayConfig(
          merchantId: 'merchant.mysr.fghurayri',
          label: 'Blue Coffee Beans',
          manual: false));

  void onPaymentResult(result) {
    if (result is PaymentResponse) {
      showToast(context, result.status.name);
      switch (result.status) {
        case PaymentStatus.paid:
          Get.back();
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
                  paymentConfig: paymentConfig,
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
