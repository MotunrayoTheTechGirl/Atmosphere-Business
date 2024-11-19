import 'dart:convert';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/api/api_endpoints.dart';
import '../../../../core/api/dealer_portal_api.dart';
import '../models/create_advertiser_res_model.dart';

final createAdvertiserRepositoryProvider = Provider(
  (ref) => CreateAdvertiserRepository(),
);

class CreateAdvertiserRepository {
  final api = DealerPoratlApi();

  Future<CreateAdvertiserResModel> createAdvertiser({
    required String name,
    required String businessName,
    required num userId,
    required String email,
    String? businessCategory,
    String? businessAddress,
  }) async {
    try {
      final response = await api.post(ApiEndpoints.createAdvertiser, body: {
        "name": name,
        "business_name": businessName,
        "user_id": userId,
        "business_category": businessCategory,
        "business_address": businessAddress,
      });
      log('Create Advertizer response: $response');
      if (response?.data is String) {
        return CreateAdvertiserResModel.fromJson(jsonDecode(response?.data));
      } else {
        return CreateAdvertiserResModel.fromJson(response?.data);
      }
    } catch (e) {
      rethrow;
    }
  }
}
