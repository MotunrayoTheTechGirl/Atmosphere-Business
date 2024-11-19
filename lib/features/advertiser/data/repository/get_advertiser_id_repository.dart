import 'dart:convert';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import '../../../../core/api/api_endpoints.dart';
import '../../../../core/api/dealer_portal_api.dart';
import '../models/get_advertiser_id_res_model.dart';

// final getAdvertiserByUserIdRepositoryProvider = Provider(
//   (ref) => GetAdvertiserByUserIdRepository(),
// );

// class GetAdvertiserByUserIdRepository {
//   final api = DealerPoratlApi();

//   Future<GetAdvertiserIdResModel> getadvertiserByUserId({
//     required String userId,
//   }) async {
//     try {
//       final response = await api.get('${ApiEndpoints.getAdvertiserId}$userId');
//       log('get advertiser Id response: $response');
//       if (response?.data is String) {
//         return GetAdvertiserIdResModel.fromJson(jsonDecode(response?.data));
//       } else {
//         return GetAdvertiserIdResModel.fromJson(response?.data);
//       }
//     } catch (e) {
//       rethrow;
//     }
//   }
// }

class GetAdvertiserByUserIdRepository {
  final api = DealerPoratlApi();
  var logger = Logger(
    printer: PrettyPrinter(),
  );

  Future<GetAdvertiserIdResModel> getadvertiserByUserId({
    required String userId,
  }) async {
    try {
      final response = await api.get('${ApiEndpoints.getAdvertiserId}$userId');
      log('AdvertiserByUserId Response: $response');

      if (response?.data is String) {
        return GetAdvertiserIdResModel.fromJson(jsonDecode(response?.data));
      } else {
        return GetAdvertiserIdResModel.fromJson(response?.data);
      }
    } catch (e) {
      log('AdvertiserByUserId error: $e');
      rethrow;
    }
  }
}

final getAdvertiserByUserIdRepositoryFutureProvider =
    FutureProvider.family<GetAdvertiserIdResModel, String>((ref, userId) async {
  final getAdvertiserId = GetAdvertiserByUserIdRepository();
  final getAdvertiserIdProvider =
      await getAdvertiserId.getadvertiserByUserId(userId: userId);
  return getAdvertiserIdProvider;
});
