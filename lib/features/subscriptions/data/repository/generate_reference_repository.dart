import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/api/api_endpoints.dart';
import '../../../../core/api/dealer_portal_api.dart';

final generateReferenceRepositoryProvider = Provider(
  (ref) => GenerateReferenceRepository(),
);

class GenerateReferenceRepository {
  final api = DealerPoratlApi();

  Future<String> reference(
      {required num amount, required String userId}) async {
    try {
      final response = await api.post(ApiEndpoints.generateReference, body: {
        "amount": amount,
        "transaction_type": "data_payment",
        "note": "Payment for services",
        "payment_method": "wema",
        "narration": "Additional details",
        "userId": userId,
        "system_source": "atmosphere",
        "platform_source": "dealer"
      });
      return response?.data;
    } catch (e) {
      rethrow;
    }
  }
}
