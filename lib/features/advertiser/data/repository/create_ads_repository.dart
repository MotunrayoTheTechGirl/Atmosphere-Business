import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/api/dealer_portal_api.dart';
import '../models/create_ads_res_model.dart';

final createAdvertRepositoryProvider = Provider(
  (ref) => CreateAdvertRepository(),
);

class CreateAdvertRepository {
  final api = DealerPoratlApi();
  late Ref ref;

  Future<CreateAdsResModel> createAdvert({
    required num advertiserId,
    required String title,
    required String description,
    required String adType,
    required String adSize,
    required String mediaUrl,
    required String targetUrl,
    required num budget,
    required num duration,
    required String startDate,
    required String businessCategory,
    required num deviceType,
    required String callToActionText,
    required String desiredScreen,
    List? regionIds,
  }) async {
    try {
      final response = await api
          .post('https://w2kdvsgp-3000.euw.devtunnels.ms/ads/createAdvert',
              // ApiEndpoints.createAdvert,
              body: {
            "advertiser_id": advertiserId,
            "title": title,
            "description": description,
            "ad_type": adType,
            "ad_size": adSize,
            "media_url": mediaUrl,
            "target_url": targetUrl,
            "budget": budget,
            "duration": duration,
            "start_date": startDate,
            "business_category": businessCategory,
            "device_type": deviceType,
            "call_to_action_text": callToActionText,
            "desired_screen": desiredScreen,
            "region_ids": regionIds ?? []
          });

      if (response?.data is String) {
        return CreateAdsResModel.fromJson(jsonDecode(response?.data));
      } else {
        return CreateAdsResModel.fromJson(response?.data);
      }
    } catch (e) {
      rethrow;
    }
  }
}
