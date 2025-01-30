import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../../../../../style/colors.dart';
import '../../../../../style/text_style.dart';
import '../../../../../utils/dimens.dart';
import '../../../../../utils/masked.dart';
import '../../../utils/resource.dart';
import 'deceorations.dart';

// ignore: must_be_immutable
class NewPhoneWidget extends StatelessWidget {
  TextEditingController controller;
  bool isActive;
  late Dimens dimens;
  late AppStyle textStyle;

  NewPhoneWidget({
    Key? key,
    required this.controller,
    this.isActive = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    dimens = Dimens(context);
    textStyle = AppStyle(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "phone_number",
          style: textStyle.text_secondary_style,
        ),
        Gap(dimens.height10 / 2),
        Container(
          decoration: newEditDecoration(dimens),
          padding: EdgeInsets.only(left: dimens.width20),
          //  height: dimens.height20,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "+998",
                style: textStyle.text_style,
              ),
              Gap(dimens.width10),
              Expanded(
                child: TextField(
                  enabled: isActive,
                  inputFormatters: [
                    Masked.maskPhone,
                  ],
                  style: textStyle.text_style.copyWith(
                    color: MyColor.black,
                  ),
                  controller: controller,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: Masked.hintPhone,
                    hintStyle: textStyle.hintStyle.copyWith(
                      fontSize: dimens.font16,
                    ),
                    alignLabelWithHint: false,
                    border: InputBorder.none,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class NewPasswordWidget extends StatelessWidget {
  TextEditingController controller;
  bool isShow;
  Function onClickChangeShow;
  String title;
  String hint;

  late Dimens dimens;
  late AppStyle textStyle;

  NewPasswordWidget({
    Key? key,
    required this.controller,
    required this.onClickChangeShow,
    required this.isShow,
    required this.title,
    required this.hint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    dimens = Dimens(context);
    textStyle = AppStyle(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: textStyle.text_secondary_style,
        ),
        Gap(dimens.height10 / 2),
        Container(
          decoration: BoxDecoration(
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
          ),
          padding: EdgeInsets.only(left: dimens.width20),
          //  height: dimens.height20,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: TextField(
                  obscureText: !isShow,
                  style: textStyle.text_style.copyWith(
                    color: MyColor.black,
                  ),
                  controller: controller,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: textStyle.hintStyle,
                    alignLabelWithHint: false,
                    border: InputBorder.none,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                ),
              ),
              Gap(dimens.width10),
              isShow
                  ? IconButton(
                      onPressed: () {
                        print(isShow);
                        onClickChangeShow();
                      },
                      icon: Icon(
                        Icons.panorama_fish_eye,
                        color: MyColor.text_secondary_color,
                      ),
                    )
                  : IconButton(
                      onPressed: () {
                        print(isShow);
                        onClickChangeShow();
                      },
                      icon: Icon(
                        Icons.remove_red_eye,
                        color: MyColor.text_secondary_color,
                      ),
                    ),
            ],
          ),
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class NewInputWidget extends StatelessWidget {
  TextEditingController controller;
  bool isMust;
  bool keyboardIsUpper;
  String title;
  String hint;

  late Dimens dimens;
  late AppStyle textStyle;

  NewInputWidget({
    Key? key,
    required this.controller,
    required this.isMust,
    required this.title,
    required this.hint,
    this.keyboardIsUpper = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    dimens = Dimens(context);
    textStyle = AppStyle(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              title,
              style: textStyle.text_secondary_style,
            ),
            isMust
                ? Icon(
                    Icons.star_border_purple500_rounded,
                    color: MyColor.red_color,
                    size: dimens.iconSize16,
                  )
                : Container(),
          ],
        ),
        Gap(dimens.height10 / 2),
        Container(
          decoration: BoxDecoration(
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
          ),
          padding: EdgeInsets.only(left: dimens.width20),
          //  height: dimens.height20,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: TextField(
                  style: textStyle.text_style.copyWith(
                    color: MyColor.black,
                  ),
                  controller: controller,
                  textCapitalization: keyboardIsUpper
                      ? TextCapitalization.characters
                      : TextCapitalization.none,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: textStyle.hintStyle,
                    alignLabelWithHint: false,
                    border: InputBorder.none,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class NewInputWidget2 extends StatelessWidget {
  TextEditingController controller;
  bool isActive;
  bool isNumber;
  String title;
  String hint;

  Function onChange;

  late Dimens dimens;
  late AppStyle textStyle;

  NewInputWidget2({
    Key? key,
    required this.controller,
    required this.isActive,
    required this.title,
    required this.hint,
    required this.onChange,
    this.isNumber = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    dimens = Dimens(context);
    textStyle = AppStyle(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: textStyle.text_secondary_style,
        ),
        Gap(dimens.height10 / 2),
        Container(
          decoration: BoxDecoration(
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
          ),
          padding: EdgeInsets.only(left: dimens.width20),
          //  height: dimens.height20,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: TextField(
                  style: textStyle.text_style.copyWith(
                    color: MyColor.black,
                  ),
                  controller: controller,
                  textCapitalization: TextCapitalization.none,
                  keyboardType:
                      isNumber ? TextInputType.number : TextInputType.text,
                  onChanged: (String val) {
                    onChange(val);
                  },
                  decoration: InputDecoration(
                    enabled: isActive,
                    hintText: hint,
                    hintStyle: textStyle.hintStyle,
                    alignLabelWithHint: false,
                    border: InputBorder.none,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class NewBirthdayWidget extends StatelessWidget {
  late Dimens dimens;
  late AppStyle textStyle;

  late String text;
  String? title = null;
  late Function onCLick;
  late double size;

  NewBirthdayWidget({
    required this.text,
    required this.onCLick,
    this.size = 0,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    dimens = Dimens(context);
    textStyle = AppStyle(context);
    return GestureDetector(
      onTap: () => onCLick(),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            title == null
                ? Container()
                : Column(
                    children: [
                      Text(
                        title!,
                        style: textStyle.text_secondary_style,
                      ),
                      Gap(dimens.height10 / 2),
                    ],
                  ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: dimens.paddingWidth,
                vertical: dimens.paddingHeight,
              ),
              decoration: newEditDecoration(dimens),
              child: Row(
                children: [
                  SvgPicture.asset(Resource.NEW_IC_CALENDAR),
                  Gap(dimens.paddingItems),
                  Expanded(
                    child: Text(
                      text,
                      style: textStyle.text_secondary_style.copyWith(
                        fontSize: size == 0 ? dimens.font20 : size,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.calendar_month_outlined,
                    color: MyColor.text_secondary_color,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class NewBirthdayWidget2 extends StatelessWidget {
  TextEditingController controller;
  bool isActive;
  late Dimens dimens;
  late AppStyle textStyle;
  late String text;
  String? title = null;

  NewBirthdayWidget2({
    Key? key,
    required this.controller,
    required this.text,
    this.isActive = true,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    dimens = Dimens(context);
    textStyle = AppStyle(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title == null
            ? Container()
            : Row(
                children: [
                  Text(
                    "birthday",
                    style: textStyle.text_secondary_style,
                  ),
                  Icon(
                    Icons.star_border_purple500_rounded,
                    color: MyColor.red_color,
                    size: dimens.iconSize16,
                  ),
                ],
              ),
        Gap(dimens.height10 / 2),
        Container(
          decoration: isActive
              ? newEditDecoration(dimens)
              : decorationWithStatus(dimens),
          padding: EdgeInsets.only(left: dimens.width20),
          //  height: dimens.height20,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(Resource.NEW_IC_CALENDAR),
              Gap(dimens.width10),
              Expanded(
                child: TextField(
                  enabled: isActive,
                  inputFormatters: [
                    Masked.maskBirthday,
                  ],
                  style: textStyle.text_style.copyWith(
                    color: MyColor.black,
                  ),
                  controller: controller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: Masked.hintBirthday,
                    hintStyle: textStyle.hintStyle,
                    alignLabelWithHint: false,
                    border: InputBorder.none,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                ),
              ),
            ],
          ),
        ),
        /* Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: MyColor.line_color,
              width: dimens.width10 / 5,
            ),
            borderRadius: BorderRadius.circular(
              dimens.height10,
            ),
          ),
          child: Container(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(left: dimens.width20),
                  child: Center(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "+998",
                          style: textStyle.text_style,
                        ),
                        Gap(dimens.width10),
                        Expanded(
                          child: TextField(
                            inputFormatters: [
                              Masked.maskPhone,
                            ],
                            style: textStyle.textStyle.copyWith(
                              color: MyColor.black,
                            ),
                            controller: controller,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              hintText: Masked.hintPhone,
                              hintStyle: textStyle.hintStyle,
                              alignLabelWithHint: true,
                              border: InputBorder.none,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),*/
      ],
    );
  }
}
