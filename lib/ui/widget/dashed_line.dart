import 'package:flutter/material.dart';

import '../../utils/dimens.dart';
import '../../utils/resource.dart';

dashed_line(Dimens dimens, {bool isLittle = false}) {
  return Container(
    width: dimens.screenWidth,
    child: Image.asset(
      Resource.NEW_LINE_IMAGE,
      fit: BoxFit.fitWidth,
    ),
  );
}