import 'package:flutter/material.dart';
import 'login_screen.dart';

class FirstPageScreen extends StatefulWidget {
  const FirstPageScreen({super.key});

  @override
  State<FirstPageScreen> createState() => _FirstPageScreenState();
}

class _FirstPageScreenState extends State<FirstPageScreen> {
  @override
  Widget build(BuildContext context) {
    // Get the screen size
    final screenSize = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: screenSize.height * 0.1,
            ),
            Image.asset(
              "image/home/Artboard 14.png",
              width: screenSize.width * 0.8,
              height: screenSize.height * 0.2,
            ),
            SizedBox(
              height: screenSize.height * 0.16,
            ),
            Image.asset(
              "image/home/Artboard 10.png",
              width: screenSize.width * 0.45,
            ),
            SizedBox(
              height: screenSize.height * 0.03,
            ),
            Container(
              width: screenSize.width * 0.71,
              child: Text(
                "WM system that is easy to use and adapt by end users, for all that is easy to use and adapt by that is easy to use and adapt by",
                style:
                    TextStyle(color: Colors.black54, fontSize: 14, height: 1.3),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: screenSize.height * 0.13,
            ),
            Container(
              margin:
                  EdgeInsets.symmetric(horizontal: screenSize.width * 0.085),
              width: double.infinity,
              height: screenSize.height * 0.084,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(38, 50, 56, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                child: Text(
                  "GET STARTED",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
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
