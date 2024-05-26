import 'package:dhliz_app/view/home/self%20mangement%20of%20invntory/warehouse%20management/my_warehouse_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import 'package:shared_preferences/shared_preferences.dart';

class InvoiceScreen extends StatefulWidget {
  String warehouseId;
  String warehouseName;
  String address;
  String fromDate;
  String toDate;
  String space;
  double total;
  bool dry;
  bool cold;
  bool freezing;

  InvoiceScreen(
      {super.key,
      required this.warehouseId,
      required this.warehouseName,
      required this.address,
      required this.space,
      required this.fromDate,
      required this.toDate,
      required this.dry,
      required this.cold,
      required this.freezing,
      required this.total});

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
          style: TextStyle(color: Colors.black ,  ),
        ),
        actions: [
          TextButton(
              onPressed: () {
                Get.off(() => MyWareHouseScreen());
              },
              child: Text(
                'done'.tr,
                style: TextStyle(color: Colors.blue),
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
                        'مرحبا',
                        style: pw.TextStyle(fontSize: 16 , font: _arabicFont),
                      ),
                    ),
                    pw.Divider(),
                    pw.Text('Invoice info',
                        style: pw.TextStyle(
                            fontSize: 18, fontWeight: pw.FontWeight.bold)),
                    pw.Container(
                      margin:
                          pw.EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                      child: pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text(
                              'Date: ${DateFormat('yyyy-MM-dd').format(DateTime.now())}',
                              style: pw.TextStyle(fontSize: 16),
                            ),
                            pw.Text(
                              'Tax Number: 3116620574',
                              style: pw.TextStyle(fontSize: 16),
                            ),
                          ]),
                    ),
                    pw.Container(
                      margin:
                          pw.EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                      child: pw.Text(
                        'Address : ${widget.address} , jabal alhusan , Yafa 33',
                        style: pw.TextStyle(fontSize: 16),
                      ),
                    ),
                    pw.Container(
                      margin:
                          pw.EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                      child: pw.Row(children: [
                        pw.Text(
                          'Warehouse Name :',
                          style: pw.TextStyle(
                              fontSize: 16, fontWeight: pw.FontWeight.bold),
                        ),
                        pw.Text(
                          ' ${widget.warehouseName}',
                          style: pw.TextStyle(fontSize: 16),
                        ),
                      ]),
                    ),
                    pw.Divider(),
                    pw.Text('${'Warehouse Features'}',
                        style: pw.TextStyle(
                            fontSize: 18, fontWeight: pw.FontWeight.bold)),
                    pw.Container(
                      margin:
                          pw.EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                      child: pw.Text(
                        'Temperature',
                        style: pw.TextStyle(fontSize: 17),
                      ),
                    ),
                    pw.Container(
                      margin:
                          pw.EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            widget.dry == true
                                ? pw.Text(
                                    '- Dry : ',
                                    style: pw.TextStyle(
                                      fontSize: 16,
                                    ),
                                  )
                                : pw.Container(),
                            widget.cold == true
                                ? pw.Text(
                                    '- Cold',
                                    style: pw.TextStyle(fontSize: 16),
                                  )
                                : pw.Container(),
                            widget.freezing == true
                                ? pw.Text(
                                    '- Freezing',
                                    style: pw.TextStyle(fontSize: 16),
                                  )
                                : pw.Container(),
                          ]),
                    ),
                    pw.Container(
                      margin:
                          pw.EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      child: pw.Row(children: [
                        pw.Text(
                          'Space : ',
                          style: pw.TextStyle(
                              fontSize: 16, fontWeight: pw.FontWeight.bold),
                        ),
                        pw.Text(
                          '${widget.space} M²',
                          style: pw.TextStyle(fontSize: 16),
                        ),
                      ]),
                    ),
                    pw.Text('Warehouse rental period :',
                        style: pw.TextStyle(
                            fontSize: 18, fontWeight: pw.FontWeight.bold)),
                    pw.Container(
                      margin:
                          pw.EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                      child: pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text(
                              'From : ',
                              style: pw.TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            pw.Text(
                              widget.fromDate,
                              style: pw.TextStyle(fontSize: 16),
                            ),
                          ]),
                    ),
                    pw.Container(
                      margin:
                          pw.EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      child: pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text(
                              'To : ',
                              style: pw.TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            pw.Text(
                              widget.toDate,
                              style: pw.TextStyle(fontSize: 16),
                            ),
                          ]),
                    ),
                    pw.Divider(),
                    pw.Container(
                      margin:
                          pw.EdgeInsets.symmetric(horizontal: 30, vertical: 10),
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
                          pw.EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                      child: pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                          children: [
                            pw.Text(
                              'Total price  : ',
                              style: pw.TextStyle(
                                  fontSize: 24, fontWeight: pw.FontWeight.bold),
                            ),
                            pw.Text(
                              '${widget.total} ${'SAR'.tr}',
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
