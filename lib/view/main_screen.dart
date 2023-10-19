import 'package:flutter/material.dart';

import 'main/home_screen.dart';
import 'main/notification_screen.dart';
import 'main/profile_screen.dart';
import 'main/transaction_screen.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> _listBottomNavigationBar = [
    HomeScreen(),
    TransactionScreen(),
    NotificationScreen(),
    ProfileScreen(),

  ];

  int indexPage = 0;

  void getIndex(int index) {
    setState(() {
      indexPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 231, 231, 231),

        body: _listBottomNavigationBar[indexPage],
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.black,
          unselectedItemColor:Colors.black26 ,
          currentIndex: indexPage,
          elevation: 10,

          onTap: getIndex,

          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home, ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.compare_arrows, ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications, ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person, ),
              label: "",
            ),
          ],
        ),
      ),
    );
  }
}
