import 'package:dealer_portal_mobile/core/api/api_response.dart';
import 'package:dio/dio.dart';

class ApiUtils {
  static ApiResponse toApiResponse(Response response) {
    final headers = Map<String, dynamic>.from(response.headers.map);
    return ApiResponse(
      headers: headers,
      data: response.data,
      statusCode: response.statusCode,
    );
  }
}
