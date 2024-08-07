import 'package:flutter/material.dart';

import 'monthly_packge.dart';
import 'six_months_packge.dart';
import 'yearly_packge.dart';

class PackgesScreen extends StatefulWidget {
  const PackgesScreen({super.key});

  @override
  State<PackgesScreen> createState() => _PackgesScreenState();
}

class _PackgesScreenState extends State<PackgesScreen> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 231, 231, 231),
        appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.black),
            title: const Text('Packages', style: TextStyle(color: Colors.black)),
            centerTitle: true,
            backgroundColor: Colors.white),
        body: SingleChildScrollView(
          child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: screenSize.height * .02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const MonthlyPackge(),
                        ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          'image/dehliz/1.png',
                          width: screenSize.width * .5,
                        ),
                      ),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const SixMonthsPackge(),
                    ));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset('image/dehliz/6.png',
                        width: screenSize.width * .5),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const YearlyPackge(),
                    ));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset('image/dehliz/12.png',
                        width: screenSize.width * .5),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
