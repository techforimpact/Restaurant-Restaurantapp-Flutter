import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class AllProductsState {
  TextStyle? appBarTextStyle;
  TextStyle? nameTextStyle;
  TextStyle? priceTextStyle;
  AllProductsState() {
    ///Initialize variables
    appBarTextStyle = const TextStyle(fontFamily: 'Poppins',
        fontSize: 28, fontWeight: FontWeight.w800, color: customTextGreyColor);
    nameTextStyle = const TextStyle(fontFamily: 'Poppins',
        fontSize: 18, fontWeight: FontWeight.w700, color: customTextGreyColor);
    priceTextStyle = TextStyle(fontFamily: 'Poppins',
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: customTextGreyColor.withOpacity(0.5));
  }
}
