import 'package:flutter/material.dart';

import '../../../style/colors.dart';
import '../../../style/text_style.dart';
import '../../../utils/dimens.dart';

showMessage(
  context,
  String message,
) {
  var dimens = Dimens(context);
  var textStyle = AppStyle(context);
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).hideCurrentSnackBar();

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          /*         SvgPicture.asset(
            Resource.NEW_IC_INFO2,
            color: MyColor.red_color,
          ),
          Gap(dimens.paddingItems),*/
          Expanded(
            child: Text(
              message,
              style: textStyle.text_style.copyWith(
                color: MyColor.red_color,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: MyColor.red_line_color,
      elevation: dimens.height20,
    ),
  );
}
