import 'package:flutter/material.dart';
import 'package:ting/ui/widget/shadow.dart';

import '../../../style/colors.dart';
import '../../../utils/dimens.dart';

newEditDecoration(
  Dimens dimens, {
  bool withLine = true,
  bool isGreen = false,
  bool isShadow = true,
}) {
  return BoxDecoration(
    color: isGreen ? MyColor.green_color : MyColor.white,
    borderRadius: BorderRadius.circular(dimens.radius16),
    border: isGreen
        ? null
        : withLine
            ? Border.all(
                color: MyColor.line_color,
                width: dimens.line_size,
              )
            : null,
    boxShadow: isShadow ? myShadow(dimens) : null,
  );
}

newDecoration(Dimens dimens) {
  return BoxDecoration(
    color: MyColor.white,
    borderRadius: BorderRadius.circular(dimens.height10),
    border: Border.all(
      color: MyColor.line_color,
      width: dimens.width10 / 17,
    ),
    boxShadow: [
      BoxShadow(
        offset: Offset(0, 1),
        blurRadius: dimens.height10 / 2,
        color: MyColor.greys,
      ),
    ],
  );
}


policy_category_select_decoration(Dimens dimens) {
  return BoxDecoration(
    color: MyColor.white,
    borderRadius: BorderRadius.circular(dimens.height20),
    border: Border.all(
      color: MyColor.white,
      width: dimens.line_size,
    ),
    //   boxShadow: myShadow(dimens),
  );
}

newEditRedDecoration(Dimens dimens) {
  return BoxDecoration(
    color: MyColor.red_color,
    borderRadius: BorderRadius.circular(dimens.height10),
    /*   border: Border.all(
      color: MyColor.line_color,
      width: dimens.width10 / 20,
    ),*/
    boxShadow: myShadow(dimens),
  );
}

colorDecoration(
  Dimens dimens, {
  bool isRed = true,
  bool isBlue = false,
}) {
  return BoxDecoration(
    color: isBlue ? MyColor.bottom_blue_color : MyColor.red_color,
    borderRadius: BorderRadius.circular(dimens.height10),
    /*   border: Border.all(
      color: MyColor.line_color,
      width: dimens.width10 / 20,
    ),*/
    // boxShadow: myShadow(dimens),
  );
}

redDecoration(Dimens dimens) {
  return BoxDecoration(
    color: MyColor.red_light_color,
    borderRadius: BorderRadius.circular(dimens.height45 / 2),
    border: Border.all(
      color: MyColor.red_line_color,
      width: dimens.line_size,
    ),
    boxShadow: myShadow(dimens),
  );
}

greenLightBtnDecoration(
  Dimens dimens, {
  bool isBlue = false,
  bool isRed = false,
  bool isBlack = false,
}) {
  return BoxDecoration(
    color: isBlue
        ? MyColor.blue_light_color
        : isRed
            ? MyColor.red_light_color
            : isBlack
                ? MyColor.white
                : MyColor.green_light_color,
    borderRadius: BorderRadius.circular(dimens.height10),
    border: Border.all(
      color: isBlue
          ? MyColor.blue_line_color
          : isRed
              ? MyColor.red_line_color
              : isBlack
                  ? MyColor.black_light_color
                  : MyColor.green_line_color,
      width: dimens.line_size,
    ),
    //boxShadow: myShadow(dimens),
  );
}

selectServiceDecoration(
  Dimens dimens, {
  bool isSelect = false,
}) {
  return BoxDecoration(
    color: isSelect ? MyColor.white : MyColor.red_light_color,
    borderRadius: BorderRadius.circular(dimens.radius16),
    border: Border.all(
      color: isSelect ? MyColor.green_color : MyColor.red_line_color,
      width: dimens.line_size,
    ),
    boxShadow: isSelect ? greenShadow(dimens) : null,
  );
}

selectCompanyDecoration(
    Dimens dimens, {
      bool isSelect = false,
    }) {
  return BoxDecoration(
    color:  MyColor.white,
    borderRadius: BorderRadius.circular(dimens.radius16),
    border: Border.all(
      color: isSelect ? MyColor.green_color : MyColor.white,
      width: dimens.line_size,
    ),
    boxShadow: isSelect ? greenShadow(dimens) : myShadow(dimens),
  );
}

newEditDecorationNotActive(
  Dimens dimens, {
  bool withLine = true,
}) {
  return BoxDecoration(
    color: MyColor.inactive_bg_color,
    borderRadius: BorderRadius.circular(dimens.radius16),
    border: withLine
        ? Border.all(
            color: MyColor.inactive_line_color,
            width: dimens.line_size,
          )
        : null,
  );
}

circleDecoration(Dimens dimens, {bool isRed = false}) {
  return BoxDecoration(
    color: isRed ? MyColor.red_color : MyColor.white,
    border: Border.all(
      color: isRed ? MyColor.red_color : MyColor.line_color,
      width: dimens.line_size,
    ),
    boxShadow: myShadow(dimens),
    shape: BoxShape.circle,
  );
}

circleDecorationWithoutShadow(
  Dimens dimens, {
  bool isRed = false,
  bool isBlue = false,
  bool isGreen = false,
  bool isOrange = false,
}) {
  return BoxDecoration(
    color: isRed
        ? MyColor.red_light_color
        : isBlue
            ? MyColor.blue_light_color
            : isGreen
                ? MyColor.green_light_color
                : isOrange
                    ? MyColor.orange_light_color
                    : MyColor.white,
    border: Border.all(
      color: isRed
          ? MyColor.red_line_color
          : isBlue
              ? MyColor.blue_line_color
              : isGreen
                  ? MyColor.green_line_color
                  : isOrange
                      ? MyColor.orange_line_color
                      : MyColor.line_color,
      width: dimens.line_size,
    ),
    shape: BoxShape.circle,
  );
}

gowNumberDecoration(Dimens dimens, bool isMiddle) {
  return BoxDecoration(
    color: MyColor.white,
    borderRadius:
        BorderRadius.circular(isMiddle ? dimens.radius16 / 2 : dimens.radius16),
    border: Border.all(
      color: MyColor.black,
      width: dimens.line_size * 2,
    ),
    boxShadow: myShadow(dimens),
  );
}

pinDecoration(Dimens dimens) {
  return BoxDecoration(
    color: MyColor.whiteTransparent70,
    borderRadius: BorderRadius.circular(dimens.radius10),
    border: Border.all(
      color: MyColor.greenPro,
      width: dimens.line_size,
    ),
  );
}

buttonDecoration(Dimens dimens) {
  return BoxDecoration(
    color: MyColor.greenPro,
    borderRadius: BorderRadius.circular(dimens.radius10 / 2),
    //  border: Border.all(color: MyColor.mainColor),
  );
}

BoxDecoration bottomShetDecoration(
  Dimens dimens, {
  bool isWhite = true,
}) {
  return BoxDecoration(
    color: isWhite ? MyColor.white : MyColor.bg_color,
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(dimens.radius16),
      topRight: Radius.circular(dimens.radius16),
    ),
  );
}


BoxDecoration homeDecoration2(Color color, Dimens dimens) {
  return BoxDecoration(
    color: color,
    borderRadius: BorderRadius.only(
      topRight: Radius.circular(dimens.radius16),
      topLeft: Radius.circular(dimens.radius16),
    ),
  );
}

BoxDecoration homeDecoration5(Color color,
    Dimens dimens, {
      double radius = -1,
}) {
  return BoxDecoration(
    color: color,
    borderRadius: BorderRadius.all(
      Radius.circular(radius == -1 ? dimens.radius10 : radius),
    ),
  );
}