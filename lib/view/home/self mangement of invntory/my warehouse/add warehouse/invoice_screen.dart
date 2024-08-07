import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../models/home/subscriptions_model.dart';
import '../my_warehouse_screen.dart';

class InvoiceScreen extends StatefulWidget {
  final int totalAmount;
  final SubscriptionDataModel? data;

  const InvoiceScreen({
    super.key,
    required this.totalAmount,
    required this.data,
  });

  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState();
}

pw.Font? _arabicFont;

Future<void> _loadFont() async {
  final fontData = await rootBundle.load('image/fonts/Amiri-Regular.ttf');
  _arabicFont = pw.Font.ttf(fontData);
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  Future<pw.ImageProvider> loadImage() async {
    return await imageFromAssetBundle(
      'image/home/dhlez_app_logo_without_bg.png',
    );
  }

  Future<int?> getSavedIdFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('postId');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadFont();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'invoice'.tr,
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
        actions: [
          TextButton(
              onPressed: () {
                Get.off(() => const MyWarehousesScreen());
              },
              child: Text(
                'done'.tr,
                style: const TextStyle(color: Colors.blue),
              ))
        ],
      ),
      body: PdfPreview(
        canDebug: false,
        build: (format) async {
          final imageProvider = await loadImage();
          final pdf = pw.Document();
          pdf.addPage(
            pw.Page(
              build: (pw.Context context) {
                return pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    // Logo Image

                    // Title
                    pw.SizedBox(height: 20),
                    pw.Center(
                      child: pw.Image(imageProvider, width: 100),
                    ),

                    // Date
                    pw.SizedBox(height: 20),
                    pw.Center(
                      child: pw.Text(
                        'Invoice'.toLowerCase(),
                        style: pw.TextStyle(fontSize: 16, font: _arabicFont),
                      ),
                    ),
                    pw.Divider(),
                    pw.Text('Invoice info'.tr,
                        style: pw.TextStyle(
                            fontSize: 18, fontWeight: pw.FontWeight.bold)),
                    pw.Container(
                      margin:
                          const pw.EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                      child: pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text(
                              'Date: ${DateFormat('yyyy-MM-dd').format(DateTime.now())}',
                              style: const pw.TextStyle(fontSize: 16),
                            ),
                            pw.Text(
                              'Tax Number: 3116620574',
                              style: const pw.TextStyle(fontSize: 16),
                            ),
                          ]),
                    ),
                    pw.Container(
                      margin:
                          const pw.EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                      child: pw.Text(
                        'Address : ${widget.data!.address.city} ',
                        style: const pw.TextStyle(fontSize: 16),
                      ),
                    ),
                    pw.Container(
                      margin:
                          const pw.EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                      child: pw.Row(children: [
                        pw.Text(
                          'Warehouse Name :',
                          style: pw.TextStyle(
                              fontSize: 16, fontWeight: pw.FontWeight.bold),
                        ),
                        pw.Text(
                          ' ${widget.data!.warehouse.name}',
                          style: const pw.TextStyle(fontSize: 16),
                        ),
                      ]),
                    ),
                    pw.Divider(),
                    pw.Text('Warehouse Features',
                        style: pw.TextStyle(
                            fontSize: 18, fontWeight: pw.FontWeight.bold)),
                    // pw.Container(
                    //   margin:
                    //       pw.EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                    //   child: pw.Text(
                    //     'Temperature',
                    //     style: pw.TextStyle(fontSize: 17),
                    //   ),
                    // ),
                    // pw.Container(
                    //   margin:
                    //       pw.EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    //   child: pw.Row(
                    //       mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    //       children: [
                    //         widget.dry == true
                    //             ? pw.Text(
                    //                 '- Dry : ',
                    //                 style: pw.TextStyle(
                    //                   fontSize: 16,
                    //                 ),
                    //               )
                    //             : pw.Container(),
                    //         widget.cold == true
                    //             ? pw.Text(
                    //                 '- Cold',
                    //                 style: pw.TextStyle(fontSize: 16),
                    //               )
                    //             : pw.Container(),
                    //         widget.freezing == true
                    //             ? pw.Text(
                    //                 '- Freezing',
                    //                 style: pw.TextStyle(fontSize: 16),
                    //               )
                    //             : pw.Container(),
                    //       ]),
                    // ),
                    pw.Container(
                      margin:
                          const pw.EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      child: pw.Row(children: [
                        pw.Text(
                          'Space : ',
                          style: pw.TextStyle(
                              fontSize: 16, fontWeight: pw.FontWeight.bold),
                        ),
                        pw.Text(
                          '${widget.data!.reservedSpace} M²',
                          style: const pw.TextStyle(fontSize: 16),
                        ),
                      ]),
                    ),
                    pw.Text('Warehouse rental period :',
                        style: pw.TextStyle(
                            fontSize: 18, fontWeight: pw.FontWeight.bold)),
                    pw.Container(
                      margin:
                          const pw.EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                      child: pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text(
                              'From : ',
                              style: const pw.TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            // pw.Text(
                            //   widget.subscriptionsDataModel!.startDate,
                            //   style: pw.TextStyle(fontSize: 16),
                            // ),
                          ]),
                    ),
                    pw.Container(
                      margin:
                          const pw.EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      child: pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text(
                              'To : ',
                              style: const pw.TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            // pw.Text(
                            //   widget.subscriptionsDataModel!.endDate,
                            //   style: pw.TextStyle(fontSize: 16),
                            // ),
                          ]),
                    ),
                    pw.Divider(),
                    pw.Container(
                      margin:
                          const pw.EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      child: pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                          children: [
                            pw.Text(
                              '${'TAX'} : ',
                              style: pw.TextStyle(
                                  fontSize: 20, fontWeight: pw.FontWeight.bold),
                            ),
                            pw.Text(
                              '0%',
                              style: pw.TextStyle(
                                  fontSize: 20, fontWeight: pw.FontWeight.bold),
                            ),
                          ]),
                    ),
                    pw.Container(
                      margin:
                          const pw.EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                      child: pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                          children: [
                            pw.Text(
                              'Total price  : ',
                              style: pw.TextStyle(
                                  fontSize: 24, fontWeight: pw.FontWeight.bold),
                            ),
                            pw.Text(
                              '${widget.totalAmount} ${'SAR'.tr}',
                              style: pw.TextStyle(
                                  fontSize: 24, fontWeight: pw.FontWeight.bold),
                            ),
                          ]),
                    ),
                  ],
                );
              },
            ),
          );

          return pdf.save();
        },
      ),
    );
  }
}
