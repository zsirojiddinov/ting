import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../ui/aggregate/aggregate_page.dart';
import '../../ui/invoice/invoice_page.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(SuccessState()) {
    on<SettingsEvent>(settings);
    on<AggregateHomeEvent>(aggregate);
    on<InvoiceHomeEvent>(invoice);
  }

  FutureOr<void> settings(SettingsEvent event, Emitter<HomeState> emit) async {
    // Get.to(() => ProfilePage());
    return;
  }

  FutureOr<void> aggregate(AggregateHomeEvent event, Emitter<HomeState> emit) {
    Get.to(() => AggregatePage());
    emit(SuccessState());
  }

  FutureOr<void> invoice(InvoiceHomeEvent event, Emitter<HomeState> emit) {
    Get.to(() => InvoicePage());
    emit(SuccessState());
  }
}
