import 'package:flutter/material.dart';

class EditProductState {
  TextStyle? labelTextStyle;
  TextStyle? buttonTextStyle;
  EditProductState() {
    ///Initialize variables
    labelTextStyle = TextStyle(fontFamily: 'Poppins',
        fontSize: 15,
        fontWeight: FontWeight.w900,
        color: Colors.black.withOpacity(0.4));
    buttonTextStyle = const TextStyle(fontFamily: 'Poppins',
        fontSize: 17, fontWeight: FontWeight.w900, color: Colors.white);
  }
}
