import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/api/api_endpoints.dart';
import '../../../../core/api/dealer_portal_api.dart';

final fileUploadRepositoryProvider = Provider(
  (ref) => FileUploadRepository(),
);

class FileUploadRepository {
  final api = DealerPoratlApi();

  Future<String> fileUpload({required File file}) async {
    var formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(file.path),
    });
    try {
      log('formData: $formData');
      final response = await api.post('${ApiEndpoints.fileUpload}/dealer',
          formData: formData, isFormData: true);
      log('my file response: $response');
      log('my file response type: ${response.runtimeType}');

      if (response?.data is String) {
        log('Response is String');
        final String responseData = response?.data;
        if (responseData.startsWith('http')) {
          // The response is already a URL string
          log('Response is a URL');
          return responseData;
        } else {
          try {
            // Attempt to parse as JSON
            final data = jsonDecode(responseData);
            log('Parsed JSON data: $data');
            // Assuming the JSON contains a URL field, adjust as needed
            return data['url'] ?? data.toString();
          } catch (e) {
            log('Failed to parse response as JSON: $e');
            // If it's not JSON, return the string as is
            return responseData;
          }
        }
      } else if (response?.data is Map) {
        log('Response is Map');
        // Assuming the Map contains a URL field, adjust as needed
        return response?.data['url'] ?? response?.data.toString();
      } else {
        log('Unexpected response type');
        return response?.data.toString() ?? '';
      }
    } catch (e) {
      log('repo file error: $e');
      rethrow;
    }
  }
}

// class FileUploadRepository {
//   final api = DealerPoratlApi();

//   Future<String> fileUpload({required File file}) async {
//     var formData = FormData.fromMap({
//       "file": await MultipartFile.fromFile(file.path),
//     });
//     try {
//       log('formData: $formData');
//       final response = await api.post('${ApiEndpoints.fileUpload}/dealer',
//           formData: formData, isFormData: true);
//       log('my file response: $response');
//       log(' my file response response type:${response.runtimeType}');
//       if (response?.data is String) {
//         log('--- Is String ----');
//         log('Jellow');
//         final data = jsonDecode(response?.data);
//         log('fellow');
//         log('--Data--: $data');
//         return data;
//       } else {
//         log('Tired asf!');
//         return response?.data;
//       }
//     } catch (e) {
//       log('repo file error: $e');
//       rethrow;
//     }
//   }
// }
