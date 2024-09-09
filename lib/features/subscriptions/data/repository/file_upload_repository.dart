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
      return response?.data;
    } catch (e) {
      rethrow;
    }
  }
}
