import 'package:flutter/material.dart';

import 'colors.dart';

lightTheme() => ThemeData().copyWith(
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: <TargetPlatform, PageTransitionsBuilder>{
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        },
      ),
      primaryColor: customThemeColor,
      scaffoldBackgroundColor: const Color(0xffF5F5F8),
      textTheme: const TextTheme(
        bodyText1: TextStyle(color: Colors.black),
        bodyText2: TextStyle(color: Colors.black),
        button: TextStyle(color: Colors.black),
        subtitle1: TextStyle(color: Colors.black),
        subtitle2: TextStyle(color: Colors.black),
        headline1: TextStyle(color: Colors.black),
        headline2: TextStyle(color: Colors.black),
        headline3: TextStyle(color: Colors.black),
        headline4: TextStyle(color: Colors.black),
        headline5: TextStyle(color: Colors.black),
        headline6: TextStyle(color: Colors.black),
        caption: TextStyle(color: Colors.black),
      ),
    );
