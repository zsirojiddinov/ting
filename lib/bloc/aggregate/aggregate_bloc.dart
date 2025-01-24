import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'aggregate_event.dart';
import 'aggregate_state.dart';

class AggregateBloc extends Bloc<AggregateEvent, AggregateState> {
  AggregateBloc() : super(SuccessState()) {
    on<SettingsEvent>(settings);
  }

  FutureOr<void> settings(
      SettingsEvent event, Emitter<AggregateState> emit) async {
    // Get.to(() => ProfilePage());
    return;
  }
}
