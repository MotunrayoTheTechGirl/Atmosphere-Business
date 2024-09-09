import 'dart:developer';

import 'package:dealer_portal_mobile/core/constants/app_constants.dart';
import 'package:dealer_portal_mobile/core/storage/storage_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final getQueryParamValueController = StateNotifierProvider((ref) {
  return GetQueryParamValue(FlutterSecureStorage);
});

class GetQueryParamValue extends StateNotifier {
  GetQueryParamValue(super.state);

  final secureStorageService = StorageService(
    secureStorage: const FlutterSecureStorage(),
  );

  String getQueryParamValue(String url, String paramName) {
    Uri uri = Uri.parse(url);
    return uri.queryParameters[paramName] ?? "";
  }

  getAuthDetails(String url) {
    String token = getQueryParamValue(url, "token");
    String nonce = getQueryParamValue(url, "nonce");
    log('Token: $token');
    log('Nonce: $nonce');

    secureStorageService.write(
      key: AppConstants.token,
      value: token,
    );
    secureStorageService.write(
      key: AppConstants.nonce,
      value: nonce,
    );
  }
}
