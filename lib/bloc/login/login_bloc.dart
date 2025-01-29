import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ting/utils/errors.dart';

import '../../../repository/login_repository.dart';
import '../../model/auth/login_model.dart';
import '../../services/preference_service.dart';
import '../../ui/home/home_page.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  var loginController = TextEditingController();
  var passwordController = TextEditingController();

  bool isShowPassword = true;

  LoginBloc() : super(SuccessState()) {
    on<SigninEvent>(login);
    on<ChangePasswordShowEvent>(change);
  }

  FutureOr<void> login(SigninEvent event, Emitter<LoginState> emit) async {
/*    Get.offAll(HomePage());
    return;*/

    var login = loginController.text.toString();
    var password = passwordController.text.toString();

    if (login.length < 5) {
      emit(ErrorState(failure: InputLoginFailure()));
      return;
    }

    if (password.isEmpty) {
      emit(ErrorState(failure: InputPasswordFailure()));
      return;
    }

    emit(ProgressState());

    var loginRepository = LoginRepository();

    var baseModel = await loginRepository.login(
      login,
      password,
    );
    if (baseModel.code == 200) {
      var model = baseModel.response as LoginModel;
      emit(SuccessState());
      PreferenceService().setToken(model.access_token!);
      PreferenceService().setFullName(model.full_name!);
      PreferenceService().setPassword(password);
      PreferenceService().setLogin(login);
      PreferenceService().setRoles(model.roles!);
      loginController.text = "";
      passwordController.text = "";
      Get.offAll(HomePage());
      return;
    }
    var message = baseModel.message;

    emit(
      ErrorState(
        failure: ServerFailure(message: message),
      ),
    );
  }

  FutureOr<void> change(
      ChangePasswordShowEvent event, Emitter<LoginState> emit) {
    isShowPassword = !isShowPassword;
    emit(SuccessState());
  }
}
