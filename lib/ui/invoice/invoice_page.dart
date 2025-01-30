import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ting/model/invoice/invoice_model.dart';
import 'package:ting/style/colors.dart';
import 'package:ting/style/text_style.dart';
import 'package:ting/ui/widget/buttons.dart';
import 'package:ting/ui/widget/custom_alert_dialog.dart';
import 'package:ting/ui/widget/deceorations.dart';
import 'package:ting/ui/widget/new_input_widget.dart';
import 'package:ting/ui/widget/progressbar.dart';
import 'package:ting/utils/dimens.dart';

import '../../bloc/invoice/invoice_bloc.dart';
import '../../bloc/invoice/invoice_event.dart';
import '../../bloc/invoice/invoice_state.dart';
import '../../utils/function.dart';

class InvoicePage extends StatefulWidget {
  const InvoicePage({super.key});

  @override
  State<InvoicePage> createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage> {
  late AppStyle textStyle;
  late Dimens dimens;
  late InvoiceBloc bloc;
  @override
  Widget build(BuildContext context) {
    textStyle = AppStyle(context);
    dimens = Dimens(context);
    return BlocProvider(
      create: (context) => InvoiceBloc()..add(GetInvoiceDataEvent()),
      child: BlocConsumer<InvoiceBloc, InvoiceState>(
        listener: (context, state) {
          if (state is ErrorState) {
            showMessage(context, state.failure.getLocalizedMessage(context));
          }
        },
        builder: (context, state) {
          bloc = BlocProvider.of<InvoiceBloc>(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "Invoice",
                style: textStyle.titleStyle.copyWith(
                  color: MyColor.white,
                ),
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      openFilterDialog(context);
                    },
                    icon: Icon(FluentIcons.filter_12_filled))
              ],
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
      child: ListView.builder(
        shrinkWrap: true,
        primary: true,
        itemCount: bloc.list.length,
        itemBuilder: (context, index) {
          var model = bloc.list[index];
          return item_invoice(model);
        },
      ),
    );
  }

  loading() {
    return BlocBuilder<InvoiceBloc, InvoiceState>(
      builder: (context, state) {
        return state is ProgressState ? progressBar(dimens) : Container();
      },
    );
  }

  item_invoice(InvoiceModel model) {
    return GestureDetector(
      child: Container(
        decoration: decorationWithStatus(dimens, status: model.status!),
        padding: EdgeInsets.symmetric(
          horizontal: dimens.width20,
          vertical: dimens.height10,
        ),
        margin: EdgeInsets.symmetric(
          vertical: dimens.height10,
          horizontal: dimens.width20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    "${model.facturaNumber} от ${changeDateFormat(model.facturaDate.toString())}",
                    style: textStyle.text_style.copyWith(
                      color: model.status == 2
                          ? MyColor.white
                          : MyColor.text_color,
                    ),
                  ),
                ),
                Text(
                  "${model.cisCount}/${model.productCount}",
                  style: textStyle.text_style.copyWith(
                    color:
                        model.status == 2 ? MyColor.white : MyColor.text_color,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    model.partnerName.toString(),
                    style: textStyle.text_style.copyWith(
                      color: model.status == 2
                          ? MyColor.white
                          : MyColor.text_color,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      onTap: () {
        bloc.add(OpenInvoiceEvent(model));
      },
    );
  }

  void openFilterDialog(BuildContext context) {
    final invoiceBloc = context.read<InvoiceBloc>(); // Contextdan olish

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(dimens.radius16),
        ),
      ),
      builder: (BuildContext context) {
        return BlocProvider.value(
            value: invoiceBloc,
            child: Container(
              height: dimens.screenHeight * 0.85,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: dimens.width20,
                  vertical: dimens.height10,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Фильтр',
                      style: textStyle.titleStyle,
                    ),
                    Text(
                      "Выберите статус",
                      style: textStyle.text_style,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: BlocBuilder<InvoiceBloc, InvoiceState>(
                            builder: (context, state) {
                              return RadioMenuButton(
                                value: "",
                                groupValue:
                                    context.read<InvoiceBloc>().selectRadio,
                                onChanged: (val) {
                                  // Get.back();
                                  context
                                      .read<InvoiceBloc>()
                                      .add(ChangeFilterEvent(val.toString()));
                                },
                                child: Text(
                                  "Все",
                                  style: textStyle.text_secondary_style,
                                ),
                              );
                            },
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: BlocBuilder<InvoiceBloc, InvoiceState>(
                            builder: (context, state) {
                              return RadioMenuButton(
                                value: "0",
                                groupValue:
                                    context.read<InvoiceBloc>().selectRadio,
                                onChanged: (val) {
                                  // Get.back();
                                  context
                                      .read<InvoiceBloc>()
                                      .add(ChangeFilterEvent(val.toString()));
                                },
                                child: Text(
                                  "Новый",
                                  style: textStyle.text_secondary_style,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: BlocBuilder<InvoiceBloc, InvoiceState>(
                            builder: (context, state) {
                              return RadioMenuButton(
                                value: "1",
                                groupValue:
                                    context.read<InvoiceBloc>().selectRadio,
                                onChanged: (val) {
                                  // Get.back();
                                  context
                                      .read<InvoiceBloc>()
                                      .add(ChangeFilterEvent(val.toString()));
                                },
                                child: Text(
                                  "В процессе",
                                  style: textStyle.text_secondary_style,
                                ),
                              );
                            },
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: BlocBuilder<InvoiceBloc, InvoiceState>(
                            builder: (context, state) {
                              return RadioMenuButton(
                                value: "2",
                                groupValue:
                                    context.read<InvoiceBloc>().selectRadio,
                                onChanged: (val) {
                                  // Get.back();
                                  context
                                      .read<InvoiceBloc>()
                                      .add(ChangeFilterEvent(val.toString()));
                                },
                                child: Text(
                                  "Заполнена",
                                  style: textStyle.text_secondary_style,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    Gap(dimens.height10),
                    BlocBuilder<InvoiceBloc, InvoiceState>(
                      builder: (context, state) {
                        return Column(
                          children: [
                            NewBirthdayWidget(
                              title: "Период:  c",
                              text: changeDateTime(
                                  context.read<InvoiceBloc>().startDate),
                              onCLick: () {
                                context
                                    .read<InvoiceBloc>()
                                    .add(SelectDateEvent(context, "1"));
                              },
                            ),
                            Gap(dimens.height10),
                            NewBirthdayWidget(
                              title: "по",
                              text: changeDateTime(
                                  context.read<InvoiceBloc>().endDate),
                              onCLick: () {
                                context
                                    .read<InvoiceBloc>()
                                    .add(SelectDateEvent(context, "2"));
                              },
                            ),
                            Gap(dimens.height20),
                            WhiteBtn(
                              text: "Поиск",
                              onClick: () {
                                Get.back();
                                context.read<InvoiceBloc>().add(GoEvent());
                              },
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ));
      },
    );
  }
}
