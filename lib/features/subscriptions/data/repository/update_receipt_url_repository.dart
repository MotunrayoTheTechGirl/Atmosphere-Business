import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/api/api_endpoints.dart';
import '../../../../core/api/dealer_portal_api.dart';
import '../models/update_receipt_res_model.dart';

final updateReceiptUrlRepositoryProvider = Provider(
  (ref) => UpdateReceiptUrlRepository(),
);

class UpdateReceiptUrlRepository {
  final api = DealerPoratlApi();

  Future<UpdateReceiptUrlResModel> updateReceipt(
      {required int invoiceId, required String receiptfileUrl}) async {
    try {
      final response = await api.put(
        '${ApiEndpoints.receiptUrl}$invoiceId/billing-receipt-url',
        body: {
          'invoiceId': invoiceId,
          'recieptfileUrl':
              'https://api.wave5wireless.ng/content$receiptfileUrl',
        },
      );
      if (response?.data is String) {
        return UpdateReceiptUrlResModel.fromJson(jsonDecode(response?.data));
      } else {
        return UpdateReceiptUrlResModel.fromJson(response?.data);
      }
    } catch (e) {
      rethrow;
    }
  }
}
