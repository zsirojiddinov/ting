import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ting/services/preference_service.dart';

import '../../ui/home/home_page.dart';
import '../../ui/login/login.dart';
import 'splash_event.dart';
import 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SuccessState()) {
    on<OnCheckEvent>(onCheck);
  }

  onCheck(OnCheckEvent event, Emitter<SplashState> emit) async {
    await Future.delayed(Duration(seconds: 2));

    var service = PreferenceService();
    String token = service.getToken();
    print("object");
    if (token == "") {
      Get.offAll(() => LoginPage());
      return;
    }
    Get.offAll(() => HomePage());

    return;
  }
}
