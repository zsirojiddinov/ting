import 'dart:async';

import 'package:barcode_newland_flutter/newland_scan_result.dart';
import 'package:barcode_newland_flutter/newland_scanner.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:ting/model/cis_model.dart';
import 'package:ting/style/text_style.dart';
import 'package:ting/ui/widget/buttons.dart';
import 'package:ting/ui/widget/custom_alert_dialog.dart';
import 'package:ting/ui/widget/deceorations.dart';
import 'package:ting/ui/widget/progressbar.dart';
import 'package:ting/utils/dimens.dart';

import '../../bloc/aggregate/aggregate_bloc.dart';
import '../../bloc/aggregate/aggregate_event.dart';
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

  late AggregateBloc bloc;

  late Stream<NewlandScanResult> _stream;
  late StreamSubscription<NewlandScanResult> _subscription;

  @override
  void initState() {
    super.initState();
    _stream = Newlandscanner.listenForBarcodes;
  }

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
          bloc = BlocProvider.of<AggregateBloc>(context);

          _subscription = _stream.listen((data) {
            bloc.add(AddBarcodeEvent(data));
            _subscription.cancel();
          });
          return Scaffold(
              appBar: AppBar(
                title: Text(
                  "Agregatsiya",
                  style: textStyle.titleStyle.copyWith(
                    color: MyColor.white,
                  ),
                ),
              ),
              body: Stack(
                children: [
                  ui(),
                  loading(),
                ],
              ));
        },
      ),
    );
  }

  ui() {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: dimens.height10,
        horizontal: dimens.width20,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            groupWidget(),
            bloc.isHasGroupData ? cisWidget() : Container(),
            bloc.showText == ""
                ? Container()
                : Text(
                    bloc.showText,
                    style: textStyle.text_style.copyWith(
                      color: MyColor.red_color,
                    ),
                  ),
            bloc.isHasGroupData && bloc.idFullCisList
                ? Container(
                    child: Column(
                      children: [
                        Container(
                          decoration: newDecoration(dimens),
                          alignment: Alignment.center,
                          width: dimens.screenWidth,
                          padding: EdgeInsets.symmetric(
                            horizontal: dimens.width20,
                            vertical: dimens.height10,
                          ),
                          margin: EdgeInsets.symmetric(
                            vertical: dimens.height10,
                          ),
                          child: Text(
                            "Utilization ${bloc.utilAggr.utilStatus}",
                            style: textStyle.text_style,
                          ),
                        ),
                        Container(
                          decoration: newDecoration(dimens),
                          alignment: Alignment.center,
                          width: dimens.screenWidth,
                          padding: EdgeInsets.symmetric(
                            horizontal: dimens.width20,
                            vertical: dimens.height10,
                          ),
                          margin: EdgeInsets.symmetric(
                            vertical: dimens.height10,
                          ),
                          child: Text(
                            "Aggregation ${bloc.utilAggr.aggStatus}",
                            style: textStyle.text_style,
                          ),
                        ),
                        Gap(dimens.height45 * 2),
                        WhiteBtn(
                          text: "checking",
                          onClick: () {
                            bloc.add(CheckingUtillAggregateEvent());
                          },
                        )
                      ],
                    ),
                  )
                : Container(),
            //   scanner_result(_stream, textStyle, bloc),
          ],
        ),
      ),
    );
  }

  loading() {
    return BlocBuilder<AggregateBloc, AggregateState>(
      builder: (context, state) {
        return state is ProgressState ? progressBar(dimens) : Container();
      },
    );
  }

  groupWidget() {
    return Row(
      children: [
        Icon(
          FluentIcons.box_16_regular,
          size: dimens.iconSize24,
          color: bloc.isHasGroupData ? MyColor.blue_color : MyColor.greys,
        ),
        Gap(dimens.width20),
        Row(
          children: [
            Text(
              "Group",
              style: textStyle.titleStyle.copyWith(
                color: bloc.isHasGroupData ? MyColor.blue_color : MyColor.greys,
              ),
            ),
            Gap(dimens.width20),
            bloc.isHasGroupData
                ? Text(
                    "${bloc.cisFullLenght}/${bloc.groupModel.packageCount}",
                    style: textStyle.titleStyle,
                  )
                : Container()
          ],
        ),
      ],
    );
  }

  cisWidget() {
    return Container(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: dimens.paddingItems,
          crossAxisSpacing: dimens.paddingHeight,
          childAspectRatio: 1.5,
        ),
        shrinkWrap: true,
        primary: false,
        itemCount: bloc.groupModel.packageCount,
        itemBuilder: (BuildContext context, int index) {
          CisModel model = CisModel();
          if (index < bloc.cisList.length) {
            model.code = bloc.cisList[index].code;
            model.packageCount = bloc.cisList[index].packageCount;
            model.packageType = bloc.cisList[index].packageType;
          }
          print(model.toJson());
          return Container(
            decoration: colorDecoration(
              dimens,
              isActive: model.code != "",
            ),
            child: Icon(
              FluentIcons.drink_bottle_20_regular,
              color: model.code == ""
                  ? MyColor.text_secondary_color
                  : MyColor.white,
            ),
          );
        },
      ),
    );
  }
}
