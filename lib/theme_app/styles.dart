import 'dart:ui';
import 'package:flutter/material.dart';

String nameFont = 'FontCairo';
String fontRoboto = 'FontRoboto';

class Styles {


  static ThemeData themeData(isDarkTheme,BuildContext context) {
    return ThemeData(
      fontFamily: "SansArabicLight",
      primaryColor: const Color(0xff349A37),
      shadowColor: const Color(0xff312E2E).withOpacity(0.16),

      textTheme: const TextTheme(


      ) ,



    );

  }


}