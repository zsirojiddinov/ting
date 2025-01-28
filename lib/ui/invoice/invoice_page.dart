import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ting/model/invoice/invoice_model.dart';
import 'package:ting/style/colors.dart';
import 'package:ting/style/text_style.dart';
import 'package:ting/ui/widget/custom_alert_dialog.dart';
import 'package:ting/ui/widget/deceorations.dart';
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
}
