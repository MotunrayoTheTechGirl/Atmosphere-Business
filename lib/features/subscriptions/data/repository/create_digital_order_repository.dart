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
    required num amount,
    required num total,
    required num totalHrs,
    required List<Map<String, dynamic>> orderItems,
  }) async {
    try {
      final response = await api.post(ApiEndpoints.createDigitalOrder, body: {
        "payment_method": "wema",
        "dealer_id": dealerId,
        "total": total,
        "userId": userId,
        "amount": amount,
        "total_hours": totalHrs,
        "vendor_id": 1,
        "transaction_reference": reference,
        "order_items": orderItems,
        // [
        //   {
        //     "product_id": 8,
        //     "order_quantity": 1,
        //     "unit_price": 22200000,
        //     "subtotal": 22200000,
        //     "item_name": "Glo Atmosphere Plan",
        //     "total_hours": 100000,
        //     "validity": 365,
        //     "vendor_id": 0,
        //     "dealer_id": 1,
        //     "sub_dealer": 0,
        //     "discount": 0
        //   }
        // ]
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
