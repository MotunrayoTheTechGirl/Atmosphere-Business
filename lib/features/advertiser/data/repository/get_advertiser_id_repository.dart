import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/api/api_endpoints.dart';
import '../../../../core/api/dealer_portal_api.dart';
import '../models/get_advertiser_id_res_model.dart';

final getAdvertiserByUserIdRepositoryProvider = Provider(
  (ref) => GetAdvertiserByUserIdRepository(),
);

class GetAdvertiserByUserIdRepository {
  final api = DealerPoratlApi();

  Future<GetAdvertiserIdResModel> getadvertiserByUserId({
    required String userId,
  }) async {
    try {
      final response = await api.get('${ApiEndpoints.getAdvertiserId}$userId');
      log('get advertiser Id response: $response');

      if (response?.data is String) {
        return GetAdvertiserIdResModel.fromJson(jsonDecode(response?.data));
      } else {
        return GetAdvertiserIdResModel.fromJson(response?.data);
      }
    } catch (e) {
      if (e is DioException && e.response?.statusCode == 404) {
        throw AdvertiserNotFoundException('Advertiser not found');
      }
      rethrow;
    }
  }
}

class AdvertiserNotFoundException implements Exception {
  AdvertiserNotFoundException(this.message);
  final String message;
}
