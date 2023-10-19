import 'package:flutter/material.dart';

import '../main_screen.dart';


class CompleteSignupScreen extends StatefulWidget {
  const CompleteSignupScreen({Key? key}) : super(key: key);

  @override
  State<CompleteSignupScreen> createState() => _CompleteSignupScreenState();
}

class _CompleteSignupScreenState extends State<CompleteSignupScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    // Get the screen size
    final screenSize = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: screenSize.height * 0.05,
                ),
                Image.asset(
                  "image/home/Artboard 17.png",
                  width: screenSize.width * 0.8,
                ),
                SizedBox(
                  height: screenSize.height * 0.05,
                ),
                Center(
                  child: Text(
                    "Complete your information",
                    style: TextStyle(
                        fontSize: screenSize.width * 0.043,
                        color: Colors.black54),
                  ),
                ),
                SizedBox(
                  height: screenSize.height * 0.045,
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: screenSize.width * .07,
                      vertical: screenSize.height * .01),
                  child: TextFormField(
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: screenSize.height * .027,
                            horizontal: screenSize.width * .03),
                        hintStyle: TextStyle(
                          color: Colors.black38,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        filled: true,
                        fillColor: Color.fromRGBO(243, 242, 238, 1),
                        labelText: "Full Name",
                        labelStyle: TextStyle(color: Colors.black45)),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: screenSize.width * .07,
                    vertical: screenSize.height * .01,
                  ),
                  child: TextFormField(
                    style: TextStyle(color: Colors.black87),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: screenSize.height * .027,
                            horizontal: screenSize.width * .02),
                        hintStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        filled: true,
                        fillColor: Color.fromRGBO(243, 242, 238, 1),
                        labelText: "Username",
                        labelStyle: TextStyle(color: Colors.black45)),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: screenSize.width * .07,
                      vertical: screenSize.height * .01),
                  child: TextFormField(
                    style: TextStyle(color: Colors.black87),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: screenSize.height * .027,
                            horizontal: screenSize.width * .03),
                        hintStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        filled: true,
                        fillColor: Color.fromRGBO(243, 242, 238, 1),
                        labelText: "Your business name",
                        labelStyle: TextStyle(color: Colors.black45)),
                  ),
                ),
                SizedBox(
                  height: screenSize.height * 0.07,
                ),
                SizedBox(
                  height: screenSize.height * 0.013,
                ),
                Container(
                  width: double.infinity,
                  margin:
                      EdgeInsets.symmetric(horizontal: screenSize.width * .1),
                  height: screenSize.height * 0.079,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(38, 50, 56, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    onPressed: () async {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => MainScreen(),
                      ));
                    },
                    child: Text(
                      "Complete",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: screenSize.width * .05),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
