import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/colors.dart';

class ProfileState {
  TextStyle? updateButtonStyle;
  TextStyle? headingTextStyle;
  TextStyle? subHeadingTextStyle;
  TextStyle? nameTextStyle;
  TextStyle? detailTextStyle;
  TextStyle? tileTitleTextStyle;
  ProfileState() {
    ///Initialize variables
    updateButtonStyle = const TextStyle(fontFamily: 'Poppins',
        fontWeight: FontWeight.w900, fontSize: 17);
    headingTextStyle = const TextStyle(fontFamily: 'Poppins',
        fontSize: 34, fontWeight: FontWeight.w800, color: customThemeColor);
    subHeadingTextStyle = const TextStyle(fontFamily: 'Poppins',
        fontSize: 18, fontWeight: FontWeight.w700, color: customTextGreyColor);
    nameTextStyle = const TextStyle(fontFamily: 'Poppins',
        fontSize: 18, fontWeight: FontWeight.w900, color: customTextGreyColor);
    detailTextStyle = TextStyle(fontFamily: 'Poppins',
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: Colors.black.withOpacity(0.5));
    tileTitleTextStyle = const TextStyle(fontFamily: 'Poppins',
        fontSize: 18, fontWeight: FontWeight.w900, color: customTextGreyColor);
  }
}
