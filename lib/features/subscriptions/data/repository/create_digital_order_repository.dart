import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../core/api/api_endpoints.dart';
import '../../../../core/api/dealer_portal_api.dart';
import '../../../../core/storage/storage_service.dart';
import '../models/create_digital_order_res_model.dart';

final createDigitalOrderRepositoryProvider = Provider(
  (ref) => CreateDigitalOrderRepository(),
);

class CreateDigitalOrderRepository {
  final api = DealerPoratlApi();
  final secureStorageService = StorageService(
    secureStorage: const FlutterSecureStorage(),
  );

  Future<CreateDigitalOrderResModel> createDigitalOrder({
    required String reference,
    required num userId,
    required num dealerId,
    required num dealerUserId,
    required num amount,
    required num total,
    required num totalHrs,
    required List<Map<String, dynamic>> orderItems,
    required String paymentPayment,
  }) async {
    try {
      final response = await api.post(ApiEndpoints.createDigitalOrder, body: {
        "payment_method": paymentPayment,
        "dealer_id": dealerId,
        "total": total,
        "userId": userId,
        "amount": amount,
        "total_hours": totalHrs,
        "vendor_id": 1,
        "transaction_reference": reference,
        "order_items": orderItems,
        "dealer_user_id": dealerUserId
      });

      if (response?.data is String) {
        return CreateDigitalOrderResModel.fromJson(jsonDecode(response?.data));
      } else {
        return CreateDigitalOrderResModel.fromJson(response?.data);
      }
    } catch (e) {
      rethrow;
    }
  }
}
