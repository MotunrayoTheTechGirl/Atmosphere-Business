import 'dart:convert';

import 'package:dealer_portal_mobile/core/api/api_endpoints.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../core/api/dealer_portal_api.dart';
import '../../../../core/storage/storage_service.dart';
import '../models/user_balance_res_model.dart';

final userBalanceRepositoryProvider = Provider(
  (ref) => FetchUserBalanceRepository(),
);

class FetchUserBalanceRepository {
  final api = DealerPoratlApi();
  final secureStorageService = StorageService(
    secureStorage: const FlutterSecureStorage(),
  );

  Future<UserBalanceResModel> userBalance({required String userId}) async {
    try {
      final response = await api.get('${ApiEndpoints.userBalance}$userId');

      if (response?.data is String) {
        return UserBalanceResModel.fromJson(jsonDecode(response?.data));
      } else {
        return UserBalanceResModel.fromJson(response?.data);
      }
    } catch (e) {
      rethrow;
    }
  }
}
