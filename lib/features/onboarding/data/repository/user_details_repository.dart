import 'dart:convert';

import 'package:dealer_portal_mobile/core/api/api_endpoints.dart';
import 'package:dealer_portal_mobile/core/api/dealer_portal_api.dart';
import 'package:dealer_portal_mobile/core/storage/storage_service.dart';
import 'package:dealer_portal_mobile/features/onboarding/data/models/user_details_res_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../core/constants/app_constants.dart';

final userDetailsRepositoryProvider = Provider(
  (ref) => UserDetailsRepository(),
);

class UserDetailsRepository {
  final api = DealerPoratlApi();
  final secureStorageService = StorageService(
    secureStorage: const FlutterSecureStorage(),
  );

  Future<LoginUserDetailsResModel> userDetails() async {
    String? token = await secureStorageService.read(key: AppConstants.token);
    String? nonce = await secureStorageService.read(key: AppConstants.nonce);
    try {
      final response = await api.post(ApiEndpoints.getUserDetails, body: {
        "nonce": nonce,
        "token": token,
        "app_source": "dealer",
        "system_source": "atmosphere"
      });
      if (response?.data is String) {
        return LoginUserDetailsResModel.fromJson(jsonDecode(response?.data));
      } else {
        return LoginUserDetailsResModel.fromJson(response?.data);
      }
    } catch (e) {
      rethrow;
    }
  }
}
