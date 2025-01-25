import 'dart:async';

import 'package:barcode_newland_flutter/newland_scan_result.dart';
import 'package:barcode_newland_flutter/newland_scanner.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:ting/style/text_style.dart';
import 'package:ting/ui/widget/custom_alert_dialog.dart';
import 'package:ting/ui/widget/deceorations.dart';
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
            print('_subscription barcode: ${data.barcodeData}');

            bloc.add(AddBarcodeEvent(data));
            // Ma'lumotni Bloc-ga yuborish

            // Ma'lumotni qayta ishlagandan so'ng oqimni bekor qilish
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
            body: Container(
              padding: EdgeInsets.symmetric(
                vertical: dimens.height10,
                horizontal: dimens.width20,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        FluentIcons.box_16_regular,
                        size: dimens.iconSize24,
                        color: bloc.isHasGroupData
                            ? MyColor.blue_color
                            : MyColor.text_secondary_color,
                      ),
                      Gap(dimens.width20),
                      Text(
                        "Group",
                        style: textStyle.titleStyle.copyWith(
                          color: bloc.isHasGroupData
                              ? MyColor.black
                              : MyColor.text_secondary_color,
                        ),
                      ),
                    ],
                  ),
                  bloc.isHasGroupData
                      ? Container(
                          child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: dimens.paddingWidth,
                              crossAxisSpacing: dimens.paddingWidth,
                              childAspectRatio: 1.5,
                            ),
                            shrinkWrap: true,
                            primary: false,
                            itemCount: bloc.listCis.length,
                            itemBuilder: (BuildContext context, int index) {
                              var model = bloc.listCis[index];
                              return Container(
                                decoration: colorDecoration(
                                  dimens,
                                  isRed: model.code == "",
                                  isBlue: model.code != "",
                                ),
                                child: Icon(
                                  FluentIcons.drink_bottle_20_regular,
                                  color: model.code == ""
                                      ? MyColor.text_secondary_color
                                      : MyColor.green,
                                ),
                              );
                            },
                          ),
                        )
                      : Container(),
                  Text(
                    bloc.isHasGroupData
                        ? "CIS qrcodelarni scaner qiling"
                        : "Group qrcodelarni scaner qiling",
                    style: textStyle.text_style.copyWith(
                      color: MyColor.red_color,
                    ),
                  ),
                  //   scanner_result(_stream, textStyle, bloc),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
