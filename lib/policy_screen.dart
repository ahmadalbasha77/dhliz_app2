import 'package:dhliz_app/config/shared_prefs_client.dart';
import 'package:dhliz_app/network/api_url.dart';
import 'package:dhliz_app/view/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'config/app_color.dart';
import 'config/utils.dart';

class PolicyScreen extends StatefulWidget {
  final int userId;

  const PolicyScreen({super.key, required this.userId});

  @override
  State<PolicyScreen> createState() => _PolicyScreenState();
}

class _PolicyScreenState extends State<PolicyScreen> {
  void activeUser() async {
    Utils.showLoadingDialog();
    String url = '${ApiUrl.API_BASE_URL2}/VerifyAccount?id=${widget.userId}';
    http.Response response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      Get.offAll(() => MainScreen());
      sharedPrefsClient.isLogin = true;
    } else {
      Get.snackbar(
        'please try again',
        'An unexpected error occurred',
        duration: const Duration(seconds: 4),
        backgroundColor: AppColor.gray.withOpacity(0.5),
        margin: EdgeInsets.only(top: 20.h, left: 10.w, right: 10.w),
      );
    }
    Utils.hideLoadingDialog();
  }

  bool checkedValue = false;
  String title =
      '* Of course, here is a definition of each point in the policy and terms of use of the mediation application between store owners and tenants:'
          .tr;
  String content =
      '1. Application definition:\n\n - The mediation application is an electronic platform that acts as an intermediary between store owners and tenants.\n\n The app allows warehouse owners to view information about their storage space and the services they provide, while tenants can search for suitable storage space and make reservations.\n\n 2. Registration and accounts:\n\n - All users must register their accounts in the application using personal information such as name and email address.\n\n - Users must provide accurate and correct information during the registration process to ensure smooth and effective communication.\n\n - Users must keep their account information confidential and not share it with any third party.\n\n 3. Rights and obligations:\n\n Store owners are obligated to provide accurate information about the store and the services provided, including prices and time frames.\n\n - Renters are obligated to comply with the terms and conditions applicable in the application, including the cancellation and compensation policy.\n\n 4. Booking and payment:\n\n - Tenants must make a reservation through the application and with the approval of the store owners for the reservation. Payment must be made via the payment methods available in the application, such as credit cards or electronic payment methods.\n\n - A commission will be collected from tenants when using the application services and will be paid to the store owners.\n\n 5. Insurance and liability:\n\n - The application may provide options for shipping and storage insurance. Users are responsible for choosing the insurance appropriate to their needs.\n\n - The application is not responsible for any damages or losses that occur during the use of the services provided on the platform.\n\n 6. Booking cancellation and refund:\n\n - Users must adhere to the reservation cancellation policy applicable in the application. A cancellation fee will apply to renters if a reservation is canceled after a certain period.\n\n 7. privacy policy:\n\n - The privacy policy outlines how we collect and use personal information in the application. Users must read and understand the privacy policy applicable to the application.\n\n 8. Account Termination:\n\n - The application has the right to terminate the account of any user who violates the terms and conditions or causes inconvenience to others. Account termination may include, for example, temporary or permanent suspension.\n\n 9. Change of terms and conditions:\n\n - The application may change the terms and conditions of use, and users will be notified of any potential changes through notifications or updates in the application.\n\n 10. Contact us:\n\n - Users should contact the app support team in case of any queries or issues while using the app.\n\n 11. Modify or cancel your reservation:\n\n - Renters can modify or cancel their reservations in accordance with the reservation modification and cancellation policy applicable in the application. A cancellation fee may apply to renters if a reservation is canceled after a certain period.\n\n 12. User Reviews:\n\n - Users can provide ratings and reviews for store owners and their services. Users must provide honest and constructive reviews to enhance the quality of the Services.\n\n 13. Information integrity:\n\n - Users should be careful when sharing sensitive information such as credit card information via the app. The application must have security measures to protect personal information.\n\n 14. Rulers violations:\n\n - Users must report any violations of the terms and conditions or security violations on the application. These reports will be investigated and necessary measures will be taken.\n\n 15. Local laws:\n\n - Users must comply with local laws and regulations applicable in their area when using the Application Services.\n\n 16. Compensation and responsibilities of both parties:\n\n - Tenants and store owners must reach a clear agreement regarding compensation in the event of any damages or losses occurring while using the services. The application is not responsible for any claims in this regard.\n\n 17. Cooperation with the authorities:\n\n - The application must cooperate with local authorities regarding investigations and information requested from it.\n\n 18. NOTICES AND COMMUNICATIONS:\n\n - The Application may send notifications and communications to users via email, text messages or other means for purposes such as platform updates and promotion of services.\n\n 19. Application of laws and disputes:\n\n In the event of any dispute between tenants and warehouse owners, the parties should try to resolve the dispute amicably first through communication and negotiation. If the dispute is not resolved amicably, the parties can resort to local laws and judicial system to resolve the dispute.\n\n 20. Updated policy and terms:\n\n The application development company reserves the right to amend or update the Terms and Conditions of Use. Users will be notified of any potential changes through the contact methods in the application'
          .tr;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Terms & Condition'.tr),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset('image/policy.webp', width: 220),
              Container(
                margin: const EdgeInsets.only(top: 20, right: 10, left: 10),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(
                      top: 15, right: 10, left: 10, bottom: 25),
                  child: Text(
                    content,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w500),
                  )),
              CheckboxListTile(
                title: Text(
                    "I've read and agree to the terms and conditions of the privacy policy"
                        .tr,
                    style: TextStyle(fontWeight: FontWeight.bold)),
                value: checkedValue,
                onChanged: (newValue) {
                  setState(() {
                    checkedValue = newValue!;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
              ),
              SizedBox(
                height: 10.h,
              ),
              checkedValue
                  ? SizedBox(
                      width: 250,
                      height: 50,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)))),
                        onPressed: () {
                          activeUser();
                        },
                        child: Text('Continue'.tr,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                      ),
                    )
                  : Container(
                      height: 50,
                    ),
              SizedBox(
                height: 15.h,
              )
            ],
          ),
        ),
      ),
    );
  }
}
