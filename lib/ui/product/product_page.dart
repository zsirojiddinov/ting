import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ting/bloc/product/product_state.dart';
import 'package:ting/model/invoice/invoice_model.dart';
import 'package:ting/style/colors.dart';
import 'package:ting/style/text_style.dart';
import 'package:ting/ui/widget/custom_alert_dialog.dart';
import 'package:ting/ui/widget/progressbar.dart';
import 'package:ting/utils/dimens.dart';

import '../../bloc/product/product_bloc.dart';
import '../../bloc/product/product_event.dart';

class ProductPage extends StatefulWidget {
  InvoiceModel model;

  ProductPage({super.key, required this.model});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late AppStyle textStyle;
  late Dimens dimens;
  late ProductBloc bloc;

  @override
  Widget build(BuildContext context) {
    textStyle = AppStyle(context);
    dimens = Dimens(context);
    return BlocProvider(
      create: (context) => ProductBloc()..add(GetProductDataEvent()),
      child: BlocConsumer<ProductBloc, ProductState>(
        listener: (context, state) {
          if (state is ErrorState) {
            showMessage(context, state.failure.getLocalizedMessage(context));
          }
        },
        builder: (context, state) {
          bloc = BlocProvider.of<ProductBloc>(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                widget.model.partnerName.toString(),
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
      child: Center(
        child: Text(
          "product",
          style: textStyle.text_style,
        ),
      ),
    );
  }

  loading() {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        return state is ProgressState ? progressBar(dimens) : Container();
      },
    );
  }
}
