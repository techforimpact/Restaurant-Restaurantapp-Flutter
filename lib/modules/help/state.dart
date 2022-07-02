import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/colors.dart';

class HelpState {
  TextStyle? appBarTextStyle;
  TextStyle? contentTextStyle;
  HelpState() {
    ///Initialize variables
    appBarTextStyle = const TextStyle(fontFamily: 'Poppins',
        fontSize: 28, fontWeight: FontWeight.w800, color: customTextGreyColor);
    contentTextStyle = const TextStyle(fontFamily: 'Poppins',
        fontSize: 17, fontWeight: FontWeight.w700, color: customTextGreyColor);
  }
}
