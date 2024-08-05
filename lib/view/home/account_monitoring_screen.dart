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
        backgroundColor: const Color.fromARGB(255, 231, 231, 231),
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text('Account Monitoring'.tr,
              style: const TextStyle(color: Colors.black)),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text('سوف يتم تحليل البيانات قريبا',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 20,
              ),
              PieChart(
                dataMap: {
                  'Enter'.tr: 0,
                  'Transfer'.tr: 0,
                  'Withdrawal'.tr: 0,
                },
                animationDuration: const Duration(milliseconds: 800),
                chartLegendSpacing: 32,
                chartRadius: MediaQuery.of(context).size.width / 3.2,
                colorList: const [
                  Colors.orange,
                  Colors.blue,
                  Colors.purple,
                ],
                initialAngleInDegree: 0,
                chartType: ChartType.disc,
                ringStrokeWidth: 32,
                centerText: "Avg",
                legendOptions: const LegendOptions(
                  showLegendsInRow: false,
                  legendPosition: LegendPosition.right,
                  showLegends: true,
                  legendShape: BoxShape.circle,
                  legendTextStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                chartValuesOptions: const ChartValuesOptions(
                  showChartValueBackground: false,
                  showChartValues: true,
                  showChartValuesInPercentage: false,
                  showChartValuesOutside: false,
                  decimalPlaces: 1,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
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
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: const Text(
                            ' 0 WP',
                            style:
                                TextStyle(fontSize: 24, color: Colors.black54),
                          ),
                        ),
                      ],
                    ),
                    const Icon(
                      Icons.arrow_forward,
                      color: Colors.black26,
                      size: 45,
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
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
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: const Text(
                            r' 0 WP',
                            style:
                                TextStyle(fontSize: 24, color: Colors.black54),
                          ),
                        ),
                      ],
                    ),
                    const Icon(
                      Icons.trending_up_rounded,
                      color: Colors.black26,
                      size: 45,
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
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
                                const TextStyle(color: Colors.purple, fontSize: 12)),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: const Text(
                            '0 WP',
                            style:
                                TextStyle(fontSize: 24, color: Colors.black54),
                          ),
                        ),
                      ],
                    ),
                    const Icon(
                      Icons.arrow_downward,
                      color: Colors.black26,
                      size: 45,
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
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
                                const TextStyle(color: Colors.green, fontSize: 12)),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: const Text(
                            r' 0 SAR',
                            style:
                                TextStyle(fontSize: 24, color: Colors.black54),
                          ),
                        ),
                      ],
                    ),
                    const Icon(
                      Icons.monetization_on_outlined,
                      color: Colors.black26,
                      size: 45,
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
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
                            style: const TextStyle(color: Colors.red, fontSize: 12)),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: const Text(
                            r'0 SAR',
                            style: TextStyle(fontSize: 24, color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                    const Icon(
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
