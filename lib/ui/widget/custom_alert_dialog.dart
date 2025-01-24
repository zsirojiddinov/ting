import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../../../style/colors.dart';
import '../../../style/text_style.dart';
import '../../../utils/dimens.dart';
import '../../../utils/resource.dart';

void showMessage(
  context,
  String message,
) {
  var dimens = Dimens(context);
  var textStyle = AppStyle(context);
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          SvgPicture.asset(
            Resource.NEW_IC_INFO2,
            color: MyColor.red_color,
          ),
          Gap(dimens.paddingItems),
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
