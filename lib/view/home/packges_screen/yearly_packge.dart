import 'package:flutter/material.dart';

class YearlyPackge extends StatefulWidget {
  const YearlyPackge({super.key});

  @override
  State<YearlyPackge> createState() => _YearlyPackgeState();
}

class _YearlyPackgeState extends State<YearlyPackge> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 231, 231, 231),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text('Yearly Packge', style: TextStyle(color: Colors.black)),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin:
                    EdgeInsets.symmetric(vertical: screenSize.height * .015),
                padding: EdgeInsets.symmetric(
                    horizontal: screenSize.width * .05,
                    vertical: screenSize.height * .02),
                width: screenSize.width * .65,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset('image/dehliz/BASIC.png',
                        width: screenSize.width * .2),
                    Text('Basic package',
                        style: TextStyle(
                            fontSize: screenSize.width * .04,
                            fontWeight: FontWeight.w400)),
                    Container(
                        margin: EdgeInsets.symmetric(
                            vertical: screenSize.height * .01),
                        child: Text(
                          '12 Square meters',
                          style: TextStyle(
                              fontSize: screenSize.width * .043,
                              fontWeight: FontWeight.bold),
                        )),
                    Text('(6 - 7 shelves , 2 in 1m)',
                        style: TextStyle(
                            fontSize: screenSize.width * .024,
                            color: Colors.black54)),
                    Divider(
                      color: Colors.blue[900],
                    ),
                    Text('Properties',
                        style: TextStyle(
                            fontSize: screenSize.width * .035,
                            fontWeight: FontWeight.bold)),
                    Container(
                        margin: EdgeInsets.symmetric(
                            vertical: screenSize.height * .008),
                        child: Text(
                          '- Free ride small car size',
                          style: TextStyle(fontSize: screenSize.width * .032),
                        )),
                    Container(
                        margin: EdgeInsets.symmetric(
                            vertical: screenSize.height * .008),
                        child:
                            Text('- A person enters the information portal')),
                    SizedBox(
                      height: screenSize.height * .05,
                    ),
                    Text(
                      '721.6 SAR / month',
                      style: TextStyle(fontSize: screenSize.width * .046),
                    ),
                    Container(
                      width: screenSize.width * .4,
                      margin: EdgeInsets.symmetric(
                          vertical: screenSize.height * .012),
                      child: ElevatedButton(
                          style: ButtonStyle(
                              shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      side: BorderSide(
                                          color: Color.fromARGB(
                                              255, 42, 42, 63)))),
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.white)),
                          onPressed: () {},
                          child: Text(
                            'Choose plan',
                            style: TextStyle(
                                color: Color.fromARGB(255, 42, 42, 63)),
                          )),
                    )
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin:
                    EdgeInsets.symmetric(vertical: screenSize.height * .015),
                padding: EdgeInsets.symmetric(
                    horizontal: screenSize.width * .05,
                    vertical: screenSize.height * .02),
                width: screenSize.width * .65,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset('image/dehliz/PLUS.png',
                        width: screenSize.width * .2),
                    Text('Package Plus',
                        style: TextStyle(
                            fontSize: screenSize.width * .04,
                            fontWeight: FontWeight.w500)),
                    Container(
                        margin: EdgeInsets.symmetric(
                            vertical: screenSize.height * .01),
                        child: Text(
                          '20 Square meters',
                          style: TextStyle(
                              fontSize: screenSize.width * .043,
                              fontWeight: FontWeight.bold),
                        )),
                    Text('(10 - 11 shelves , 2 in 1m)',
                        style: TextStyle(
                            fontSize: screenSize.width * .024,
                            color: Colors.black54)),
                    Divider(
                      color: Colors.blue[900],
                    ),
                    Text('Properties',
                        style: TextStyle(
                            fontSize: screenSize.width * .035,
                            fontWeight: FontWeight.bold)),
                    Container(
                        margin: EdgeInsets.symmetric(
                            vertical: screenSize.height * .008),
                        child: Text(
                          '- Free ride small car size',
                          style: TextStyle(fontSize: screenSize.width * .032),
                        )),
                    Container(
                        margin: EdgeInsets.symmetric(
                            vertical: screenSize.height * .008),
                        child: Text(
                            '- Three people enter the information portal')),
                    SizedBox(
                      height: screenSize.height * .05,
                    ),
                    Text(
                      '1146.4 SAR / month',
                      style: TextStyle(fontSize: screenSize.width * .046),
                    ),
                    Container(
                      width: screenSize.width * .4,
                      margin: EdgeInsets.symmetric(
                          vertical: screenSize.height * .012),
                      child: ElevatedButton(
                          style: ButtonStyle(
                              shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      side: BorderSide(
                                          color: Color.fromARGB(
                                              255, 42, 42, 63)))),
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.white)),
                          onPressed: () {},
                          child: Text(
                            'Choose plan',
                            style: TextStyle(
                                color: Color.fromARGB(255, 42, 42, 63)),
                          )),
                    )
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin:
                    EdgeInsets.symmetric(vertical: screenSize.height * .015),
                padding: EdgeInsets.symmetric(
                    horizontal: screenSize.width * .05,
                    vertical: screenSize.height * .02),
                width: screenSize.width * .65,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset('image/dehliz/PRO.png',
                        width: screenSize.width * .2),
                    Text('Premium package',
                        style: TextStyle(
                            fontSize: screenSize.width * .04,
                            fontWeight: FontWeight.w500)),
                    Container(
                        margin: EdgeInsets.symmetric(
                            vertical: screenSize.height * .01),
                        child: Text(
                          '30 Square meters',
                          style: TextStyle(
                              fontSize: screenSize.width * .043,
                              fontWeight: FontWeight.bold),
                        )),
                    Text('(15 - 17 shelves , 2 in 1m)',
                        style: TextStyle(
                            fontSize: screenSize.width * .024,
                            color: Colors.black54)),
                    Divider(
                      color: Colors.blue[900],
                    ),
                    Text('Properties',
                        style: TextStyle(
                            fontSize: screenSize.width * .035,
                            fontWeight: FontWeight.bold)),
                    Container(
                        margin: EdgeInsets.symmetric(
                            vertical: screenSize.height * .008),
                        child: Text(
                          '- Free ride small car size',
                          style: TextStyle(fontSize: screenSize.width * .032),
                        )),
                    Container(
                        margin: EdgeInsets.symmetric(
                            vertical: screenSize.height * .008),
                        child:
                            Text('- Five people enter the information portal')),
                    SizedBox(
                      height: screenSize.height * .05,
                    ),
                    Text(
                      '1656.6 SAR / month',
                      style: TextStyle(fontSize: screenSize.width * .046),
                    ),
                    Container(
                      width: screenSize.width * .4,
                      margin: EdgeInsets.symmetric(
                          vertical: screenSize.height * .012),
                      child: ElevatedButton(
                          style: ButtonStyle(
                              shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      side: BorderSide(
                                          color: Color.fromARGB(
                                              255, 42, 42, 63)))),
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.white)),
                          onPressed: () {},
                          child: Text(
                            'Choose plan',
                            style: TextStyle(
                                color: Color.fromARGB(255, 42, 42, 63)),
                          )),
                    )
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin:
                    EdgeInsets.symmetric(vertical: screenSize.height * .015),
                padding: EdgeInsets.symmetric(
                    horizontal: screenSize.width * .05,
                    vertical: screenSize.height * .02),
                width: screenSize.width * .65,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset('image/dehliz/CUSTOM.png',
                        width: screenSize.width * .2),
                    Text('Custom package',
                        style: TextStyle(
                            fontSize: screenSize.width * .04,
                            fontWeight: FontWeight.w500)),
                    Container(
                        margin: EdgeInsets.symmetric(
                            vertical: screenSize.height * .01),
                        child: Text(
                          'More than 30 Square meters',
                          style: TextStyle(
                              fontSize: screenSize.width * .043,
                              fontWeight: FontWeight.bold),
                        )),
                    Text('',
                        style: TextStyle(
                            fontSize: screenSize.width * .024,
                            color: Colors.black54)),
                    Divider(
                      color: Colors.blue[900],
                    ),
                    Text('Properties',
                        style: TextStyle(
                            fontSize: screenSize.width * .035,
                            fontWeight: FontWeight.bold)),
                    Container(
                        margin: EdgeInsets.symmetric(
                            vertical: screenSize.height * .008),
                        child: Text(
                          '- Scheduled flights on request',
                          style: TextStyle(fontSize: screenSize.width * .032),
                        )),
                    Container(
                        margin: EdgeInsets.symmetric(
                            vertical: screenSize.height * .008),
                        child: Text(
                            '- Unlimited access to the information portal')),
                    SizedBox(
                      height: screenSize.height * .05,
                    ),
                    Text(
                      'Connect with us',
                      style: TextStyle(fontSize: screenSize.width * .046),
                    ),
                    Container(
                      width: screenSize.width * .4,
                      margin: EdgeInsets.symmetric(
                          vertical: screenSize.height * .012),
                      child: ElevatedButton(
                          style: ButtonStyle(
                              shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      side: BorderSide(
                                          color: Color.fromARGB(
                                              255, 42, 42, 63)))),
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.white)),
                          onPressed: () {},
                          child: Text(
                            'Connect with us',
                            style: TextStyle(
                                color: Color.fromARGB(255, 42, 42, 63)),
                          )),
                    )
                  ],
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
