import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ting/model/aggregate/status_model.dart';
import 'package:ting/model/aggregate/util_aggregate_response.dart';
import 'package:ting/model/aggregate/utilization_aggregation_request.dart';
import 'package:ting/model/base_model.dart';
import 'package:ting/utils/constanta.dart';
import 'package:ting/utils/errors.dart';

import '../../model/aggregate/cis_model.dart';
import '../../repository/cis_repository.dart';
import '../product/product_bloc.dart';
import 'aggregate_event.dart';
import 'aggregate_state.dart';

class AggregateBloc extends Bloc<AggregateEvent, AggregateState> {
  bool get isHasGroupData {
    return groupModel.code != "";
  }

  String get showText {
    if (!isHasGroupData) {
      return "📦 Пожалуйста, отсканируйте групповую упаковку.";
    }

    if (cisFullLenght != groupModel.packageCount) {
      return "Отсканируйте код маркировки";
    }

    return "";
  }

  int get cisFullLenght {
    return cisList.length;
  }

  var groupModel = CisModel();
  var cisList = <CisModel>[];

  var utilAggr = UtilAggregateResponse(
    utilStatus: StatusModel(),
    aggStatus: StatusModel(),
  );

  AggregateBloc() : super(SuccessState()) {
    on<SettingsEvent>(settings);
    on<AddBarcodeEvent>(addEvent);
    on<CheckingUtillAggregateEvent>(checkingUtilAggregate);
    on<SendUtilizationEvent>(sendUtilization);
    on<TickEvent>(tick); // TickEvent uchun handler qo'shildi
  }

  FutureOr<void> settings(
      SettingsEvent event, Emitter<AggregateState> emit) async {

  }

  sendUtilization(
      SendUtilizationEvent event, Emitter<AggregateState> emit) async {
    emit(ProgressState());
    var baseSend = await send();
    if (baseSend.code == 200) {
      utilAggr = baseSend.response as UtilAggregateResponse;
      emit(SuccessState());
      add(CheckingUtillAggregateEvent());
      return;
    }
    await playMusic();
    emit(ErrorState(failure: ServerFailure(message: baseSend.message)));
    return;
  }

  String newCode = "";

  addEvent(AddBarcodeEvent event, Emitter<AggregateState> emit) async {
    if (newCode != "") {
      return;
    }
    newCode = event.data.barcodeData;

    // check group
    if (groupModel.code == "") {
      emit(ProgressState());
      BaseModel baseModel = await checkStatus(event.data.barcodeData);
      newCode = "";

      if (baseModel.code != 200) {
        await playMusic();
        emit(ErrorState(failure: ServerFailure(message: baseModel.message!)));
        return;
      }
      var cisModel = baseModel.response as CisModel;
      if (cisModel.packageType == IConstanta.GROUP) {
        groupModel = cisModel;
        groupModel.code = event.data.barcodeData;
        emit(SuccessState());
        //   await createCisList();
        //    emit(SuccessState());
        return;
      } else {
        await playMusic();
        emit(ErrorState(failure: NotGroupCodeFailure()));
        return;
      }
    }

    // check cis

    if (cisList.length == groupModel.packageCount) {
      await playMusic();
      emit(ErrorState(
          failure: ServerFailure(message: "Сканер QR-кода недоступен.")));
      return;
    }

    var isUnical = isUnitUnical(event.data.barcodeData);
    if (!isUnical) {
      newCode = "";
      emit(ErrorState(failure: ServerFailure(message: "Этот код маркировки был отсканирован")));
      return;
    }

    emit(ProgressState());
    BaseModel baseModel = await checkStatus(event.data.barcodeData);
    newCode = "";

    if (baseModel.code != 200) {
      await playMusic();
      emit(ErrorState(failure: ServerFailure(message: baseModel.message!)));
      return;
    }

    var cisModel = baseModel.response as CisModel;

    if (cisModel.packageType == IConstanta.GROUP) {
      await playMusic();
      emit(ErrorState(failure: NotUnitCodeFailure()));
      return;
    }

    if (!isUnitUnical(event.data.barcodeData)) {
      await playMusic();
      emit(ErrorState(failure: ServerFailure(message: "Этот код маркировки был отсканирован")));
      return;
    }

    cisModel.code = event.data.barcodeData;
    cisList.add(cisModel);
    emit(SuccessState());

    for (var item in cisList) {
      print(json.encode(item.toJson()));
    }
    if (cisList.length == groupModel.packageCount) {
      emit(ProgressState());
      var baseSend = await send();
      if (baseSend.code == 200) {
        utilAggr = baseSend.response as UtilAggregateResponse;
        add(CheckingUtillAggregateEvent());
        emit(SuccessState());
        return;
      }
      emit(ErrorState(failure: ServerFailure(message: baseSend.message)));
      return;
    }
  }

  bool get idFullCisList {
    return cisList.length == groupModel.packageCount;
  }

  checkStatus(String barcode) async {
    var repository = CisRepository();
    print("listen checkStatus $barcode");
    var baseModel = await repository.cisStatus(barcode);
    return baseModel;
  }

  bool isUnitUnical(String code) {
    for (var item in cisList) {
      if (item.code == code) {
        return false;
      }
    }
    return true;
  }

  Future<BaseModel> send() async {
    CisRepository repository = CisRepository();
    var request = UtilizationAggregationRequest();
    request.groupCis = groupModel.code;
    request.unitCis = getCisList();
    var baseModel = await repository.sendUtilAggregation(request);
    return baseModel;
  }

  List<String> getCisList() {
    var list = <String>[];
    for (var item in cisList) {
      list.add(item.code!);
    }
    return list;
  }

  Timer? _timer;
  int duration = 30;

  FutureOr<void> checkingUtilAggregate(
      CheckingUtillAggregateEvent event, Emitter<AggregateState> emit) async {
    _timer?.cancel();
    if (duration == 0) {
      duration = 30;
     await checkServerStatus(emit);
    } // Eski timerni to'xtatamiz
    // Timer boshlanishi uchun qiymatni tiklaymiz
    emit(RunningState(duration)); // UI yangilash uchun event chaqiramiz

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (duration > 0) {
        duration--;
        add(TickEvent()); // Har soniyada yangi event chaqiramiz
      } else {
        _timer?.cancel(); // Timer tugaganda to‘xtatamiz
        // Serverga so‘rov yuborish
      }
    });
  }

  Future<void> checkServerStatus(Emitter<AggregateState> emit) async {
    emit(ProgressState());

    CisRepository repository = CisRepository();
    var baseModel =
        await repository.checkingAggregation(utilAggr.utilId.toString());

    if (baseModel.code == 200) {
      utilAggr = baseModel.response as UtilAggregateResponse;
      emit(SuccessState());
    } else {
      await playMusic();
      emit(ErrorState(failure: ServerFailure(message: baseModel.message)));
    }
  }

  // TickEvent handler
  FutureOr<void> tick(TickEvent event, Emitter<AggregateState> emit) {
    emit(
      RunningState(duration),
    ); // Har safar yangi duration bilan state chiqarish
  }
}
