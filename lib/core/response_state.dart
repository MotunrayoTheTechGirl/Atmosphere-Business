import 'package:dealer_portal_mobile/core/enums.dart';

class ResponseState<T> {
  ResponseState({
    required this.status,
    this.message,
    this.data,
  });

  ResponseStatus status;
  String? message;
  T? data;
}
