import 'package:flutter/cupertino.dart';

class Dimens {
  BuildContext ctx;
  late double screenHeight;
  late double screenWidth;

  Dimens(this.ctx) {
    screenHeight = MediaQuery.of(ctx).size.height;
    screenWidth = MediaQuery.of(ctx).size.width;
  }

  double get height10 {
    return 10 * screenHeight / 967;
  }

  double get height15 {
    return 15 * screenHeight / 967;
  }

  double get height20 {
    return 20 * screenHeight / 967;
  }

  double get height30 {
    return 30 * screenHeight / 967;
  }

  double get height45 {
    return 45 * screenHeight / 967;
  }

  double get width10 {
    return 10 * screenWidth / 393;
  }

  double get width15 {
    return 15 * screenWidth / 393;
  }

  double get width20 {
    return 20 * screenWidth / 393;
  }

  double get width30 {
    return 30 * screenWidth / 393;
  }

  double get paddingWidth {
    return width10 * 1.6;
  }

  double get paddingItems {
    return width10 * 0.8;
  }

  double get padding_decoration_height {
    return height10 * 0.8;
  }

  double get padding_decoration_width {
    return width10 * 1.2;
  }

  double get paddingHeight {
    return height15;
  }

  double get width45 {
    return 45 * screenWidth / 393;
  }

  double get font12 {
    return width10 * 1.2;
  }

  double get font14 {
    return width10 * 1.4;
  }

  double get font16 {
    return width20 * 1.6;
  }

  double get font18 {
    return width20 * 1.8;
  }

  double get font20 {
    return width20 * 2;
  }

  double get font24 {
    return width20 * 2.4;
  }

  double get font30 {
    return width20 * 3;
  }

  double get radius10 {
    return height10;
  }

  double get radius16 {
    return height10 * 1.6;
  }

  double get radius20 {
    return screenHeight / 42.2;
  }

  double get radius25 {
    return screenHeight / 33.8;
  }

  double get radius30 {
    return screenHeight / 28.13;
  }

  // icons size

  double get iconSize24 {
    return width20 * 2.4;
  }

  double get iconSize20 {
    return width20 * 2;
  }

  double get iconSize16 {
    return width20 * 1.6;
  }

  double get line_size {
    return height10 / 10;
  }
}
