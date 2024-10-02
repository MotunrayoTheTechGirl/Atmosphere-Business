import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/api/api_endpoints.dart';
import '../../../../core/api/dealer_portal_api.dart';

final confirmOrderRepositoryProvider = Provider(
  (ref) => ConfirmOrderRepository(),
);

class ConfirmOrderRepository {
  final api = DealerPoratlApi();
  Future<bool> confirmOrder({
    required num orderId,
    required String email,
    required num dealerId,
    required String dealerPhoneNumber,
    required String orderCode,
  }) async {
    try {
      final response = await api.post(ApiEndpoints.confirmOrder, body: {
        "orderId": orderId,
        "email": email,
        "dealerId": dealerId,
        "dealer_phone_number": dealerPhoneNumber,
        "order_code": orderCode,
      });
      log('confirm order response: $response');
      log('confirm order response runtime: ${response.runtimeType}');
      log('confirm order response data: ${response?.data}');
      log('confirm order response data type: ${response?.data.runtimeType}');
      if (response?.data is bool) {
        return response?.data as bool;
      } else if (response?.data is String) {
        final lowercaseData = (response?.data as String).toLowerCase();
        if (lowercaseData == 'true') return true;
        if (lowercaseData == 'false') return false;
        throw Exception(
            'Response data is a string but not "true" or "false": ${response?.data}');
      } else if (response?.data is Map) {
        return response?.data['success'] == true;
      } else {
        throw Exception(
            'Unexpected response data type: ${response?.data.runtimeType}');
      }
    } catch (e) {
      log('Error in confirmOrder: $e');
      rethrow;
    }
  }
}
