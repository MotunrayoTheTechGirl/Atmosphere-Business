import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/api/api_endpoints.dart';
import '../../../../core/api/dealer_portal_api.dart';

final verifyAndUpdateWalletRepositoryProvider = Provider(
  (ref) => VerifyAndUpdateWalletRepository(),
);

class VerifyAndUpdateWalletRepository {
  final api = DealerPoratlApi();

  Future<String> verifyAndUpdateWallet({
    required num amount,
    String? transactionType,
    String? note,
    String? paymentMethod,
    required String reference,
    String? narration,
    required String userId,
  }) async {
    try {
      final response = await api.post(
        ApiEndpoints.verifyPaymentAndUpdateWallet,
        body: {
          'amount': amount,
          'transaction_type': transactionType ?? 'fund_wallet',
          'note': note ?? 'Fund Wallet',
          'payment_method': paymentMethod ?? 'paystack',
          'reference': reference,
          'narration': narration ?? 'Fund Wallet',
          'userId': userId,
          'system_source': "atmosphere",
          'platform_source': "dealer",
          'accountType': "dealer"
        },
      );
      log('verifyPaymentAndUpdateWallet response: $response');
      return response?.data;
    } catch (e) {
      rethrow;
    }
  }
}
