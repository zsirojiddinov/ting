import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ting/services/preference_service.dart';
import 'package:ting/ui/login/login.dart';

import '../../ui/aggregate/aggregate_page.dart';
import '../../ui/invoice/invoice_page.dart';
import '../../ui/search/search_page.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(SuccessState()) {
    on<SettingsEvent>(settings);
    on<AggregateHomeEvent>(aggregate);
    on<InvoiceHomeEvent>(invoice);
    on<SearchEvent>(search);
    on<LogoutEvent>(logout);
  }

  FutureOr<void> settings(SettingsEvent event, Emitter<HomeState> emit) async {
    // Get.to(() => ProfilePage());
    return;
  }

  FutureOr<void> logout(LogoutEvent event, Emitter<HomeState> emit) async {
    PreferenceService().logout();
    emit(SuccessState());
    Get.offAll(LoginPage());
  }

  FutureOr<void> aggregate(AggregateHomeEvent event, Emitter<HomeState> emit) {
    Get.to(() => AggregatePage());
    emit(SuccessState());
  }

  FutureOr<void> invoice(InvoiceHomeEvent event, Emitter<HomeState> emit) {
    Get.to(() => InvoicePage());
    emit(SuccessState());
  }

  FutureOr<void> search(SearchEvent event, Emitter<HomeState> emit) {
    Get.to(() => SearchPage());
    emit(SuccessState());
  }
}
