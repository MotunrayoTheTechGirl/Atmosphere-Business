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

String formatPhoneNumber(String phoneNumber) {
  // String phoneNumber = phoneNumber;
  String updatedNumber = phoneNumber.replaceFirst('0', '+234');
  return updatedNumber;
}

String? validatePhoneNumber(
  String? phoneNumber,
) {
  if (phoneNumber == null || phoneNumber.isEmpty) {
    // isPhonNumberValid = false;
    return 'Phone Number is required';
  }
  if (phoneNumber.length != 11 && RegExp(r'^\d+$').hasMatch(phoneNumber)) {
    // isPhonNumberValid = true;
    return 'Enter a valid Phone number';
  }
  return null;
}
