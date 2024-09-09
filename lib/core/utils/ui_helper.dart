import 'package:intl/intl.dart';

String formatNaira(String amount) {
  final amountToDouble = double.parse(amount);
  final NumberFormat formatter = NumberFormat('₦#,##0');
  return formatter.format(amountToDouble);
}
