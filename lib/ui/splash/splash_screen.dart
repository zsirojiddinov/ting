import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/splash/splash_bloc.dart';
import '../../bloc/splash/splash_event.dart';
import '../../bloc/splash/splash_state.dart';
import '../../style/text_style.dart';
import '../../utils/dimens.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Dimens dimens;
  late AppStyle textStyle;

  @override
  Widget build(BuildContext context) {
    dimens = Dimens(context);
    textStyle = AppStyle(context);
    return BlocProvider<SplashBloc>(
      create: (context) =>
      SplashBloc()
        ..add(OnCheckEvent()),
      child: BlocConsumer<SplashBloc, SplashState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: ui(),
            ),
          );
        },
      ),
    );
  }

  ui() {
    return Container(
      width: dimens.screenWidth,
      height: dimens.screenHeight,
      padding: EdgeInsets.symmetric(
        horizontal: Dimens(context).width45,
      ),
      child: Center(
        child:logo(dimens, textStyle),
      ),
    );
  }
}

logo(Dimens dimens, AppStyle textStyle) {
  return Text(
    "ting",
    style: textStyle.text_style.copyWith(
      fontSize: dimens.screenWidth / 4,
    ),
    textAlign: TextAlign.center,
  );
}