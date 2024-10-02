import 'dart:developer';

import 'package:dealer_portal_mobile/core/constants/app_constants.dart';
import 'package:dealer_portal_mobile/core/storage/storage_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';

class DioInterceptor extends Interceptor {
  var logger = Logger(
    printer: PrettyPrinter(),
  );
  final secureStorageService = StorageService(
    secureStorage: const FlutterSecureStorage(),
  );

  /// Intercept a dio request
  @override
  Future<void> onRequest(
    /// RequestOptions object
    RequestOptions options,

    /// RequestInterceptorHandler object
    RequestInterceptorHandler handler,
  ) async {
    /// Get the token from the storage
    // final token = await StoreToken.getToken();
    String? token = await secureStorageService.read(key: AppConstants.token);

    /// Check if the token is not null and not empty
    if (token != null && token.isNotEmpty) {
      /// Add the authorization header with the token value
      options.headers['Authorization'] = 'Bearer $token';
    }

    options.headers['Content-Type'] = 'application/json';

    super.onRequest(options, handler);
    logger.i("Request Endpoint: ${options.path}");
    logger.i("Request Endpoint with param: ${options.uri.queryParameters}");
    logger.d("Request Header: ${options.headers}");
    logger.d("Request data: ${options.data}");
  }

  /// Intercept a dio response
  @override
  Future<void> onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    super.onResponse(response, handler);

    log("Response: $response");
  }
}
