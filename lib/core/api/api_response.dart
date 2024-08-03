class ApiResponse<T> {
  final int? statusCode;
  final T? data;
  final Map<String, dynamic>? headers;

  ApiResponse({
    this.data,
    this.headers,
    this.statusCode,
  });

  bool get isSuccessful =>
      (statusCode ?? 00) >= 200 && (statusCode ?? 00) < 300;

  @override
  String toString() {
    return '$data';
  }
}
