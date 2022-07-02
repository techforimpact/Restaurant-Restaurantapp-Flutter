import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/colors.dart';

class OrderDetailState {
  TextStyle? appBarTextStyle;
  TextStyle? restaurantNameTextStyle;
  TextStyle? otpTextStyle;
  TextStyle? productNameTextStyle;
  TextStyle? productPriceTextStyle;
  TextStyle? billValueTextStyle;
  TextStyle? billLabelTextStyle;
  TextStyle? grandTotalTextStyle;
  TextStyle? buttonTextStyle;
  OrderDetailState() {
    ///Initialize variables
    appBarTextStyle = const TextStyle(fontFamily: 'Poppins',
        fontSize: 28, fontWeight: FontWeight.w800, color: customTextGreyColor);
    restaurantNameTextStyle = const TextStyle(fontFamily: 'Poppins',
        fontSize: 28, fontWeight: FontWeight.w800, color: customTextGreyColor);
    otpTextStyle = const TextStyle(fontFamily: 'Poppins',
        fontSize: 18, fontWeight: FontWeight.w800, color: Colors.white);
    productNameTextStyle = const TextStyle(fontFamily: 'Poppins',
        fontSize: 17, fontWeight: FontWeight.w600, color: customTextGreyColor);
    productPriceTextStyle = const TextStyle(fontFamily: 'Poppins',
        fontSize: 15, fontWeight: FontWeight.w700, color: customTextGreyColor);
    billValueTextStyle = const TextStyle(fontFamily: 'Poppins',
        fontSize: 15, fontWeight: FontWeight.w700, color: customTextGreyColor);
    billLabelTextStyle = const TextStyle(fontFamily: 'Poppins',
        fontSize: 17, fontWeight: FontWeight.w900, color: customTextGreyColor);
    grandTotalTextStyle = const TextStyle(fontFamily: 'Poppins',
        fontSize: 25, fontWeight: FontWeight.w900, color: customThemeColor);
    buttonTextStyle = const TextStyle(fontFamily: 'Poppins',
        fontSize: 17, fontWeight: FontWeight.w900, color: Colors.white);
  }
}
