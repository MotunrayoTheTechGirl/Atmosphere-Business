import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/api/api_endpoints.dart';
import '../../../../core/api/dealer_portal_api.dart';
import '../models/get_dealer_user_details_res_model.dart';

final fetchDealerUserDetailsRepositoryProvider = Provider(
  (ref) => FetchDealerUserDetailsRepository(),
);

class FetchDealerUserDetailsRepository {
  final api = DealerPoratlApi();

  Future<GetDealerUserDetailsResModel> fetchDealerUserDetails({
    required String phoneNumber,
    required String dealerUserId,
  }) async {
    try {
      final response = await api.post(ApiEndpoints.getDealerUserDetails, body: {
        "phone_number": phoneNumber,
        "app_source": "dealer",
        "system_source": "atmosphere",
        "dealerUserId": dealerUserId,
      });

      if (response?.data is String) {
        return GetDealerUserDetailsResModel.fromJson(
            jsonDecode(response?.data));
      } else {
        return GetDealerUserDetailsResModel.fromJson(response?.data);
      }
    } catch (e) {
      rethrow;
    }
  }
}
