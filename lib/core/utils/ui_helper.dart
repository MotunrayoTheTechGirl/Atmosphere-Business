import 'package:intl/intl.dart';

String formatNaira(String amount) {
  final amountToDouble = double.parse(amount);
  final NumberFormat formatter = NumberFormat('₦#,##0');
  return formatter.format(amountToDouble);
}

String formatDate(String date) {
  DateTime dateTime = DateTime.parse(date);

  String formatDayWithSuffix(int day) {
    if (day >= 11 && day <= 13) {
      return '${day}th';
    }
    switch (day % 10) {
      case 1:
        return '${day}st';
      case 2:
        return '${day}nd';
      case 3:
        return '${day}rd';
      default:
        return '${day}th';
    }
  }

  String detailsDate = "${formatDayWithSuffix(dateTime.day)} "
      "${DateFormat('MMMM').format(dateTime)} "
      "${dateTime.year}, "
      "${DateFormat('h:mm a').format(dateTime)}";
  return detailsDate;
}
