import 'dart:convert';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import '../../../../core/api/api_endpoints.dart';
import '../../../../core/api/dealer_portal_api.dart';
import '../models/get_adverts_res_model.dart';

class GetAdvertsByAdvertiserRepository {
  final api = DealerPoratlApi();
  var logger = Logger(
    printer: PrettyPrinter(),
  );

  Future<List<GetAdsByAdvertiserIdResModel>> getAdvertsByAdvertiserId({
    required String advertiserId,
  }) async {
    try {
      final response =
          await api.get('${ApiEndpoints.getAdsByAdvertiserId}$advertiserId');
      log('Get Adverts Response: $response');

      if (response?.data is String) {
        // return GetAdsByAdvertiserIdResModel.fromJson(jsonDecode(response?.data));
        List<GetAdsByAdvertiserIdResModel> adverts = response?.data
            .map((item) =>
                GetAdsByAdvertiserIdResModel.fromJson(jsonDecode(item)))
            .toList();
        return adverts;
      } else {
        // return GetAdsByAdvertiserIdResModel.fromJson(response?.data);
        List<GetAdsByAdvertiserIdResModel> adverts = response?.data
            .map((item) => GetAdsByAdvertiserIdResModel.fromJson(item))
            .toList();
        return adverts;
      }
    } catch (e) {
      log('get Adverts error: $e');
      rethrow;
    }
  }
}

final getAdvertsByAdvertiserRepositoryFutureProvider =
    FutureProvider.family<List<GetAdsByAdvertiserIdResModel>, String>(
        (ref, userId) async {
  final getAdverts = GetAdvertsByAdvertiserRepository();
  final getAdvertiserIdProvider =
      await getAdverts.getAdvertsByAdvertiserId(advertiserId: userId);
  return getAdvertiserIdProvider;
});
