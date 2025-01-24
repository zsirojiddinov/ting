import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'invoice_event.dart';
import 'invoice_state.dart';

class InvoiceBloc extends Bloc<InvoiceEvent, InvoiceState> {
  InvoiceBloc() : super(SuccessState()) {
    on<SettingsEvent>(settings);
  }

  FutureOr<void> settings(
      SettingsEvent event, Emitter<InvoiceState> emit) async {
    // Get.to(() => ProfilePage());
    return;
  }
}
