import 'dart:convert';
import 'dart:developer';

import 'package:dealer_portal_mobile/core/api/api_endpoints.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import '../../../../core/api/dealer_portal_api.dart';
import '../models/region_res_model.dart';

class FetchAdsRegionRepository {
  final api = DealerPoratlApi();
  var logger = Logger(
    printer: PrettyPrinter(),
  );

  Future<RegionResModel> fetchRegion() async {
    try {
      final response = await api.get(ApiEndpoints.advertsRegion);
      log('Advert region Response: $response');

      if (response?.data is String) {
        return RegionResModel.fromJson(jsonDecode(response?.data));
      } else {
        return RegionResModel.fromJson(response?.data);
      }
    } catch (e) {
      log('Advert regiond error: $e');
      rethrow;
    }
  }
}

final adsRegionRepositoryFutureProvider =
    FutureProvider<RegionResModel>((ref) async {
  final region = FetchAdsRegionRepository();
  final regionProvider = region.fetchRegion();
  return regionProvider;
});
