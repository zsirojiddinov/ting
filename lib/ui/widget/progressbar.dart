import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../style/colors.dart';
import '../../utils/dimens.dart';
import '../../utils/resource.dart';

progressBar(Dimens dimens) {
  return Container(
    width: dimens.screenWidth,
    height: dimens.screenHeight,
    color: MyColor.black.withOpacity(0.56),
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
      child: Center(
        child: Image.asset(
          Resource.PROGRESS_BAR,
          height: dimens.height10 * 10,
          width: dimens.height10 * 10,
        ),
      ),
    ),
  );
}
