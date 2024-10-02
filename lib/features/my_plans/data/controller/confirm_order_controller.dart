import 'dart:developer';

import 'package:dealer_portal_mobile/features/my_plans/data/repository/confirm_order_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/enums.dart';
import '../../../../core/response_state.dart';

final confirmOrderControllerProvider =
    StateNotifierProvider<ConfirmOrderController, ResponseState<bool>>((ref) {
  final orderProvider = ref.read(confirmOrderRepositoryProvider);
  return ConfirmOrderController(orderProvider);
});

class ConfirmOrderController extends StateNotifier<ResponseState<bool>> {
  ConfirmOrderController(this.confirmOrderRepository)
      : super(
          ResponseState(status: ResponseStatus.initial, message: ''),
        );
  final ConfirmOrderRepository confirmOrderRepository;

  Future<bool> confirmOrder({
    required num orderId,
    required String email,
    required num dealerId,
    required String dealerPhoneNumber,
    required String orderCode,
  }) async {
    state = ResponseState(status: ResponseStatus.loading, message: '');
    try {
      final response = await confirmOrderRepository.confirmOrder(
          orderId: orderId,
          email: email,
          dealerId: dealerId,
          dealerPhoneNumber: dealerPhoneNumber,
          orderCode: orderCode);
      state = ResponseState(
        status: ResponseStatus.success,
        message: '',
        data: response,
      );
      return true;
    } catch (e) {
      state = ResponseState(status: ResponseStatus.error, message: "$e");
      log('Error ctrl: $e');
      return false;
    }
  }
}
