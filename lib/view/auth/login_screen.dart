import 'package:flutter/material.dart';

import '../../controllers/auth/sign_in_controller.dart';
import '../main_screen.dart';
import 'signup_screen.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


  final _controller = SignInController.to;



  @override
  Widget build(BuildContext context) {
    // Get the screen size
    final screenSize = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Form(
          key: _controller.keyForm,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: screenSize.height * 0.05,
                ),
                Image.asset(
                  "image/home/Artboard 15.png",
                  width: screenSize.width * 0.8,
                ),
                SizedBox(
                  height: screenSize.height * 0.05,
                ),
                Center(
                  child: Text(
                    "Login",
                    style: TextStyle(
                      fontSize: screenSize.width * 0.07,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(
                  height: screenSize.height * 0.025,
                ),
                SizedBox(
                  width: screenSize.width * 0.7,
                  child: Text(
                    "Enter your email and password to access the warehouse",
                    style: TextStyle(
                      fontSize: screenSize.width * 0.039,
                      color: Colors.black38,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: screenSize.height * 0.025,
                ),
                Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: screenSize.width * .07),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Your email';
                      }
                    },
                    controller: _controller.controllerUsername,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: screenSize.height * .027,
                            horizontal: screenSize.width * .03),
                        hintStyle: TextStyle(
                          color: Colors.black38,
                        ),
                        hintText: 'example@example.com',
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        filled: true,
                        fillColor: Color.fromRGBO(243, 242, 238, 1),
                        labelText: "email",
                        labelStyle: TextStyle(color: Colors.black45)),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: screenSize.width * .07,
                      vertical: screenSize.height * .02),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                    },
                    style: TextStyle(color: Colors.black87),
                    controller: _controller.controllerPassword,
                    obscureText: true,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: screenSize.height * .027,
                            horizontal: screenSize.width * .03),
                        hintStyle: TextStyle(color: Colors.black),
                        hintText: '**** ****',
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        filled: true,
                        fillColor: Color.fromRGBO(243, 242, 238, 1),
                        labelText: "password",
                        labelStyle: TextStyle(color: Colors.black45)),
                  ),
                ),
                SizedBox(
                  height: screenSize.height * 0.07,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account ?  ",
                      style: TextStyle(
                          color: Colors.black45,
                          fontSize: screenSize.width * .038),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignUpScreen(),
                          ),
                        );
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: screenSize.width * .04),
                      ),
                    ),
                  ],
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

                      _controller.signIn();
                      },
                    child: Text(
                      "Login",
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
