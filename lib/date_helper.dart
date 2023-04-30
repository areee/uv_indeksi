import 'package:intl/intl.dart';

String formatDateTime(DateTime dateTime) {
  return DateFormat('d.M.yyyy H:mm').format(dateTime);
}
