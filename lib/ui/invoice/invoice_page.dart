import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ting/style/text_style.dart';
import 'package:ting/ui/widget/custom_alert_dialog.dart';
import 'package:ting/utils/dimens.dart';

import '../../bloc/invoice/invoice_bloc.dart';
import '../../bloc/invoice/invoice_state.dart';

class InvoicePage extends StatefulWidget {
  const InvoicePage({super.key});

  @override
  State<InvoicePage> createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage> {
  late AppStyle textStyle;
  late Dimens dimens;

  @override
  Widget build(BuildContext context) {
    textStyle = AppStyle(context);
    dimens = Dimens(context);
    return BlocProvider(
      create: (context) => InvoiceBloc(),
      child: BlocConsumer<InvoiceBloc, InvoiceState>(
        listener: (context, state) {
          if (state is ErrorState) {
            showMessage(context, state.failure.getLocalizedMessage(context));
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "Invoice",
                style: textStyle.titleStyle,
              ),
            ),
            body: Container(
              child: Center(
                child: Text(
                  "Invoice",
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
