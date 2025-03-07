import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/dimens.dart';
import 'colors.dart';

class AppStyle {
  late Dimens dimens;

  AppStyle(BuildContext context) {
    dimens = Dimens(context);
  }

  TextStyle get titleStyle {
    return GoogleFonts.openSans(
      fontSize: dimens.font20,
      fontWeight: FontWeight.w700,
      color: MyColor.black,
      decoration: TextDecoration.none,
    );
  }

  TextStyle get text_style {
    return GoogleFonts.openSans(
      fontSize: dimens.font16,
      fontWeight: FontWeight.w400,
      color: MyColor.black,
      decoration: TextDecoration.none,
    );
  }

  TextStyle get text_style_bold {
    return GoogleFonts.openSans(
      fontSize: dimens.font16,
      fontWeight: FontWeight.w700,
      color: MyColor.black,
      decoration: TextDecoration.none,
    );
  }

  TextStyle get text_secondary_style {
    return GoogleFonts.openSans(
      fontSize: dimens.font14,
      color: MyColor.text_secondary_color,
      decoration: TextDecoration.none,
    );
  }

  TextStyle get hintStyle {
    return GoogleFonts.openSans(
      fontSize: dimens.font16,
      fontWeight: FontWeight.normal,
      color: MyColor.hint_color,
      decoration: TextDecoration.none,
    );
  }
}
