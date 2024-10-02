import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/enums.dart';
import '../../../../core/response_state.dart';
import '../models/charge_dealer_user_wallet_res_model.dart';
import '../repository/charge_dealer_wallet_repository.dart';

final chargeDealerUserWalletControllerProvider = StateNotifierProvider<
    ChargeDealerUserWalletController,
    ResponseState<ChargeDealerUserWalletResModel>>((ref) {
  final chargeWalletProvider =
      ref.read(chargeDealerUserWalletRepositoryProvider);
  return ChargeDealerUserWalletController(chargeWalletProvider);
});

class ChargeDealerUserWalletController
    extends StateNotifier<ResponseState<ChargeDealerUserWalletResModel>> {
  ChargeDealerUserWalletController(this.chargeDealerUserWalletRepository)
      : super(
          ResponseState(status: ResponseStatus.initial, message: ''),
        );
  final ChargeDealerUserWalletRepository chargeDealerUserWalletRepository;

  Future<bool> chargeDealerWallet({
    required int reference,
    required String userId,
    required num orderId,
    required num amount,
    required String phoneNumber,
  }) async {
    state = ResponseState(status: ResponseStatus.loading, message: '');
    try {
      final response = await chargeDealerUserWalletRepository.chargeWallet(
          reference: reference,
          userId: userId,
          orderId: orderId,
          amount: amount,
          phoneNumber: phoneNumber);
      state = ResponseState(
        status: ResponseStatus.success,
        message: '',
        data: response,
      );
      return true;
    } catch (e) {
      state = ResponseState(status: ResponseStatus.error, message: "$e");
      log('Error: $e');
      return false;
    }
  }
}
