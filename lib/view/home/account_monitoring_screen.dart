import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pie_chart/pie_chart.dart';

class StockMonitoringScreen extends StatefulWidget {
  const StockMonitoringScreen({Key? key}) : super(key: key);

  @override
  State<StockMonitoringScreen> createState() => _StockMonitoringScreenState();
}

class _StockMonitoringScreenState extends State<StockMonitoringScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 231, 231, 231),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text('Account Monitoring'.tr,
              style: TextStyle(color: Colors.black)),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Text('سوف يتم تحليل البيانات قريبا',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(
                height: 20,
              ),
              PieChart(
                dataMap: {
                  'Enter'.tr: 0,
                  'Transfer'.tr: 0,
                  'Withdrawal'.tr: 0,
                },
                animationDuration: Duration(milliseconds: 800),
                chartLegendSpacing: 32,
                chartRadius: MediaQuery.of(context).size.width / 3.2,
                colorList: [
                  Colors.orange,
                  Colors.blue,
                  Colors.purple,
                ],
                initialAngleInDegree: 0,
                chartType: ChartType.disc,
                ringStrokeWidth: 32,
                centerText: "Avg",
                legendOptions: LegendOptions(
                  showLegendsInRow: false,
                  legendPosition: LegendPosition.right,
                  showLegends: true,
                  legendShape: BoxShape.circle,
                  legendTextStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                chartValuesOptions: ChartValuesOptions(
                  showChartValueBackground: false,
                  showChartValues: true,
                  showChartValuesInPercentage: false,
                  showChartValuesOutside: false,
                  decimalPlaces: 1,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Enter Inventory'.tr,
                            style: TextStyle(
                                color: Colors.orange[800], fontSize: 12)),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            ' 0 WP',
                            style:
                                TextStyle(fontSize: 24, color: Colors.black54),
                          ),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.arrow_forward,
                      color: Colors.black26,
                      size: 45,
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Transfer Inventory'.tr,
                            style: TextStyle(
                                color: Colors.blue[800], fontSize: 12)),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            r' 0 WP',
                            style:
                                TextStyle(fontSize: 24, color: Colors.black54),
                          ),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.trending_up_rounded,
                      color: Colors.black26,
                      size: 45,
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Withdrawal of Inventory'.tr,
                            style:
                                TextStyle(color: Colors.purple, fontSize: 12)),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            '0 WP',
                            style:
                                TextStyle(fontSize: 24, color: Colors.black54),
                          ),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.arrow_downward,
                      color: Colors.black26,
                      size: 45,
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Earnings (Annual)'.tr,
                            style:
                                TextStyle(color: Colors.green, fontSize: 12)),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            r' 0 SAR',
                            style:
                                TextStyle(fontSize: 24, color: Colors.black54),
                          ),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.monetization_on_outlined,
                      color: Colors.black26,
                      size: 45,
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Amounts due'.tr,
                            style: TextStyle(color: Colors.red, fontSize: 12)),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            r'0 SAR',
                            style: TextStyle(fontSize: 24, color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.monetization_on_outlined,
                      color: Colors.red,
                      size: 45,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
