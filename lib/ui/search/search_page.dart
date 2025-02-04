import 'dart:async';

import 'package:barcode_newland_flutter/newland_scan_result.dart';
import 'package:barcode_newland_flutter/newland_scanner.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:ting/model/aggregate/cis_model.dart';
import 'package:ting/style/text_style.dart';
import 'package:ting/ui/widget/buttons.dart';
import 'package:ting/ui/widget/custom_alert_dialog.dart';
import 'package:ting/ui/widget/deceorations.dart';
import 'package:ting/ui/widget/progressbar.dart';
import 'package:ting/utils/dimens.dart';

import '../../bloc/search/search_bloc.dart';
import '../../bloc/search/search_event.dart';
import '../../bloc/search/search_state.dart';
import '../../style/colors.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late AppStyle textStyle;
  late Dimens dimens;

  late SearchBloc bloc;

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
      create: (context) => SearchBloc(),
      child: BlocConsumer<SearchBloc, SearchState>(
        listener: (context, state) {
          if (state is ErrorState) {
            showMessage(context, state.failure.getLocalizedMessage(context));
          }
        },
        builder: (context, state) {
          bloc = BlocProvider.of<SearchBloc>(context);

          _subscription = _stream.distinct().take(1).listen(
            (data) {
              _subscription.cancel();
              bloc.add(AddBarcodeEvent(data));
            },
          );

          int timerValue = 30; // Default value

          if (state is RunningState) {
            timerValue = state
                .duration; // Agar timer ishlayotgan bo‘lsa, duration-ni ko‘rsatamiz
          }
          return Scaffold(
              appBar: AppBar(
                title: Text(
                  "Агрегация",
                  style: textStyle.titleStyle.copyWith(
                    color: MyColor.white,
                  ),
                ),
              ),
              body: Stack(
                children: [
                  ui(timerValue),
                  loading(),
                ],
              ));
        },
      ),
    );
  }

  ui(int timerValue) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: dimens.height10,
        horizontal: dimens.width20,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            groupWidget(),
            Gap(dimens.height10),
            bloc.isHasGroupData ? cisWidget() : Container(),
            bloc.showText == ""
                ? Container()
                : Column(
                    children: [
                      Gap(dimens.height10),
                      Text(
                        bloc.showText,
                        style: textStyle.text_style.copyWith(
                          color: MyColor.red_color,
                        ),
                      ),
                    ],
                  ),
            bloc.isHasGroupData && bloc.idFullCisList
                ? Container(
                    child: bloc.groupModel.packageCount ==
                                bloc.cisList.length &&
                            bloc.utilAggr.utilId == 0
                        ? Column(
                            children: [
                              Gap(dimens.height20),
                              WhiteBtn(
                                text: "Отправить",
                                onClick: () {
                                  bloc.add(SendUtilizationEvent());
                                },
                              ),
                            ],
                          )
                        : Column(
                            children: [
                              Gap(dimens.height20),
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
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Нанесения (${bloc.utilAggr.utilStatus?.name})",
                                        style: textStyle.text_style,
                                      ),
                                    ),
                                    Gap(dimens.width20),
                                    CircleAvatar(
                                      backgroundColor: parseColor(
                                        bloc.utilAggr.utilStatus!.color!,
                                      ),
                                      radius: dimens.height20,
                                    ),
                                  ],
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
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Агрегация (${bloc.utilAggr.aggStatus?.name})",
                                        style: textStyle.text_style,
                                      ),
                                    ),
                                    Gap(dimens.width20),
                                    CircleAvatar(
                                      backgroundColor: parseColor(
                                        bloc.utilAggr.aggStatus!.color!,
                                      ),
                                      radius: dimens.height20,
                                    ),
                                  ],
                                ),
                              ),
                              Gap(dimens.height45 * 2),
                              bloc.utilAggr.aggStatus!.isAccept &&
                                      bloc.utilAggr.utilStatus!.isAccept
                                  ? Container(
                                      child: Text(
                                        "✅ Агрегация успешно",
                                        style: textStyle.text_style.copyWith(
                                          color: MyColor.green,
                                        ),
                                      ),
                                    )
                                  : WhiteBtn(
                                      text: timerValue == 0
                                          ? "Проверить"
                                          : "Проверить через $timerValue секунд",
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
    return BlocBuilder<SearchBloc, SearchState>(
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
        Gap(dimens.width10),
        Row(
          children: [
            Text(
              "Групповая упаковка",
              style: textStyle.text_style.copyWith(
                color: bloc.isHasGroupData ? MyColor.blue_color : MyColor.greys,
              ),
            ),
            Gap(dimens.width10),
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
          crossAxisCount: 5,
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

  Color parseColor(String hexColor) {
    if (hexColor == "") return MyColor.greys;
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor'; // Alpha qiymatini qo'shish (FF = 100% opacity)
    }
    return Color(int.parse('0x$hexColor'));
  }
}
