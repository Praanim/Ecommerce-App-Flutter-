import 'package:intl/intl.dart';

String formatDate(DateTime dateTime) {
  return DateFormat('yyyy-MM-dd').format(dateTime);
}
