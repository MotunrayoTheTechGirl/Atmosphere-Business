import 'dart:convert';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/api/api_endpoints.dart';
import '../../../../core/api/dealer_portal_api.dart';
import '../models/change_advert_status_res_model.dart';

final changeAdvertStatusRepositoryProvider = Provider(
  (ref) => ChangeAdvertStatusRepository(),
);

class ChangeAdvertStatusRepository {
  final api = DealerPoratlApi();

  Future<ChangeAdvertStatusResModel> changeAdvertStatus({
    required String advertId,
    required String status,
  }) async {
    try {
      final response = await api.put(ApiEndpoints.changeAdvertStatus, body: {
        "status": status,
        "advertId": advertId,
        "reason": "",
      });
      log('change status response: $response');
      if (response?.data is String) {
        return ChangeAdvertStatusResModel.fromJson(jsonDecode(response?.data));
      } else {
        return ChangeAdvertStatusResModel.fromJson(response?.data);
      }
    } catch (e) {
      log('change status error: $e');
      rethrow;
    }
  }
}
