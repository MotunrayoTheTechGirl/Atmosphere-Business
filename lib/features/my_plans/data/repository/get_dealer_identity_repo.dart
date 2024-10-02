import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/api/api_endpoints.dart';
import '../../../../core/api/dealer_portal_api.dart';
import '../models/get_dealer_by_identity_res_model.dart';

final fetchDealerByIdentityRepositoryProvider = Provider(
  (ref) => FetchDealerByIdentityRepository(),
);

class FetchDealerByIdentityRepository {
  final api = DealerPoratlApi();

  Future<GetDealerByIdentityResModel> fetchDealerByIdentity({
    required String phoneNumber,
  }) async {
    try {
      final response =
          await api.get(ApiEndpoints.getDealerByIdentity, queryParameters: {
        "phoneNumber": phoneNumber,
      });

      if (response?.data is String) {
        return GetDealerByIdentityResModel.fromJson(jsonDecode(response?.data));
      } else {
        return GetDealerByIdentityResModel.fromJson(response?.data);
      }
    } catch (e) {
      rethrow;
    }
  }
}
