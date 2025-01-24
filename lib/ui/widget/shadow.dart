import 'package:flutter/material.dart';

import '../../../style/colors.dart';
import '../../utils/dimens.dart';

myShadow(Dimens dimens) {
  return [
    BoxShadow(
      offset: Offset(0, 0),
      blurRadius: dimens.line_size,
      color: MyColor.shadow_color,
    ),
  ];
}

greenShadow(Dimens dimens) {
  return [
    BoxShadow(
      offset: Offset(0, 0),
      blurRadius: dimens.line_size,
      color: MyColor.green_color,
    ),
  ];
}
