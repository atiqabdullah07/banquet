import 'package:intl/intl.dart';

String dateTypeConverter({required String date}) {
  DateTime originalDate = DateTime.parse(date);
  String formattedDate = DateFormat('d MMM y').format(originalDate);
  return formattedDate;
}
