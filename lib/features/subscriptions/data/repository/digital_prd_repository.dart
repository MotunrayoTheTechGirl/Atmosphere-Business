import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';

import '../../../../core/api/api_endpoints.dart';
import '../../../../core/api/dealer_portal_api.dart';
import '../../../../core/storage/storage_service.dart';
import '../models/get_digital_products_res_model.dart';

class DigitalPrdRepository {
  final api = DealerPoratlApi();
  var logger = Logger(
    printer: PrettyPrinter(),
  );
  final secureStorageService = StorageService(
    secureStorage: const FlutterSecureStorage(),
  );

  Future<List<DigitalProductsResModel>> atmosphereDitialProduct() async {
    try {
      final response = await api.get(
        '${ApiEndpoints.getDigitalPrd}/1',
      );
      if (response?.data is String) {
        final jsonResponse = jsonDecode(response?.data) as List<dynamic>;
        logger.d('jsonResponse: $jsonResponse');
        final List<DigitalProductsResModel> products = jsonResponse
            .map((prd) => DigitalProductsResModel.fromJson(prd))
            .toList();
        logger.i('products: $products');
        return products;
      } else {
        final jsonResponse = response?.data as List<dynamic>;
        logger.e('jsonResponse Error: $jsonResponse');
        final List<DigitalProductsResModel> products = jsonResponse
            .map((prd) => DigitalProductsResModel.fromJson(prd))
            .toList();
        logger.e('products error: $products');
        return products;
      }
    } catch (e) {
      rethrow;
    }
  }
}

final fetchDigitalPrdProvider =
    FutureProvider<List<DigitalProductsResModel>>((ref) async {
  final digitalPrd = DigitalPrdRepository();
  final digitalPrdProvider = await digitalPrd.atmosphereDitialProduct();
  return digitalPrdProvider;
});
