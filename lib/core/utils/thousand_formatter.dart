import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class ThousandsSeparatorInputFormatter extends TextInputFormatter {
  final NumberFormat formatter = NumberFormat("#,##0", "en_US");

  // Keep track of the raw numeric value
  String _numericValue = '';

  // Getter for the raw numeric value without formatting
  String get numericValue => _numericValue;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // If empty, reset numeric value and return
    if (newValue.text.isEmpty) {
      _numericValue = '';
      return newValue;
    }

    // Remove all non-digit characters
    String cleanText = newValue.text.replaceAll(RegExp(r'[^\d]'), '');

    // Store the clean numeric value for validation
    _numericValue = cleanText;

    try {
      // Parse the clean text as integer
      final number = int.parse(cleanText);
      final formattedText = formatter.format(number);

      return TextEditingValue(
        text: formattedText,
        selection: TextSelection.collapsed(offset: formattedText.length),
      );
    } catch (e) {
      // If any parsing errors occur, maintain the last valid state
      return oldValue;
    }
  }
}
