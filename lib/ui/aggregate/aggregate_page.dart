import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ting/style/text_style.dart';
import 'package:ting/ui/widget/custom_alert_dialog.dart';
import 'package:ting/utils/dimens.dart';

import '../../bloc/aggregate/aggregate_bloc.dart';
import '../../bloc/aggregate/aggregate_state.dart';
import '../../style/colors.dart';

class AggregatePage extends StatefulWidget {
  const AggregatePage({super.key});

  @override
  State<AggregatePage> createState() => _AggregatePageState();
}

class _AggregatePageState extends State<AggregatePage> {
  late AppStyle textStyle;
  late Dimens dimens;

  @override
  Widget build(BuildContext context) {
    textStyle = AppStyle(context);
    dimens = Dimens(context);
    return BlocProvider(
      create: (context) => AggregateBloc(),
      child: BlocConsumer<AggregateBloc, AggregateState>(
        listener: (context, state) {
          if (state is ErrorState) {
            showMessage(context, state.failure.getLocalizedMessage(context));
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "Agregatsiya",
                style: textStyle.titleStyle.copyWith(
                  color: MyColor.white,
                ),
              ),
            ),
            body: Container(
              child: Center(
                child: Text(
                  "agregatsiya",
                  style: textStyle.text_style,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
