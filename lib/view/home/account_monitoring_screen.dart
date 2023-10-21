import 'package:flutter/material.dart';

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
          title:
              Text('Account Monitoring', style: TextStyle(color: Colors.black)),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              PieChart(
                dataMap: {
                  'Enter': 10,
                  'Transfer': 20,
                  'Withdrawal': 15,
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
                        Text('Enter Inventory',
                            style: TextStyle(
                                color: Colors.orange[800], fontSize: 12)),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            ' 2,500 WP',
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
                        Text('Transfer Inventory',
                            style: TextStyle(
                                color: Colors.blue[800], fontSize: 12)),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            r' 3,500 WP',
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
                        Text('Withdrawal of Inventory',
                            style:
                                TextStyle(color: Colors.purple, fontSize: 12)),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            '1,300 WP',
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
                        Text('Earnings (Annual)',
                            style:
                                TextStyle(color: Colors.green, fontSize: 12)),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            r' 10,000 SAR',
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
                        Text('Amounts due',
                            style: TextStyle(color: Colors.red, fontSize: 12)),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            r'  -2,000 SAR',
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
