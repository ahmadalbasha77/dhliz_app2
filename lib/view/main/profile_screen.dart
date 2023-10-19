import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 231, 231, 231),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(
                      vertical: screenWidth * 0.1,
                      horizontal: screenWidth * 0.05,
                    ),
                    child: Text(
                      "Profile",
                      style: TextStyle(
                        fontSize: screenWidth * 0.06,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Stack(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage('image/home/pers1.jpg'),
                        radius: screenWidth * 0.17,
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.05,
                      vertical: screenWidth * 0.025,
                    ),
                    child: Text(
                      'Moahammed alqannas',
                      style: TextStyle(
                        fontSize: screenWidth * 0.06,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    width: screenWidth * 0.34,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black),
                      ),
                      onPressed: () {},
                      child: Text(
                        'Settings',
                        style: TextStyle(fontSize: screenWidth * 0.04),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(screenWidth * 0.04),
                ),
                width: screenWidth * 0.9,
                margin: EdgeInsets.symmetric(
                  vertical: screenWidth * 0.04,
                  horizontal: screenWidth * 0.05,
                ),
                padding: EdgeInsets.symmetric(vertical: screenWidth * 0.03),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.2,
                            vertical: screenWidth * 0.025,
                          ),
                          child: Text(
                            'Personal Information',
                            style: TextStyle(fontSize: screenWidth * 0.04),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.05,
                            vertical: screenWidth * 0.015,
                          ),
                          child: Text(
                            'Username: Mzmq',
                            style: TextStyle(fontSize: screenWidth * 0.035),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.05,
                            vertical: screenWidth * 0.025,
                          ),
                          child: Text(
                            'Phone: 0795411633',
                            style: TextStyle(fontSize: screenWidth * 0.035),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.05,
                            vertical: screenWidth * 0.015,
                          ),
                          child: Text(
                            'Email: ahmadalbasha22@gmail.com',
                            style: TextStyle(fontSize: screenWidth * 0.035),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.05,
                            vertical: screenWidth * 0.015,
                          ),
                          child: Text(
                            'Number of Warehouses: 2',
                            style: TextStyle(fontSize: screenWidth * 0.035),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            left: screenWidth * 0.05,
                            bottom: screenWidth * 0.015,
                            top: screenWidth * 0.015,
                          ),
                          child: Text(
                            'Business Name: Mzmq Company',
                            style: TextStyle(fontSize: screenWidth * 0.035),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            left: screenWidth * 0.05,
                            bottom: screenWidth * 0.01,
                            top: screenWidth * 0.015,
                          ),
                          child: Text(
                            'Subscription Ends: 20/10/2024',
                            style: TextStyle(fontSize: screenWidth * 0.035),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
