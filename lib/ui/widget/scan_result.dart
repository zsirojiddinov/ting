import 'package:barcode_newland_flutter/newland_scan_result.dart';
import 'package:flutter/material.dart';
import 'package:ting/style/text_style.dart';

scan_result(
  Stream<NewlandScanResult> stream,
  AppStyle textStyle,
) {
  return Center(
    child: StreamBuilder<NewlandScanResult>(
        stream: stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!;

            return Text(
              'Scanned barcode: ${data.barcodeData}',
              style: textStyle.titleStyle,
            );
          }

          return const Text('Waiting for Data');
        }),
  );
}
