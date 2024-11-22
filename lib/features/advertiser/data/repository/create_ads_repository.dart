import 'dart:convert';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/api/api_endpoints.dart';
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
    required String deviceType,
    required String mediaUrl,
    required String targetUrl,
    required num budget,
    required String businessCategory,
    required String callToActionText,
    required num duration,
    required String startDate,
    required String desiredScreen,
    List? regionIds,
  }) async {
    const isoDate = 'T00:00:00.000Z';
    final formattedIsoStartDate = startDate + isoDate;
    final formatStartDate = DateTime.parse(startDate);
    final endDateDuration = formatStartDate
            .add(Duration(days: duration.toInt()))
            .toString()
            .split(' ')[0] +
        isoDate;
    log('end date duration: $endDateDuration');

    try {
      final response = await api.post(ApiEndpoints.createAdvert, body: {
        "advertiserId": advertiserId,
        "title": title,
        "description": description,
        "type": adType,
        "size": adSize,
        "device_type": deviceType,
        "displayContentUrl": mediaUrl,
        "target_url": targetUrl,
        "budget": budget,
        "category": businessCategory,
        "callToActionText": callToActionText,
        "duration": duration,
        "startDate": formattedIsoStartDate,
        "endDate": endDateDuration,
        "screens": desiredScreen,
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
