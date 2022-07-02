import 'package:flutter/material.dart';

class SplashState {
  TextStyle? splashTitleTextStyle;
  TextStyle? splashSubTitleTextStyle;
  SplashState() {
    ///Initialize variables
    splashTitleTextStyle = const TextStyle(fontFamily: 'Poppins',
        fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black);
    splashSubTitleTextStyle = const TextStyle(fontFamily: 'Poppins',
        fontWeight: FontWeight.normal, fontSize: 12, color: Colors.black);
  }
}
