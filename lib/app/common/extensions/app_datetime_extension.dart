import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

enum DateTimeFormat {
  defaultFormat,
  customFormat,
  anotherCustomFormat,
}

String formatDate(String? dateString) {
  if (dateString != null) {
    DateTime date = DateTime.parse(dateString);

    String monthAbbreviation = DateFormat('MMM').format(date);

    String day = DateFormat('d').format(date);
    String formattedDate = '$monthAbbreviation $day';

    return formattedDate;
  }
  return '';
}

extension DateTimeExtension on DateTime {
  String formatWithEnum(
      [DateTimeFormat format = DateTimeFormat.defaultFormat, String? locale]) {
    String pattern;
    switch (format) {
      case DateTimeFormat.defaultFormat:
        pattern = 'dd/MM/yyyy';
        break;
      case DateTimeFormat.customFormat:
        pattern = 'MMMM dd, yyyy';
        break;
      case DateTimeFormat.anotherCustomFormat:
        pattern = 'yyyy-MM-dd';
        break;
    }

    if (locale != null && locale.isNotEmpty) {
      initializeDateFormatting(locale);
    }
    return DateFormat(pattern, locale).format(this);
  }
}
