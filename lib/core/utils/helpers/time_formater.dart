import 'package:intl/intl.dart';

String formatDateTime(String dateString) {
  if (dateString == null || dateString.trim().isEmpty) {
    return 'Invalid Date';
  }

  try {
    final date = DateFormat("yyyy-MM-dd HH:mm").parse(dateString);
    return DateFormat("yyyy-MM-dd").format(date);
  } catch (e) {
    return 'Invalid Format';
  }
}
