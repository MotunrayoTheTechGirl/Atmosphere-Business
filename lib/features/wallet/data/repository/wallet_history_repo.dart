import 'dart:convert';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import '../../../../core/api/api_endpoints.dart';
import '../../../../core/api/dealer_portal_api.dart';
import '../models/wallet_history_res_model.dart';

class WalletHistoryRepository {
  final api = DealerPoratlApi();
  var logger = Logger(
    printer: PrettyPrinter(),
  );

  Future<WalletHistoryResModel> walletHistory({required String userId}) async {
    try {
      final response = await api.get(
        '${ApiEndpoints.walletHistory}$userId',
        queryParameters: {
          "limit": 50,
          "offset": 0,
          "accountType": "dealer",
        },
      );
      log('Wallet History Response: $response');

      if (response?.data is String) {
        log('--- Is String ----');
        return WalletHistoryResModel.fromJson(jsonDecode(response?.data));
      } else {
        log('--- Is not  String ----');
        return WalletHistoryResModel.fromJson(response?.data);
      }
    } catch (e) {
      log('Wallet History error: $e');
      rethrow;
    }
  }
}

final walletHistoryRepositoryFutureProvider =
    FutureProvider.family<WalletHistoryResModel, String>((ref, userId) async {
  final history = WalletHistoryRepository();
  final historyProvider = await history.walletHistory(userId: userId);
  return historyProvider;
});
