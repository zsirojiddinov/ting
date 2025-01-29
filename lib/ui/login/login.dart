import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../style/colors.dart';
import '../../../../style/text_style.dart';
import '../../../../utils/dimens.dart';
import '../../bloc/login/login_bloc.dart';
import '../../bloc/login/login_event.dart';
import '../../bloc/login/login_state.dart';
import '../splash/splash_screen.dart';
import '../widget/buttons.dart';
import '../widget/custom_alert_dialog.dart';
import '../widget/new_input_widget.dart';
import '../widget/progressbar.dart';

// ignore: must_be_immutable
class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late Dimens dimens;
  late AppStyle textStyle;

  late LoginBloc bloc;

  @override
  void initState() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    super.initState();
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    dimens = Dimens(context);
    textStyle = AppStyle(context);
    return BlocProvider(
      create: (ctx) => LoginBloc(),
      child: Scaffold(
        //  appBar: _appbar(),
        body: Container(
          height: dimens.screenHeight,
          width: dimens.screenWidth,
          color: MyColor.bg_color,
          child: Stack(
            children: [
              ui(),
              loading(),
            ],
          ),
        ),
      ),
    );
  }

  loading() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (ctx, state) {
      return state is ProgressState ? progressBar(dimens) : Container();
    });
  }

  ui() {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (ctx, state) {
        if (state is ErrorState) {
          showMessage(ctx, state.failure.getLocalizedMessage(ctx));
        }
      },
      builder: (ctx, state) {
        bloc = BlocProvider.of<LoginBloc>(ctx);
        return SafeArea(
          child: Container(
            width: dimens.screenWidth,
            height: dimens.screenHeight,
            padding: EdgeInsets.symmetric(horizontal: dimens.paddingWidth),
            child: ListView(
              children: [
                Gap(dimens.screenWidth / 5),
                logo(dimens, textStyle),
                Gap(dimens.height20),
                NewInputWidget(
                  controller: bloc.loginController,
                  isMust: false,
                  title: "Login",
                  hint: "input login",
                ),
                Gap(dimens.height10),
                NewPasswordWidget(
                  controller: bloc.passwordController,
                  onClickChangeShow: () {
                    bloc.add(ChangePasswordShowEvent());
                  },
                  isShow: bloc.isShowPassword,
                  title: "Parol",
                  hint: "input password",
                ),
                Gap(dimens.height20),
                ArrowBtn(
                  text: "Kirish",
                  onClick: () {
                    bloc.add(SigninEvent());
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
