import 'package:intl/intl.dart';

changeDateFormat(String inputDate) {
  DateTime parsedDate = DateTime.parse(inputDate);
  return DateFormat('dd.MM.yyyy').format(parsedDate);
}
