import 'package:intl/intl.dart';

class DateReformat {
  DateReformat._();

  static String reformatYMD(String timeString){
    DateTime date = DateTime.parse(timeString);
    return DateFormat('yyyy-MM-dd').format(date);
  }
}
