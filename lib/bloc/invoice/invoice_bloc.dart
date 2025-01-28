import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ting/repository/invoice_repository.dart';

import 'invoice_event.dart';
import 'invoice_state.dart';

class InvoiceBloc extends Bloc<InvoiceEvent, InvoiceState> {
  InvoiceBloc() : super(SuccessState()) {
    on<SettingsEvent>(settings);
    on<GetInvoiceDataEvent>(getData);
  }

  FutureOr<void> settings(
      SettingsEvent event, Emitter<InvoiceState> emit) async {
    // Get.to(() => ProfilePage());
    return;
  }

  FutureOr<void> getData(
      GetInvoiceDataEvent event, Emitter<InvoiceState> emit) async {
    emit(ProgressState());
    var repository = InvoiceRepository();
    var baseResponse = await repository.getInvoices();

    emit(SuccessState());
  }
}
