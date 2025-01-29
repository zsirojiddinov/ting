import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ting/model/invoice/invoice_model.dart';
import 'package:ting/repository/invoice_repository.dart';
import 'package:ting/utils/errors.dart';

import '../../ui/product/product_page.dart';
import 'invoice_event.dart';
import 'invoice_state.dart';

class InvoiceBloc extends Bloc<InvoiceEvent, InvoiceState> {
  var list = <InvoiceModel>[];

  InvoiceBloc() : super(SuccessState()) {
    on<SettingsEvent>(settings);
    on<GetInvoiceDataEvent>(getData);
    on<OpenInvoiceEvent>(open);
  }

  FutureOr<void> settings(
      SettingsEvent event, Emitter<InvoiceState> emit) async {
    // Get.to(() => ProfilePage());
    return;
  }

  FutureOr<void> open(
      OpenInvoiceEvent event, Emitter<InvoiceState> emit) async {
    await Get.to(() => ProductPage(model: event.model));
    emit(ProgressState());
    var repository = InvoiceRepository();
    var baseResponse = await repository.getInvoices();
    if (baseResponse.code == 200) {
      list = baseResponse.response as List<InvoiceModel>;
      emit(SuccessState());
      return;
    }

    emit(ErrorState(failure: ServerFailure(message: baseResponse.message)));
  }

  FutureOr<void> getData(
      GetInvoiceDataEvent event, Emitter<InvoiceState> emit) async {
    emit(ProgressState());
    var repository = InvoiceRepository();
    var baseResponse = await repository.getInvoices();
    if (baseResponse.code == 200) {
      list = baseResponse.response as List<InvoiceModel>;
      emit(SuccessState());
      return;
    }

    emit(ErrorState(failure: ServerFailure(message: baseResponse.message)));
  }
}
