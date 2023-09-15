import 'package:intl/intl.dart';

class FormatDate {
  static stringToDate(String date) => DateTime.parse(date);
  static formatDate(String date) =>
      DateFormat.yMMMMd().format(DateTime.parse(date));
  static monthYear(String date) =>
      DateFormat('MMM yyyy').format(DateTime.parse(date));
  static year(String date) =>
      DateFormat('yyyy').format(DateTime.parse(date));
  static date(String date) => DateFormat.d().format(DateTime.parse(date));

  static month(String date) => DateFormat.LLL().format(DateTime.parse(date));
  static fullMonth(String date) =>
      DateFormat.LLLL().format(DateTime.parse(date));
  static dateMonth(String date) =>
      DateFormat('dd MMM, yyyy').format(DateTime.parse(date));
}