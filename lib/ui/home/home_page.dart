import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:ting/bloc/home/home_event.dart';
import 'package:ting/services/preference_service.dart';
import 'package:ting/style/colors.dart';
import 'package:ting/style/text_style.dart';
import 'package:ting/ui/widget/custom_alert_dialog.dart';
import 'package:ting/ui/widget/deceorations.dart';
import 'package:ting/utils/dimens.dart';

import '../../bloc/home/home_bloc.dart';
import '../../bloc/home/home_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late AppStyle textStyle;
  late Dimens dimens;
  late HomeBloc bloc;
/*  late Stream<NewlandScanResult> _stream;

  @override
  void initState() {
    super.initState();
    _stream = Newlandscanner.listenForBarcodes;
  }*/

  @override
  Widget build(BuildContext context) {
    textStyle = AppStyle(context);
    dimens = Dimens(context);
    return BlocProvider(
      create: (context) => HomeBloc(),
      child: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is ErrorState) {
            showMessage(context, state.failure.getLocalizedMessage(context));
          }
        },
        builder: (context, state) {
          bloc = BlocProvider.of<HomeBloc>(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: MyColor.blue,
              title: Text(
                PreferenceService().getLogin(),
                style: textStyle.titleStyle.copyWith(
                  color: MyColor.white,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    bloc.add(SearchEvent());
                  },
                  icon: Icon(FluentIcons.search_12_regular),
                )
              ],
            ),
            body: Container(
              child: Column(
                children: [
                  invoice(),
                  aggregate(),
                  Expanded(
                    flex: 3,
                    child: Container(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  invoice() {
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: () => bloc.add(InvoiceHomeEvent()),
        child: Container(
          alignment: Alignment.center,
          width: dimens.screenWidth,
          decoration: newEditDecoration(dimens),
          padding: EdgeInsets.symmetric(
            horizontal: dimens.width20,
            vertical: dimens.height10,
          ),
          margin: EdgeInsets.symmetric(
            horizontal: dimens.width10,
            vertical: dimens.height10,
          ),
          child: Row(
            children: [
              Icon(
                Icons.local_shipping_outlined,
                color: MyColor.text_color,
                size: dimens.iconSize24,
              ),
              Gap(dimens.width20),
              Text(
                "Отгрузка",
                style: textStyle.titleStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }

  aggregate() {
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: () => bloc.add(AggregateHomeEvent()),
        child: Container(
          alignment: Alignment.center,
          width: dimens.screenWidth,
          decoration: newEditDecoration(dimens),
          padding: EdgeInsets.symmetric(
            horizontal: dimens.width20,
            vertical: dimens.height10,
          ),
          margin: EdgeInsets.symmetric(
            horizontal: dimens.width10,
            vertical: dimens.height10,
          ),
          child: Row(
            children: [
              Icon(
                FluentIcons.box_16_regular,
                color: MyColor.text_color,
                size: dimens.iconSize24,
              ),
              Gap(dimens.width20),
              Text(
                "Агрегация",
                style: textStyle.titleStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
