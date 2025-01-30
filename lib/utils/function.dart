import 'package:intl/intl.dart';

changeDateFormat(String inputDate) {
  DateTime parsedDate = DateTime.parse(inputDate);
  return DateFormat('dd.MM.yyyy').format(parsedDate);
}

changeDateTime2(DateTime date) {
  return DateFormat('yyyy-MM-dd').format(date);
}

changeDateTime(DateTime date) {
  return DateFormat('dd.MM.yyyy').format(date);
}
