import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import '../../../../core/api/api_endpoints.dart';
import '../../../../core/api/dealer_portal_api.dart';
import '../models/transaction_history_res_model.dart';

class TransactionHistoryRepository {
  final api = DealerPoratlApi();
  var logger = Logger(
    printer: PrettyPrinter(),
  );

  Future<GetDigitalOrdersResModel> transactionHistory(
      {required int userId}) async {
    try {
      // final userId = ref.watch(userDetailsControllerProvider);
      final response = await api
          .get('${ApiEndpoints.getDigitalOrders}$userId', queryParameters: {
        "page": 1,
        "pageSize": 8,
      });
      if (response?.data is String) {
        return GetDigitalOrdersResModel.fromJson(jsonDecode(response?.data));
      } else {
        return GetDigitalOrdersResModel.fromJson(response?.data);
      }
    } catch (e) {
      rethrow;
    }
  }
}

final transactionHistoryFutureProvider =
    FutureProvider.family<GetDigitalOrdersResModel, int>((ref, userId) async {
  final history = TransactionHistoryRepository();
  final historyProvider = await history.transactionHistory(userId: userId);
  return historyProvider;
});
