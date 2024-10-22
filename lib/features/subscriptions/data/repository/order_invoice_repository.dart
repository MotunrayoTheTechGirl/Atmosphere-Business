import 'dart:convert';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';

import '../../../../core/api/api_endpoints.dart';
import '../../../../core/api/dealer_portal_api.dart';
import '../../../../core/storage/storage_service.dart';
import '../models/order_invoice_res_model.dart';

class OrderInvoiceRepository {
  final api = DealerPoratlApi();
  var logger = Logger(
    printer: PrettyPrinter(),
  );
  final secureStorageService = StorageService(
    secureStorage: const FlutterSecureStorage(),
  );

  Future<OrderInvoiceResModel> orderInvoice({required num orderId}) async {
    log('orderId....');
    log('--order id--: $orderId');
    try {
      final response = await api.get(
        '${ApiEndpoints.generateInvoice}/$orderId',
        headers: {
          "system_source": "atmosphere",
          "app_source": "dealer",
        },
      );
      if (response?.data is String) {
        return OrderInvoiceResModel.fromJson(
          jsonDecode(response?.data),
        );
      } else {
        return OrderInvoiceResModel.fromJson(response?.data);
      }
    } catch (e) {
      rethrow;
    }
  }
}

final orderInvoiceRepositoryFutureProvider =
    FutureProvider.family<OrderInvoiceResModel, num>((ref, orderId) async {
  final invoice = OrderInvoiceRepository();
  final invoiceProvider = await invoice.orderInvoice(orderId: orderId);
  return invoiceProvider;
});
