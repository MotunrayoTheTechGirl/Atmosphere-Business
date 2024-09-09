import 'dart:developer';

import 'package:dealer_portal_mobile/core/api/api_response.dart';
import 'package:dealer_portal_mobile/core/api/api_utils.dart';
import 'package:dealer_portal_mobile/core/api/dio_interceptor.dart';
import 'package:dealer_portal_mobile/core/enums.dart';
import 'package:dealer_portal_mobile/core/exceptions.dart';
import 'package:dio/dio.dart';

class DealerPoratlApi {
  static late DealerPoratlApi _instance;
  late Dio _dio;
  late String _baseUrl;
  late Map<String, String> _headers;

  factory DealerPoratlApi() {
    return _instance;
  }

  DealerPoratlApi._internal(Environment environment) {
    _dio = Dio();
    _baseUrl = _getBaseUrl(environment);
    _headers = {};
    _dio.interceptors.add(DioInterceptor());
  }

  static void initialize(Environment environment) {
    _instance = DealerPoratlApi._internal(environment);
  }

  String _getBaseUrl(Environment environment) {
    switch (environment) {
      case Environment.dev:
        return "https://api-dev.wave5wireless.ng";
      case Environment.production:
        return "https://api.wave5wireless.ng";
    }
  }

  /// When using the instance, the string you pass wil be like Account/user/create-user
  Future<ApiResponse?> get(
    String string, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    log('$_baseUrl$string');

    try {
      // log('Headers: $_headers');
      final response = await _dio.get(
        '$_baseUrl$string',
        data: body,
        options: Options(headers: _headers),
        queryParameters: queryParameters,
      );

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 204) {
        log('Status code: ${response.statusCode}');
        log('Response: ${response.data}');

        return ApiUtils.toApiResponse(response);
      } else {
        throw ApiResponseException(
            'Request failed with status code ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        if (e.response != null) {
          if (e.response!.statusCode! >= 500 && e.response!.statusCode! < 600) {
            throw const ApiResponseException(
                'Oops! Something went wrong on our end. Please try again later.');
          }
          final errorMessage = e.response?.data['message'];
          throw ApiResponseException(errorMessage);
        }
      } else if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout) {
        throw const ApiResponseException(
            'Connection timed out. Please check your internet connection and try again');
      } else if (e.type == DioExceptionType.unknown) {
        throw ApiResponseException(e.message ?? '');
      } else {
        rethrow;
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }

  Future<ApiResponse?> post(
    String string, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? body,
    FormData? formData,
    bool isFormData = false,
  }) async {
    log('$_baseUrl$string');
    log('Request Body: $body');
    try {
      // log('Headers: $_headers');
      final response = await _dio.post('$_baseUrl$string',
          data: isFormData ? formData : body,
          options: Options(headers: _headers),
          queryParameters: queryParameters);

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 204) {
        log('Status code: ${response.statusCode}');
        log('Response: ${response.data}');
        return ApiUtils.toApiResponse(response);
      } else {
        log('${response.statusCode}');

        throw ApiResponseException(
            'Request failed with status code ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        if (e.response != null) {
          if (e.response!.statusCode! >= 500 && e.response!.statusCode! < 600) {
            throw const ApiResponseException(
                'Oops! Something went wrong on our end. Please try again later.');
          }
          final errorMessage = e.response?.data['message'];
          log('This is the dio error: $errorMessage');
          throw ApiResponseException(errorMessage ?? '');
        }
      } else if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout) {
        throw const ApiResponseException(
            'Connection timed out. Please check your internet connection and try again');
      } else if (e.type == DioExceptionType.unknown) {
        print(e.message);
        throw ApiResponseException(e.message ?? '');
      } else if (e.type == DioExceptionType.sendTimeout) {
        throw const ApiResponseException('Server down');
      } else {
        rethrow;
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }

  Future<ApiResponse?> put(
    String string, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? body,
  }) async {
    log('$_baseUrl$string');
    log('Request Body: $body');
    try {
      log('Headers: $_headers');
      final response = await _dio.put('$_baseUrl$string',
          data: body,
          options: Options(headers: _headers),
          queryParameters: queryParameters);

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 204) {
        log('${response.statusCode}');

        return ApiUtils.toApiResponse(response);
      } else {
        log('${response.statusCode}');

        throw ApiResponseException(
            'Request failed with status code ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        if (e.response != null) {
          if (e.response!.statusCode! >= 500 && e.response!.statusCode! < 600) {
            throw const ApiResponseException(
                'Oops! Something went wrong on our end. Please try again later.');
          }
          final errorMessage = e.response?.data['message'];
          throw ApiResponseException(errorMessage);
        }
      } else if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout) {
        throw const ApiResponseException(
            'Connection timed out. Please check your internet connection and try again');
      } else if (e.type == DioExceptionType.unknown) {
        throw ApiResponseException(e.message ?? '');
      } else {
        rethrow;
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }

  //Power of Attorney
  Future<ApiResponse?> delete(
    String string, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? body,
  }) async {
    log('$_baseUrl$string');
    log('Request Body: $body');
    try {
      log('Headers: $_headers');
      final response = await _dio.delete('$_baseUrl$string',
          data: body,
          options: Options(headers: _headers),
          queryParameters: queryParameters);

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 204) {
        log('${response.statusCode}');
        return ApiUtils.toApiResponse(response);
      } else {
        log('${response.statusCode}');

        throw ApiResponseException(
            'Request failed with status code ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        if (e.response != null) {
          if (e.response!.statusCode! >= 500 && e.response!.statusCode! < 600) {
            throw const ApiResponseException(
                'Oops! Something went wrong on our end. Please try again later.');
          }
          final errorMessage = e.response?.data['message'];
          throw ApiResponseException(errorMessage);
        }
      } else if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout) {
        throw const ApiResponseException(
            'Connection timed out. Please check your internet connection and try again');
      } else if (e.type == DioExceptionType.unknown) {
        throw ApiResponseException(e.message ?? '');
      } else {
        rethrow;
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }

  Future<ApiResponse?> patch(
    String string, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? body,
  }) async {
    log('$_baseUrl$string');
    log('Request Body: $body');
    try {
      log('Headers: $_headers');
      final response = await _dio.patch('$_baseUrl$string',
          data: body,
          options: Options(headers: _headers),
          queryParameters: queryParameters);

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 204) {
        log('${response.statusCode}');
        return ApiUtils.toApiResponse(response);
      } else {
        log('${response.statusCode}');

        throw ApiResponseException(
            'Request failed with status code ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        if (e.response != null) {
          final errorMessage = e.response?.data['message'];
          throw ApiResponseException(errorMessage);
        }
      } else if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout) {
        throw const ApiResponseException(
            'Connection timed out. Please check your internet connection and try again');
      } else if (e.type == DioExceptionType.unknown) {
        throw ApiResponseException(e.message ?? '');
      } else {
        rethrow;
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }
}
