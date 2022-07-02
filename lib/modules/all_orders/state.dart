import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/colors.dart';

class AllOrdersState {
  TextStyle? appBarTextStyle;
  TextStyle? nameTextStyle;
  TextStyle? priceTextStyle;
  TextStyle? otpTextStyle;
  AllOrdersState() {
    ///Initialize variables
    appBarTextStyle = const TextStyle(fontFamily: 'Poppins',
        fontSize: 28, fontWeight: FontWeight.w800, color: customTextGreyColor);
    nameTextStyle = const TextStyle(fontFamily: 'Poppins',
        fontSize: 18, fontWeight: FontWeight.w700, color: customTextGreyColor);
    priceTextStyle = TextStyle(fontFamily: 'Poppins',
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: customTextGreyColor.withOpacity(0.5));
    otpTextStyle = const TextStyle(fontFamily: 'Poppins',
        fontSize: 11, fontWeight: FontWeight.w600, color: customTextGreyColor);
  }
}
