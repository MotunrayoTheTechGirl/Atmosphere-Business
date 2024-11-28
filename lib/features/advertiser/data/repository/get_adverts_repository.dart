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

      if (response?.data is List) {
        final List<dynamic> dataList = response?.data as List<dynamic>;
        return dataList
            .map((item) => GetAdsByAdvertiserIdResModel.fromJson(item))
            .toList();
      } else if (response?.data is String) {
        final List<dynamic> dataList =
            jsonDecode(response?.data) as List<dynamic>;
        return dataList
            .map((item) => GetAdsByAdvertiserIdResModel.fromJson(item))
            .toList();
      } else {
        throw Exception(
            'Unexpected data format: ${response?.data.runtimeType}');
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
  return await getAdverts.getAdvertsByAdvertiserId(advertiserId: userId);
});
