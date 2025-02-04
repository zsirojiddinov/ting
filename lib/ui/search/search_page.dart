import 'dart:async';

import 'package:barcode_newland_flutter/newland_scan_result.dart';
import 'package:barcode_newland_flutter/newland_scanner.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:ting/style/text_style.dart';
import 'package:ting/ui/widget/custom_alert_dialog.dart';
import 'package:ting/ui/widget/progressbar.dart';
import 'package:ting/utils/dimens.dart';
import 'package:ting/utils/function.dart';

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
          return Scaffold(
              appBar: AppBar(
                title: Text(
                "Поиск КМ",
                style: textStyle.titleStyle.copyWith(
                  color: MyColor.white,
                ),
              ),
/*              actions: [
                IconButton(
                  onPressed: () {
                    bloc.add(ClearDataEvent());
                  },
                  icon: Icon(
                    FluentIcons.delete_12_regular,
                  ),
                ),
              ],*/
            ),
            body: Stack(
              children: [
                ui(),
                loading(),
              ],
            ),
          );
        },
      ),
    );
  }

  ui() {
    return Container(
      height: dimens.screenHeight,
      padding: EdgeInsets.symmetric(
        vertical: dimens.height10,
        horizontal: dimens.width20,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            bloc.isEmpty
                ? Container(
                    alignment: Alignment.center,
                    width: dimens.screenWidth,
                    height: dimens.screenHeight * 0.8,
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.qr_code_scanner_outlined,
                            size: dimens.iconSize24 * 3,
                          ),
                          Text(
                            "❗️Отсканируйте код маркировки",
                            style: textStyle.titleStyle.copyWith(
                              color: MyColor.red_color,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  )
                : Container(
                    child: Column(
                      children: [
                        box_widget(),
                        item_info(
                          title: "Статус",
                          message: bloc.model.statusName.toString(),
                          //      isHorizontal: true,
                        ),
                        item_info(
                          title: "Агрегация",
                          message: bloc.model.statusAggregation.toString(),
                          //     isHorizontal: true,
                        ),
                        bloc.isGroupModel
                            ? item_info(
                                title: "Количество единиц в упаковке",
                                message: bloc.model.packageCount.toString(),
                              )
                            : Container(),
                        item_info(
                          title: "Наименование продукции",
                          message: bloc.model.productName.toString(),
                        ),
                        item_info(
                          title: "Наименование собственника товара",
                          message: bloc.model.ownerName.toString(),
                        ),
                        item_info(
                          title: "Дата производства",
                          message: bloc.model.productionDate.toString(),
                        ),
                        item_info(
                          title: "Дата ввода товара в оборот",
                          message: bloc.model.producedDate.toString(),
                        ),
                      ],
                    ),
                  ),
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

  box_widget() {
    return Row(
      children: [
        Icon(
          bloc.isGroupModel
              ? FluentIcons.box_16_regular
              : FluentIcons.drink_bottle_20_regular,
          size: dimens.iconSize16 * 2,
          color: MyColor.blue_color,
        ),
        Gap(dimens.width10),
        Row(
          children: [
            Text(
              bloc.isGroupModel ? "Групповая упаковка" : "Единица товара",
              style: textStyle.text_style.copyWith(
                color: MyColor.blue_color,
              ),
            ),
            Gap(dimens.width10),
            bloc.isEmpty
                ? Text(
                    "${bloc.model.packageCount}",
                    style: textStyle.titleStyle,
                  )
                : Container()
          ],
        ),
      ],
    );
  }

  item_info({
    required String title,
    required String message,
    bool isMessageDateFormat = false,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: dimens.height10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: textStyle.text_secondary_style,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  isMessageDateFormat ? changeDateFormat(message) : message,
                  style: textStyle.text_style_bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
