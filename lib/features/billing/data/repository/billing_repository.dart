import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import '../../../../core/api/api_endpoints.dart';
import '../../../../core/api/dealer_portal_api.dart';
import '../models/invoice_billing_res_model.dart';

class BillingRepository {
  final api = DealerPoratlApi();
  var logger = Logger(
    printer: PrettyPrinter(),
  );

  Future<List<BillingResModel>> fetchAllInvoice() async {
    try {
      final response = await api.get(ApiEndpoints.getBillingInvoice);

      if (response?.data is String) {
        final jsonResponse = jsonDecode(response?.data) as List<dynamic>;
        final List<BillingResModel> billing =
            jsonResponse.map((e) => BillingResModel.fromJson(e)).toList();
        logger.i('billing: $billing');
        return billing;
      } else {
        final jsonResponse = response?.data as List<dynamic>;
        final List<BillingResModel> billing =
            jsonResponse.map((e) => BillingResModel.fromJson(e)).toList();
        logger.e('billing: $billing');
        return billing;
      }
    } catch (e) {
      rethrow;
    }
  }
}

final billingRepositoryFutureProvider =
    FutureProvider<List<BillingResModel>>((ref) async {
  final invoices = BillingRepository();
  final invoicesProvider = await invoices.fetchAllInvoice();
  return invoicesProvider;
});
