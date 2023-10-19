import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../inventory_screen.dart';

class InvoiceScreen extends StatefulWidget {
  const InvoiceScreen({super.key});

  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  Future<pw.ImageProvider> loadImage() async {
    return await imageFromAssetBundle(
      'image/home/Artboard 10.png',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text('invoice')),
      body: PdfPreview(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => InventoryScreen(),
                ));
              },
              icon: Text(
                'done',
                style: TextStyle(color: Colors.white),
              ))
        ],
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
                      child: pw.Image(imageProvider, width: 140),
                    ),

                    // Date
                    pw.SizedBox(height: 20),
                    pw.Center(
                      child: pw.Text(
                        'INVOICE',
                        style: pw.TextStyle(fontSize: 16),
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
                              'ID: 15442298',
                              style: pw.TextStyle(fontSize: 16),
                            ),
                          ]),
                    ),
                    pw.Container(
                      margin:
                          pw.EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                      child: pw.Text(
                        'Address : Amman , jabal alhusan , Yafa 33',
                        style: pw.TextStyle(fontSize: 16),
                      ),
                    ),
                    pw.Container(
                      margin:
                          pw.EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                      child: pw.Row(children: [
                        pw.Text(
                          'Warehouse Name : ',
                          style: pw.TextStyle(
                              fontSize: 16, fontWeight: pw.FontWeight.bold),
                        ),
                        pw.Text(
                          'Warehouse One',
                          style: pw.TextStyle(fontSize: 16),
                        ),
                      ]),
                    ),
                    pw.Divider(),
                    pw.Text('Warehouse Features',
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
                            pw.Text(
                              '1- Dry : ',
                              style: pw.TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            pw.Text(
                              '2- Cold',
                              style: pw.TextStyle(fontSize: 16),
                            ),
                            pw.Text(
                              '3- Freezing',
                              style: pw.TextStyle(fontSize: 16),
                            ),
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
                          '20 M²',
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
                              '15/10/2023',
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
                              '15/12/2023',
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
                              'TAX : ',
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
                              'Total  : ',
                              style: pw.TextStyle(
                                  fontSize: 24, fontWeight: pw.FontWeight.bold),
                            ),
                            pw.Text(
                              '500 SAR',
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
