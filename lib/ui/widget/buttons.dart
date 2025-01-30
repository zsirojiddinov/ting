import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import '../../../style/colors.dart';
import '../../../style/text_style.dart';
import '../../../utils/dimens.dart';
import '../../../utils/resource.dart';
import 'deceorations.dart';

// ignore: must_be_immutable
class ArrowBtn extends StatelessWidget {
  String text;
  Function onClick;
  late Dimens dimens;
  late AppStyle textStyle;
  late bool isActive;

  ArrowBtn({
    Key? key,
    required this.text,
    required this.onClick,
    this.isActive = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    dimens = Dimens(context);
    textStyle = AppStyle(context);
    return GestureDetector(
      onTap: () => onClick(),
      child: Container(
        decoration: newEditDecoration(
          dimens,
          isGreen: true,
        ),
        //     color: Colors.amber,
        padding: EdgeInsets.symmetric(vertical: dimens.height10),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: textStyle.text_style.copyWith(
                color: isActive ? MyColor.white : MyColor.text_secondary_color,
                fontWeight: FontWeight.w700,
              ),
            ),
            Gap(dimens.paddingWidth),
            Icon(
              Icons.arrow_forward,
              color: isActive ? MyColor.white : MyColor.text_secondary_color,
              size: dimens.iconSize20,
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class Btn extends StatelessWidget {
  String text;
  Function onClick;
  late Dimens dimens;
  late AppStyle textStyle;

  Btn({
    Key? key,
    required this.text,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    dimens = Dimens(context);
    textStyle = AppStyle(context);
    return GestureDetector(
      onTap: () => onClick(),
      child: Container(
        decoration: newEditDecoration(
          dimens,
          isGreen: true,
        ),
        padding: EdgeInsets.symmetric(
          vertical: dimens.height10,
          horizontal: dimens.padding_decoration_width,
        ),
        width: dimens.screenWidth,
        alignment: Alignment.center,
        child: Center(
          child: Row(
            children: [
              Expanded(
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: textStyle.text_style.copyWith(
                    color: MyColor.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class DownloadBtn extends StatelessWidget {
  String text;
  Function onClick;
  late Dimens dimens;
  late AppStyle textStyle;
  late IconData icons;
  late bool isRed;

  DownloadBtn({
    Key? key,
    required this.text,
    required this.onClick,
    this.icons = Icons.search_outlined,
    this.isRed = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    dimens = Dimens(context);
    textStyle = AppStyle(context);
    return GestureDetector(
      onTap: () => onClick(),
      child: Container(
        decoration: greenLightBtnDecoration(
          dimens,
          isRed: isRed,
        ),
        padding: EdgeInsets.symmetric(vertical: dimens.height10),
        width: dimens.screenWidth,
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icons,
              color: isRed ? MyColor.red_color : MyColor.green_color,
            ),
            Gap(dimens.width20),
            Text(
              text,
              style: textStyle.text_style.copyWith(
                color: isRed ? MyColor.red_color : MyColor.green_color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class WhiteBtn extends StatelessWidget {
  String text;
  Function onClick;
  late Dimens dimens;
  late AppStyle textStyle;

  WhiteBtn({
    Key? key,
    required this.text,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    dimens = Dimens(context);
    textStyle = AppStyle(context);
    return GestureDetector(
      onTap: () => onClick(),
      child: Container(
        decoration: newEditDecoration(dimens),
        padding: EdgeInsets.symmetric(vertical: dimens.height10),
        width: dimens.screenWidth,
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Text(
              text,
              style: textStyle.text_style,
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class BackBtn extends StatelessWidget {
  Function onClick;
  late Dimens dimens;
  late AppStyle textStyle;
  late bool isWhite;

  BackBtn({
    required this.onClick,
    this.isWhite = false,
  });

  @override
  Widget build(BuildContext context) {
    dimens = Dimens(context);
    textStyle = AppStyle(context);
    return GestureDetector(
      onTap: () => onClick(),
      child: Container(
        child: Row(
          children: [
            Icon(
              Icons.arrow_circle_left_outlined,
              color: isWhite ? Colors.white : MyColor.green_color,
            ),
            Gap(dimens.paddingItems),
            Text(
              "ortga",
              style: textStyle.text_style.copyWith(
                color: isWhite ? MyColor.white : MyColor.green_color,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class CancelBtn extends StatelessWidget {
  Function onClick;
  late Dimens dimens;
  late AppStyle textStyle;

  CancelBtn({required this.onClick});

  @override
  Widget build(BuildContext context) {
    dimens = Dimens(context);
    textStyle = AppStyle(context);
    return GestureDetector(
      onTap: () => onClick(),
      child: Container(
        child: Row(
          children: [
            Icon(
              Icons.close_outlined,
              color: MyColor.green_color,
            ),
            Gap(dimens.width20),
            Text(
              "bekor qilish",
              style: textStyle.text_style.copyWith(
                color: MyColor.green_color,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class DeleteItemBtn extends StatelessWidget {
  Function onClick;
  late Dimens dimens;
  late bool isArrow;
  late bool isRed;

  DeleteItemBtn({
    required this.onClick,
    this.isArrow = false,
    this.isRed = false,
  });

  @override
  Widget build(BuildContext context) {
    dimens = Dimens(context);
    return GestureDetector(
      onTap: () => onClick(),
      child: Container(
        padding: EdgeInsets.all(
          dimens.height10,
        ),
        decoration: circleDecoration(
          dimens,
          isRed: isRed,
        ),
        child: isArrow
            ? SvgPicture.asset(
                Resource.NEW_IC_SELECTOR,
              ) //Icon(Icons.keyboard_arrow_up_outlined)
            : Image.asset(
                Resource.NEW_IC_DELETE,
                color: isRed ? MyColor.white : null,
              ),
      ),
    );
  }
}

// ignore: must_be_immutable
class DeleteAccountBtn extends StatelessWidget {
  Function onClick;
  late Dimens dimens;
  late AppStyle textStyle;

  late bool isCallCenter;

  DeleteAccountBtn({
    Key? key,
    required this.onClick,
    this.isCallCenter = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    dimens = Dimens(context);
    textStyle = AppStyle(context);
    return GestureDetector(
      onTap: () {
        onClick();
      },
      child: Container(
        decoration: newEditRedDecoration(dimens),
        padding: EdgeInsets.symmetric(
          vertical: dimens.height10,
        ),
        child: Row(
          children: [
            Spacer(),
            isCallCenter
                ? SvgPicture.asset(
                    Resource.NEW_IC_CALL,
                    height: dimens.height20,
                    color: MyColor.white,
                  )
                : Icon(
                    Icons.delete_outline_rounded,
                    color: MyColor.white,
                  ),
            Gap(dimens.width20),
            Text(
              isCallCenter ? "appLanguage.sos_call" : "appLanguage.delete_account",
              style: textStyle.text_style.copyWith(
                color: MyColor.white,
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class BuyPolicyBtn extends StatelessWidget {
  Function onClick;
  late Dimens dimens;
  late AppStyle textStyle;

  BuyPolicyBtn({
    Key? key,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    dimens = Dimens(context);
    textStyle = AppStyle(context);
    return GestureDetector(
      onTap: () {
        onClick();
      },
      child: Container(
        decoration: newEditDecoration(dimens),
        padding: EdgeInsets.symmetric(
          vertical: dimens.height10 / 2,
        ),
        child: Row(
          children: [
            Spacer(),
            Text(
              "Оформить полис",
              style: textStyle.text_style,
            ),
            Gap(dimens.paddingWidth),
            Icon(
              Icons.arrow_forward,
              color: MyColor.text_secondary_color,
              size: dimens.iconSize16,
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
