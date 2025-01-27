import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ting/model/base_model.dart';
import 'package:ting/model/util_aggregate_response.dart';
import 'package:ting/model/utilization_aggregation_request.dart';
import 'package:ting/utils/constanta.dart';
import 'package:ting/utils/errors.dart';

import '../../model/cis_model.dart';
import '../../repository/cis_repository.dart';
import 'aggregate_event.dart';
import 'aggregate_state.dart';

class AggregateBloc extends Bloc<AggregateEvent, AggregateState> {
  bool get isHasGroupData {
    return groupModel.code != "";
  }

  String get showText {
    if (!isHasGroupData) {
      return "Qutini scaner qiling!";
    }

    if (cisFullLenght != groupModel.packageCount)
      return "Maxsulotni scaner qiling!";

    return "123";
  }

  int get cisFullLenght {
    return cisList.length;
  }

  var groupModel = CisModel();
  var cisList = <CisModel>[];

  var utilAggr = UtilAggregateResponse();

  AggregateBloc() : super(SuccessState()) {
    on<SettingsEvent>(settings);
    on<AddBarcodeEvent>(addEvent);
    on<CheckingUtillAggregateEvent>(checkingUtilAggregate);
  }

  bool _isButtonEnabled = true;
  int _secondsLeft = 10;
  Timer? _timer;

  FutureOr<void> settings(
      SettingsEvent event, Emitter<AggregateState> emit) async {
    _isButtonEnabled = false;
    _secondsLeft = 10;
    emit(SuccessState());

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsLeft > 1) {
        _secondsLeft--;
        emit(SuccessState());
      } else {
        _isButtonEnabled = true;
        _timer?.cancel();
        emit(SuccessState());
      }
    });
  }

  FutureOr<void> checkingUtilAggregate(
      CheckingUtillAggregateEvent event, Emitter<AggregateState> emit) async {
    CisRepository repository = CisRepository();
    emit(ProgressState());
    var baseModel =
        await repository.checkingAggregation(utilAggr.utilId.toString());
    if (baseModel.code == 200) {
      utilAggr = baseModel.response as UtilAggregateResponse;
      emit(SuccessState());
      return;
    } else {
      emit(ErrorState(failure: ServerFailure(message: baseModel.message)));
    }
  }

  addEvent(AddBarcodeEvent event, Emitter<AggregateState> emit) async {
    print("listen addEvent: ${event.data.barcodeData}");
    // check group
    if (groupModel.code == "") {
      emit(ProgressState());
      BaseModel baseModel = await checkStatus(event.data.barcodeData);
      print("listen baseModel.code: ${baseModel.code}");
      print("listen baseModel.message: ${baseModel.message}");
/*
      baseModel.code = 200;
      baseModel.response = CisModel(
        accept: true,
        code: event.data.barcodeData,
        packageCount: 15,
        packageType: IConstanta.GROUP,
      );*/
      if (baseModel.code != 200) {
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
        emit(ErrorState(failure: NotGroupCodeFailure()));
        return;
      }
    }

    // check cis

    if (cisList.length == groupModel.packageCount) {
      emit(ErrorState(
          failure: ServerFailure(message: "qrcode scaner qilib bo'lmaydi")));
      return;
    }

    var isUnical = isUnitUnical(event.data.barcodeData);
    if (!isUnical) {
      emit(ErrorState(failure: ServerFailure(message: "takroriy qrcode")));
      return;
    }

    emit(ProgressState());
    BaseModel baseModel = await checkStatus(event.data.barcodeData);
    print("listen baseModel.code: ${baseModel.code}");
    print("listen baseModel.message: ${baseModel.message}");

/*    baseModel.code = 200;
    baseModel.response = CisModel(
      accept: true,
      code: event.data.barcodeData,
      packageCount: 0,
      packageType: IConstanta.UNIT,
    );*/

    if (baseModel.code != 200) {
      emit(ErrorState(failure: ServerFailure(message: baseModel.message!)));
      return;
    }

    var cisModel = baseModel.response as CisModel;

    if (cisModel.packageType == IConstanta.GROUP) {
      emit(ErrorState(failure: NotUnitCodeFailure()));
      return;
    }

    if (!isUnitUnical(event.data.barcodeData)) {
      emit(ErrorState(failure: ServerFailure(message: "takroriy qrcode")));
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
}
