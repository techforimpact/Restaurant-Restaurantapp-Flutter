import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/colors.dart';

class HomeState {
  TextStyle? drawerTitleTextStyle;
  TextStyle? homeHeadingTextStyle;
  TextStyle? homeSubHeadingTextStyle;
  TextStyle? listTileTitleTextStyle;
  TextStyle? listTileSubTitleTextStyle;
  TextStyle? nameTextStyle;
  TextStyle? priceTextStyle;
  TextStyle? otpTextStyle;
  HomeState() {
    ///Initialize variables
    drawerTitleTextStyle = const TextStyle(fontFamily: 'Poppins',
        fontWeight: FontWeight.w600, fontSize: 22, color: Colors.white);
    homeHeadingTextStyle = const TextStyle(fontFamily: 'Poppins',
        fontWeight: FontWeight.w800, fontSize: 34, color: customTextGreyColor);
    homeSubHeadingTextStyle = const TextStyle(fontFamily: 'Poppins',
        fontWeight: FontWeight.w700, fontSize: 17, color: customThemeColor);
    listTileTitleTextStyle = const TextStyle(fontFamily: 'Poppins',
        fontWeight: FontWeight.w700, fontSize: 18, color: customTextGreyColor);
    listTileSubTitleTextStyle = const TextStyle(fontFamily: 'Poppins',
        fontWeight: FontWeight.w700, fontSize: 13, color: customTextGreyColor);
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
