import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ting/model/invoice/invoice_model.dart';
import 'package:ting/repository/invoice_repository.dart';
import 'package:ting/utils/errors.dart';
import 'package:ting/utils/function.dart';

import '../../ui/product/product_page.dart';
import 'invoice_event.dart';
import 'invoice_state.dart';

class InvoiceBloc extends Bloc<InvoiceEvent, InvoiceState> {
  var list = <InvoiceModel>[];

  var startDate = DateTime(
    DateTime.now().year,
    DateTime.now().month - 1,
    DateTime.now().day,
  );

  var endDate = DateTime(
    DateTime.now().year,
    DateTime.now().month + 1,
    DateTime.now().day,
  );

  InvoiceBloc() : super(SuccessState()) {
    on<SettingsEvent>(settings);
    on<GetInvoiceDataEvent>(getData);
    on<OpenInvoiceEvent>(open);
    on<ChangeFilterEvent>(change);
    on<SelectDateEvent>(selectDate);
    on<GoEvent>(go);
  }

  String selectRadio = "";

  bool get isAll {
    return selectRadio == "";
  }

  bool get isNew {
    return selectRadio == "0";
  }

  bool get isProgress {
    return selectRadio == "1";
  }

  bool get isDone {
    return selectRadio == "2";
  }

  FutureOr<void> settings(
      SettingsEvent event, Emitter<InvoiceState> emit) async {
    // Get.to(() => ProfilePage());
    return;
  }

  FutureOr<void> go(GoEvent event, Emitter<InvoiceState> emit) async {
    emit(ProgressState());
    var repository = InvoiceRepository();
    var baseResponse = await repository.getInvoices(
      startDate: changeDateTime2(startDate),
      endDate: changeDateTime2(endDate),
      status: selectRadio,
    );
    if (baseResponse.code == 200) {
      list = baseResponse.response as List<InvoiceModel>;
      emit(SuccessState());
      return;
    }

    emit(ErrorState(failure: ServerFailure(message: baseResponse.message)));
  }

  FutureOr<void> selectDate(
      SelectDateEvent event, Emitter<InvoiceState> emit) async {
    var dateTime = await showDatePicker(
      context: event.context,
      initialEntryMode: DatePickerEntryMode.calendar,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: event.val == "1" ? endDate : DateTime(DateTime.now().year + 5),
      initialDate: event.val == "1" ? startDate : endDate,
    );
    if (event.val == "1") {
      startDate = dateTime!;
    } else {
      endDate = dateTime!;
    }
    emit(SuccessState());
  }

  FutureOr<void> change(
      ChangeFilterEvent event, Emitter<InvoiceState> emit) async {
    selectRadio = event.val;
    emit(SuccessState());
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
