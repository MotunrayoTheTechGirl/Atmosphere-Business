import 'dart:convert';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/api/api_endpoints.dart';
import '../../../../core/api/dealer_portal_api.dart';
import '../models/update_ads_res_model.dart';

final updateAdsRepositoryProvider = Provider(
  (ref) => UpdateAdsRepository(),
);

class UpdateAdsRepository {
  final api = DealerPoratlApi();

  Future<UpdateAdsResModel> updateAds({
    required String advertId,
    num? advertiserId,
    String? title,
    String? description,
    String? adType,
    String? status,
    String? adSize,
    String? deviceType,
    String? mediaUrl,
    String? targetUrl,
    num? budget,
    String? businessCategory,
    String? callToActionText,
    num? duration,
    String? startDate,
    String? desiredScreen,
    List? regionIds,
  }) async {
    const isoDate = 'T00:00:00.000Z';
    final formattedIsoStartDate = startDate;
    final formatStartDate = DateTime.tryParse(startDate ?? '');
    final String splitFormatStartDate =
        formatStartDate.toString().split(' ')[0];
    log('splitFormatStartDate: $splitFormatStartDate');
    final finalFormatedStartDate = splitFormatStartDate + isoDate;

//! formatting end date using start date plus duration
    final endDateDuration = duration == null
        ? null
        : formatStartDate!
                .add(Duration(days: duration.toInt()))
                .toString()
                .split(' ')[0] +
            isoDate;
    log('end date duration: $endDateDuration');
    try {
      final response =
          await api.post('${ApiEndpoints.updateAds}$advertId', body: {
        "advertiserId": advertiserId,
        "title": title,
        "description": description,
        "type": adType,
        "status": status,
        "size": adSize,
        "device_type": deviceType,
        "displayContentUrl": mediaUrl,
        "target_url": targetUrl,
        "budget": budget,
        "category": businessCategory,
        "callToActionText": callToActionText,
        "duration": duration,
        "startDate": finalFormatedStartDate,
        "endDate": endDateDuration,
        "screens": desiredScreen,
        "region_ids": regionIds ?? []
      });
      log('update ads response: $response');
      if (response?.data is String) {
        return UpdateAdsResModel.fromJson(jsonDecode(response?.data));
      } else {
        return UpdateAdsResModel.fromJson(response?.data);
      }
    } catch (e) {
      rethrow;
    }
  }
}
