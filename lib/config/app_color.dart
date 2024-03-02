import 'package:flutter/material.dart';
import 'package:get/get.dart';

class  AppColor {
  static Color selectColor(Color colorForLight, Color colorForDark) {
    return Get.isDarkMode ? colorForDark : colorForLight;
  }

  static const Color accentColor = Colors.black;
  static const MaterialColor primaryColor = MaterialColor(
    0xFF000000,
    <int, Color>{
      50: Color(0xFF000000),
      100: Color(0xFF000000),
      200: Color(0xFF000000),
      300: Color(0xFF000000),
      400: Color(0xFF000000),
      500: Color(0xFF000000),
      600: Color(0xFF000000),
      700: Color(0xFF000000),
      800: Color(0xFF000000),
      900: Color(0xFF000000),
    },
  );
  static const Color green = Color.fromRGBO(0, 119, 0, 1.0);
  static const Color blue = Color.fromRGBO(156, 180, 255, 1.0);
  static const Color gray = Color.fromRGBO(30, 30, 30, 1);
  static const Color red = Color.fromRGBO(255, 0, 0, 1.0);
  static const Color gray2 = Color.fromRGBO(149, 149, 149, 1.0);
  static const Color grayLight = Color.fromRGBO(236, 236, 236, 1);
  static const Color grayDark = Color(0xFF181818);
  static const Color grayLightTransparent = Color.fromRGBO(224, 224, 224, 0.7);
  static const Color chatReceived = Color(0xFFFFEFEE);
  static const Color colorIcon = Color(0xFF666666);
  static const Color colorWhiteTransparent = Color(0xFFfdfafa);

  static const Color textFieldBorderLight = Color(0xFF828282);
  static const Color textFieldBorderDark = Color(0xFFA4A4A4);

  static const Color textFieldLight = Color(0xFF828282);
  static const Color textFieldDark = Color(0xFFA4A4A4);
  static const Color darkGray =  Color(0xffefefef);
  static const Color docContentColor =  Color(0xffECF0F5);
  static const Color bgColor =  Color(0xffF9F9F9);
  static const Color darkBlue =  Color(0xFF08203a);

  //------------New Colors ---------

  static const Color dBtnColor = Color.fromRGBO(81,66,77,1.0) ;
  static const Color dTextColor= Color.fromRGBO(35,53,95,1) ;
  static const Color fillColorTextField = Color.fromRGBO(230,288,221,1) ;
  static const Color buttonColor = Color.fromRGBO(80, 46, 144, 1.0) ;
  static const Color buttonColor2 = Color.fromRGBO(233, 78, 36, 1.0) ;


}
