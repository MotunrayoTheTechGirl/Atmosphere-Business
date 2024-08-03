class ApiResponseException implements Exception {
  final String message;

  const ApiResponseException(this.message);

  @override
  String toString() {
    return message;
  }
}

class Failure implements Exception {
  final String message;

  const Failure(this.message);
  @override
  String toString() {
    return message;
  }
}
