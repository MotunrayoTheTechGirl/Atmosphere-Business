import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/api/api_endpoints.dart';
import '../../../../core/api/dealer_portal_api.dart';
import '../models/invoice_url_res_model.dart';

final invoiceUrlRepositoryProvider = Provider(
  (ref) => InvoiceUrlRepository(),
);

class InvoiceUrlRepository {
  final api = DealerPoratlApi();

  Future<InvoiceUrlResModel> invoiceUrl(
      {required int invoiceId, required String invoicefileUrl}) async {
    try {
      final response = await api.put(
        '${ApiEndpoints.invoiceUrl}$invoiceId/invoice-url',
        body: {
          'invoiceId': invoiceId,
          'invoicefileUrl':
              'https://api.wave5wireless.ng/content$invoicefileUrl.pdf?pdf=pdf'
        },
      );
      if (response?.data is String) {
        return InvoiceUrlResModel.fromJson(jsonDecode(response?.data));
      } else {
        return InvoiceUrlResModel.fromJson(response?.data);
      }
    } catch (e) {
      rethrow;
    }
  }
}
