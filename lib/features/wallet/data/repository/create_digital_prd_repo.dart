import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/api/api_endpoints.dart';
import '../../../../core/api/dealer_portal_api.dart';
import '../models/create_digital_product_res_model.dart';

final createDigitalProductsRepositoryProvider = Provider(
  (ref) => CreateDigitalProductsRepository(),
);

class CreateDigitalProductsRepository {
  final api = DealerPoratlApi();

  Future<CreateDigitalProductResModel> createDigitalPrd(
      {required num price}) async {
    try {
      final response = await api.post(
        ApiEndpoints.createDigitalProducts,
        body: {
          "name": "Wallet Funding",
          "slug": "wallet-funding",
          "description": "Wallet Funding",
          "product_type": "dealer",
          "price": price,
          "vendor_id": 101,
          "hours": 1,
          "total_bandwidth": "string",
          "total_validity": 365,
          "dealer_id": 202,
          "sub_dealer_id": 303,
          "sale_price": 300,
          "sku": "VPN-001",
          "is_taxable": false,
          "status": "publish",
          "image": "string",
          "is_deleted": false,
          "is_disable": false,
          "bukket_id": 404,
          "is_combined": false,
          "vendor_plan_id": "",
          "is_auto_created": true
        },
      );

      if (response?.data is String) {
        return CreateDigitalProductResModel.fromJson(
            jsonDecode(response?.data));
      } else {
        return CreateDigitalProductResModel.fromJson(response?.data);
      }
    } catch (e) {
      rethrow;
    }
  }
}
