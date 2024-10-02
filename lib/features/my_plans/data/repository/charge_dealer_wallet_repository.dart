import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/api/api_endpoints.dart';
import '../../../../core/api/dealer_portal_api.dart';
import '../models/charge_dealer_user_wallet_res_model.dart';

final chargeDealerUserWalletRepositoryProvider = Provider(
  (ref) => ChargeDealerUserWalletRepository(),
);

class ChargeDealerUserWalletRepository {
  final api = DealerPoratlApi();

  Future<ChargeDealerUserWalletResModel> chargeWallet({
    required int reference,
    required String userId,
    required num orderId,
    required num amount,
    required String phoneNumber,
  }) async {
    try {
      final response =
          await api.post(ApiEndpoints.chargeDealerUserWallet, body: {
        "userId": userId,
        "hotspotId": 2,
        "loop21Id": 2,
        "amount": amount,
        "clientMacAddress": "192.168.12.137",
        "clientIpAddress": "192.168.12.137",
        "reference": reference,
        "orderId": orderId,
        "note": "data_payment",
        "phoneNumber": phoneNumber,
      });

      if (response?.data is String) {
        return ChargeDealerUserWalletResModel.fromJson(
            jsonDecode(response?.data));
      } else {
        return ChargeDealerUserWalletResModel.fromJson(response?.data);
      }
    } catch (e) {
      rethrow;
    }
  }
}
