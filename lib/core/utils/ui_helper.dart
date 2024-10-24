import 'package:intl/intl.dart';

String formatNaira(String amount) {
  final amountToDouble = double.parse(amount);
  final NumberFormat formatter = NumberFormat('₦#,##0');
  return formatter.format(amountToDouble);
}

String formatDate(String dateString) {
  DateTime parsedDate = DateTime.parse(dateString);
  String daySuffix(int day) {
    if (day >= 11 && day <= 13) {
      return 'th';
    }
    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }

  String day = DateFormat('d').format(parsedDate);
  String suffix = daySuffix(parsedDate.day);
  String formattedDate =
      '$day$suffix ${DateFormat('MMM, yyyy').format(parsedDate)}';
  return formattedDate;
}

String formatFirstName(String fullName) {
  if (fullName.isEmpty) return '';
  String firstName = fullName.split(' ').first;
  return firstName[0].toUpperCase() + firstName.substring(1).toLowerCase();
}

String formatPhoneNumber(String phoneNumber) {
  String updatedNumber = phoneNumber.replaceFirst('0', '+234');
  return updatedNumber;
}

String? validatePhoneNumber(
  String? phoneNumber,
) {
  if (phoneNumber == null || phoneNumber.isEmpty) {
    return 'Phone Number is required';
  }
  if (phoneNumber.length != 11 && RegExp(r'^\d+$').hasMatch(phoneNumber)) {
    return 'Enter a valid Phone number';
  }
  return null;
}
