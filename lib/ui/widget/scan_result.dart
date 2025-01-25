import 'package:barcode_newland_flutter/newland_scan_result.dart';
import 'package:flutter/material.dart';
import 'package:ting/style/text_style.dart';

Widget scanner_result(
  Stream<NewlandScanResult> stream,
  AppStyle textStyle,
  OnScannerResult listener,
) {
  return Center(
    child: StreamBuilder<NewlandScanResult>(
        stream: stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!;
            print('Scanned barcode: ${data.barcodeData}');
          //  listener.result(data);
            return Container();
          }

          return Container();
        }),
  );
}

abstract class OnScannerResult {
  result(NewlandScanResult result);
}
