import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'select_date.dart';

class Temperature {
  String id;
  String imageUrl;
  String title;

  Temperature({required this.id, required this.imageUrl, required this.title});
}

class AddTemperature extends StatefulWidget {
  const AddTemperature({super.key});

  @override
  State<AddTemperature> createState() => _AddTemperatureState();
}

class _AddTemperatureState extends State<AddTemperature> {
  final List<Temperature> listTemp = [
    Temperature(id: '1', imageUrl: 'image/add/dry.png', title: 'Dry'),
    Temperature(id: '2', imageUrl: 'image/add/cold.png', title: 'Cold'),
    Temperature(id: '3', imageUrl: 'image/add/freezing.png', title: 'Freeze'),
  ];

  int selectedTemperatureIndex = -1;
  String selectedTempName = '';

  String get temp {
    if (selectedTemperatureIndex == 0) {
      selectedTempName = 'Dry';
      return selectedTempName;
    }
    if (selectedTemperatureIndex == 1) {
      selectedTempName = 'Cold';
      return selectedTempName;
    } else {
      return selectedTempName = 'Freeze';
    }
  }

  void toggleSelection(int index) {
    setState(() {
      if (selectedTemperatureIndex == index) {
        selectedTemperatureIndex = -1;
      } else {
        selectedTemperatureIndex = index;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    bool canContinue = selectedTemperatureIndex != -1;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Image.asset(
              'image/add/Temperature.png',
              width: 220,
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              'Choose the temperature',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black54,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              width: 200,
              child: Text(
                'Choose the right temperature to save your product',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black38, fontSize: 14),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Expanded(
              child: GridView.builder(
                physics: ScrollPhysics(parent: ScrollPhysics()),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.2,
                ),
                itemCount: listTemp.length,
                itemBuilder: (context, index) => Column(
                  children: [
                    InkWell(
                      onTap: () {
                        toggleSelection(index);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: selectedTemperatureIndex == index
                              ? Colors.yellow[700]
                              : Color.fromARGB(255, 248, 248, 248),
                        ),
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                        child: Image.asset(listTemp[index].imageUrl, width: 67),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        listTemp[index].title,
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              width: 300,
              height: 65,
              child: ElevatedButton(
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(0),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all(canContinue
                      ? Color.fromRGBO(38, 50, 56, 1)
                      : Color.fromARGB(255, 227, 227, 227)),
                ),
                onPressed: canContinue
                    ? () {
                        Get.off(SelectDate(
                          temp: temp,
                        ));
                      }
                    : null,
                child: Text(
                  'Continue',
                  style: TextStyle(
                    color: canContinue ? Colors.white : Colors.black54,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
