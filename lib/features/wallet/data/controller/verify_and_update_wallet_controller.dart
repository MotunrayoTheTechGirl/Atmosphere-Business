import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/enums.dart';
import '../../../../core/response_state.dart';
import '../repository/verify_and_update_wallet_repo.dart';

final verifyAndUpdateWalletControllerProvider = StateNotifierProvider<
    VerifyAndUpdateWalletController, ResponseState<String>>((ref) {
  final verifyPayment = ref.read(verifyAndUpdateWalletRepositoryProvider);
  return VerifyAndUpdateWalletController(verifyPayment);
});

class VerifyAndUpdateWalletController
    extends StateNotifier<ResponseState<String>> {
  VerifyAndUpdateWalletController(this.verifyAndUpdateWalletRepository)
      : super(
          ResponseState(status: ResponseStatus.initial, message: ''),
        );
  final VerifyAndUpdateWalletRepository verifyAndUpdateWalletRepository;

  Future<bool> verifyPaymentAndUpdateWallet({
    required num amount,
    String? transactionType,
    String? note,
    String? paymentMethod,
    required String reference,
    String? narration,
    required String userId,
  }) async {
    state = ResponseState(status: ResponseStatus.loading, message: '');
    try {
      final response =
          await verifyAndUpdateWalletRepository.verifyAndUpdateWallet(
        amount: amount,
        reference: reference,
        userId: userId,
      );
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
