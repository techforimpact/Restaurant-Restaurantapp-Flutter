import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/colors.dart';

class PrivacyPolicyState {
  TextStyle? appBarTextStyle;
  TextStyle? titleTextStyle;
  PrivacyPolicyState() {
    ///Initialize variables
    appBarTextStyle = const TextStyle(fontFamily: 'Poppins',
        fontSize: 28, fontWeight: FontWeight.w800, color: customTextGreyColor);
    titleTextStyle = const TextStyle(fontFamily: 'Poppins',
        fontSize: 14, fontWeight: FontWeight.w700, color: customTextGreyColor);
  }
}
