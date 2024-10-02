import 'dart:convert';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import '../../../../core/api/api_endpoints.dart';
import '../../../../core/api/dealer_portal_api.dart';
import '../models/captive_prd_res_model.dart';

class MyPlanRepository {
  final api = DealerPoratlApi();
  var logger = Logger(
    printer: PrettyPrinter(),
  );

  Future<CaptiveDigitalPrdResModel> fetchCaptivePlans() async {
    log('Captive');
    try {
      final response = await api.get(ApiEndpoints.getCaptiveDigitalPlans);
      log('Captive Response: $response');

      if (response?.data is String) {
        log('--- Is String ----');
        return CaptiveDigitalPrdResModel.fromJson(jsonDecode(response?.data));
      } else {
        log('--- Is not  String ----');
        return CaptiveDigitalPrdResModel.fromJson(response?.data);
      }
    } catch (e) {
      log('Captive error: $e');
      rethrow;
    }
  }
}

final captiveProductsFutureProvider =
    FutureProvider<CaptiveDigitalPrdResModel>((ref) async {
  final dataPlans = MyPlanRepository();
  final dataPlansProvider = await dataPlans.fetchCaptivePlans();
  return dataPlansProvider;
});
