import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../core/helpers/app_logger.dart';

extension CurrencyFormatExtension on num {
  String toCurrency$({String symbol = '\$', String locale = 'en_US'}) {
    final formatter = NumberFormat.currency(
      symbol: symbol,
      locale: locale,
    );
    return formatter.format(this);
  }

  String toCurrencyRP() {
    final formatter = NumberFormat("#,##0", "id_ID");
    return "Rp${formatter.format(this)}";
  }
}

String formatAsCurrency(double? value) {
  final formatter = NumberFormat("#,##0", "id_ID");
  if (value != null) {
    return "Rp${formatter.format(value)}";
  } else {
    return "Rp0";
  }
}

class CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    final formatter = NumberFormat("#,##0", "id_ID");
    var newText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (newText.isNotEmpty) {
      try {
        double value = double.parse(newText);
        newText = formatter.format(value);
      } catch (e) {
        AppLogger.logError(e.toString());
        newText = oldValue.text;
      }
    }
    return newValue.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length));
  }
}
