import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../../../config/shared_prefs_client.dart';
import '../../../models/main/transaction_model.dart';
import '../../../network/api_url.dart';
import 'package:photo_view/photo_view.dart';

import '../../view_images.dart';

class StatusStockScreen extends StatefulWidget {
  final int stockId;
  final int transactionId;
  final TransactionDataModel data;

  const StatusStockScreen({
    super.key,
    required this.stockId,
    required this.transactionId,
    required this.data,
  });

  @override
  State<StatusStockScreen> createState() => _StatusStockScreenState();
}

class _StatusStockScreenState extends State<StatusStockScreen> {
  Map<String, dynamic> data = {};

  Future<Map<String, dynamic>> fetchData() async {
    final response = await http.get(
      Uri.parse(
          '${ApiUrl.API_BASE_URL2}/api/Stock/GetDtoById?id=${widget.stockId}'),
      headers: {'Authorization': 'Bearer ${sharedPrefsClient.accessToken}'},
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      if (jsonResponse['response'] != null) {
        return Map<String, dynamic>.from(jsonResponse['response']);
      } else {
        throw Exception('Missing data in response');
      }
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> updateStockStatus(String status) async {
    var uri = Uri.parse('${ApiUrl.API_BASE_URL2}/api/Transaction/UpdateStatus');
    var request = http.MultipartRequest('PUT', uri)
      ..headers['Authorization'] =
          'Bearer ${sharedPrefsClient.accessToken}' // Replace with your actual token
      ..fields['StockId'] = widget.stockId.toString()
      ..fields['TransactionId'] = widget.transactionId.toString()
      ..fields['Status'] = status;

    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        Get.back();
        Get.back();
        QuickAlert.show(
            context: context,
            type: QuickAlertType.success,
            text: 'transaction accepted done'.tr,
            showConfirmBtn: true,
            confirmBtnColor: Colors.white,
            confirmBtnTextStyle: const TextStyle(color: Colors.black),
            title: 'Completed Successfully !',
            textAlignment: TextAlign.center);
      } else {}
    } catch (e) {
      log('$e');
    }
  }

  @override
  void initState() {
    fetchData().then((result) {
      setState(() {
        data = result;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 231, 231, 231),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color.fromARGB(255, 231, 231, 231),
          centerTitle: true,
          title: Text('Stock Details'.tr,
              style: const TextStyle(color: Colors.black)),
        ),
        body: data.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 30),
                        child: Center(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) {
                                  return PhotoView(
                                    imageProvider: NetworkImage(data["photo"]),
                                  );
                                },
                              ));
                            },
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.network(
                                  data["photo"],
                                  width: double.infinity,
                                  height: 180,
                                  fit: BoxFit.cover,
                                )),
                          ),
                        ),
                      ),

                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 7),
                        child: Text(
                          '- ${"Name stock".tr}: ${data["name"]}',
                          style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5),
                        child: Text(
                          '- ${'Barcode'.tr} : ${data["code"]} ',
                          style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5),
                        child: Text(
                          '- ${'Upc stock'.tr}  : ${data["upc"]} ',
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      // Container(
                      //   margin:
                      //       EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      //   child: Text(
                      //     data[0]['brand'],
                      //     style: TextStyle(fontSize: 18, color: Colors.black54),
                      //   ),
                      // ),
                      const SizedBox(
                        height: 12,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5),
                        child: Text(
                          '- ${'Stock Brand'.tr} : ${data["brand"]} ',
                          style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      // Container(
                      //   margin:
                      //       EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      //   child: Text(
                      //     data[0]['upc'],
                      //     style: TextStyle(fontSize: 18, color: Colors.black54),
                      //   ),
                      // ),
                      const SizedBox(
                        height: 12,
                      ),
                      // Container(
                      //   margin:
                      //       EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      //   child: Text(
                      //     'The number',
                      //     style: TextStyle(fontSize: 18),
                      //   ),
                      // ),
                      // Container(
                      //   margin:
                      //       EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      //   child: Text(
                      //     'Cold',
                      //     style: TextStyle(fontSize: 18, color: Colors.black54),
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 12,
                      // ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5),
                        child: Text(
                          '- ${'Stock description'.tr} : ',
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        width: 300,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: Text(
                          '* ${data["description"]}',
                          style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      if (widget.data.matchingStatus == 5 &&
                          widget.data.matchingStatus == 6)
                        Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
                              child: Text(
                                '- ${'Reject Reason'.tr} : ',
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              width: 300,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: Text(
                                '* ${data["rejectReason"]}',
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                          ],
                        ),

                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5),
                        child: Row(
                          children: [
                            Text(
                              '- ${'Status Stock'.tr} : ',
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5),
                        child: Row(
                          children: [
                            Text(
                              '${widget.data.matchingStatus == 0 ? 'Under review'.tr : widget.data.matchingStatus == 1 ? 'stock accepted and entered'.tr : widget.data.matchingStatus == 2 ? 'Stock not match. Pending your review'.tr : widget.data.matchingStatus == 3 ? 'stock not match, but entry approved'.tr : widget.data.matchingStatus == 4 ? 'stock not match. Entry rejected'.tr : widget.data.matchingStatus == 5 ? 'Entry rejected'.tr : 'Entry rejected'.tr} ',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: widget.data.matchingStatus == 0 ||
                                          widget.data.matchingStatus == 2
                                      ? Colors.orange[300]
                                      : widget.data.matchingStatus == 1 ||
                                              widget.data.matchingStatus == 3
                                          ? Colors.green
                                          : Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            child: Text(
                              'Matching images'.tr,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      const MaterialStatePropertyAll(
                                          Colors.white),
                                  shape: MaterialStatePropertyAll(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)))),
                              onPressed: () {
                                List<String> imageUrls = widget
                                    .data.documentsStatus
                                    .map<String>((doc) => doc.filePath)
                                    .toList();

                                // Debugging output to check the extracted URLs

                                // Assuming PhotoGallery accepts a list of strings for image URLs
                                Get.to(
                                  () => PhotoGallery(imageUrls: imageUrls),
                                );
                              },
                              child: Text(
                                'view'.tr,
                                style: const TextStyle(color: Colors.black),
                              ))
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      // Row(
                      //   children: [
                      //     Container(
                      //       margin: EdgeInsets.symmetric(
                      //           horizontal: 15, vertical: 5),
                      //       child: Text(
                      //         '- هوية مسلم المخزون:',
                      //         style: TextStyle(
                      //             fontSize: 20, fontWeight: FontWeight.bold),
                      //       ),
                      //     ),
                      //     ElevatedButton(
                      //         style: ButtonStyle(
                      //             backgroundColor:
                      //                 MaterialStatePropertyAll(Colors.white),
                      //             shape: MaterialStatePropertyAll(
                      //                 RoundedRectangleBorder(
                      //                     borderRadius:
                      //                         BorderRadius.circular(10)))),
                      //         onPressed: () {},
                      //         child: Text(
                      //           'اظهار الصروة'.tr,
                      //           style: TextStyle(color: Colors.black),
                      //         ))
                      //   ],
                      // ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      // Row(
                      //   children: [
                      //     Container(
                      //       margin: EdgeInsets.symmetric(
                      //           horizontal: 15, vertical: 5),
                      //       child: Text(
                      //         '- رخصة المركبة :',
                      //         style: TextStyle(
                      //             fontSize: 20, fontWeight: FontWeight.bold),
                      //       ),
                      //     ),
                      //     ElevatedButton(
                      //         style: ButtonStyle(
                      //             backgroundColor:
                      //                 MaterialStatePropertyAll(Colors.white),
                      //             shape: MaterialStatePropertyAll(
                      //                 RoundedRectangleBorder(
                      //                     borderRadius:
                      //                         BorderRadius.circular(10)))),
                      //         onPressed: () {
                      //           print(data["status"]);
                      //         },
                      //         child: Text(
                      //           'اظهار الصروة'.tr,
                      //           style: TextStyle(color: Colors.black),
                      //         ))
                      //   ],
                      // ),
                      const SizedBox(
                        height: 60,
                      ),
                      widget.data.matchingStatus == 2
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  height: 65,
                                  width: 170,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                        shape: MaterialStatePropertyAll(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20))),
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                                Colors.green[400])),
                                    onPressed: () {
                                      // Get.to(() => ProductMatchesScreen());
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            elevation: 10,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            content: Text(
                                              'Are you sure the approve entry?'
                                                  .tr,
                                            ),
                                            actions: <Widget>[
                                              TextButton(
                                                style: TextButton.styleFrom(
                                                  foregroundColor: Colors.black,
                                                  textStyle: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium,
                                                ),
                                                child: Text('Cancel'.tr),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                  // You can add your disable logic here
                                                },
                                              ),
                                              TextButton(
                                                style: TextButton.styleFrom(
                                                  foregroundColor: Colors.black,
                                                  textStyle: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium,
                                                ),
                                                child: Text('confirm'.tr),
                                                onPressed: () {
                                                  updateStockStatus('3');
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.check_circle_outline_rounded,
                                          color: Colors.white,
                                        ),
                                        Text(
                                          textAlign: TextAlign.center,
                                          'Accept'.tr,
                                          style: const TextStyle(
                                              fontSize: 10,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  height: 65,
                                  width: 170,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                        shape: MaterialStatePropertyAll(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20))),
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                                Colors.red[400])),
                                    onPressed: () {
                                      // Get.to(() => ProductNotMatchesScreen());

                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            elevation: 10,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            content: Text(
                                              'Are you sure the reject entry?'
                                                  .tr,
                                            ),
                                            actions: <Widget>[
                                              TextButton(
                                                style: TextButton.styleFrom(
                                                  foregroundColor: Colors.black,
                                                  textStyle: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium,
                                                ),
                                                child: Text('Cancel'.tr),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                  // You can add your disable logic here
                                                },
                                              ),
                                              TextButton(
                                                style: TextButton.styleFrom(
                                                  foregroundColor: Colors.black,
                                                  textStyle: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium,
                                                ),
                                                child: Text('confirm'.tr),
                                                onPressed: () {
                                                  updateStockStatus('4');
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.cancel_outlined,
                                          color: Colors.white,
                                        ),
                                        Text(
                                          textAlign: TextAlign.center,
                                          'reject'.tr,
                                          style: const TextStyle(
                                              fontSize: 10,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : const SizedBox()
                    ]),
              ),
      ),
    );
  }
}
