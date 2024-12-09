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
    log('start date: $startDate');
    final formattedIsoStartDate = startDate;

    final formatStartDate = DateTime.tryParse(startDate ?? '');
    final String splitFormatStartDate =
        formatStartDate.toString().split(' ')[0];
    log('splitFormatStartDate: $splitFormatStartDate');
    final finalFormatedStartDate =
        startDate == null ? null : splitFormatStartDate + isoDate;

//! formatting end date using start date plus duration
    final endDateDuration = duration == null
        ? null
        : formatStartDate!
                .add(Duration(days: duration.toInt()))
                .toString()
                .split(' ')[0] +
            isoDate;
    log('end date duration: $endDateDuration');
    log('desitred screen: $desiredScreen');

    //! formating desired screen
    String? formatDesiredScreen(String? selectedScreen) {
      if (selectedScreen == 'Welcome Screen') {
        return 'welcome';
      } else if (selectedScreen == 'SignUp/ Login Screen') {
        return 'signup_login';
      } else if (selectedScreen == 'Dashboard Screen') {
        return 'dashboard';
      } else if (selectedScreen == 'All Screen') {
        return 'all';
      } else if (selectedScreen == 'Login Screen') {
        return 'login';
      } else if (selectedScreen == 'Data and subscription Screen') {
        return 'data_subscription';
      }
      return null;
    }

    try {
      final response = await api.post(ApiEndpoints.createAdvert, body: {
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
        "screens": formatDesiredScreen(desiredScreen),
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
