import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/enums.dart';
import '../../../../core/response_state.dart';
import '../models/create_digital_order_res_model.dart';
import '../repository/create_digital_order_repository.dart';

final createDigitalOrderControllerProvider = StateNotifierProvider<
    CreateDigitalOrderController,
    ResponseState<CreateDigitalOrderResModel>>((ref) {
  final digitalOrderProvider = ref.read(createDigitalOrderRepositoryProvider);
  return CreateDigitalOrderController(digitalOrderProvider);
});

class CreateDigitalOrderController
    extends StateNotifier<ResponseState<CreateDigitalOrderResModel>> {
  CreateDigitalOrderController(this.createDigitalOrderRepository)
      : super(
          ResponseState(status: ResponseStatus.initial, message: ''),
        );
  final CreateDigitalOrderRepository createDigitalOrderRepository;

  Future<bool> createDigitalOrders({
    required String reference,
    required num userId,
    required num dealerId,
    required num amount,
    required num total,
    required num totalHrs,
    required List<Map<String, dynamic>> orderItems,
    required String paymentMethod,
    required num dealerUserId,
  }) async {
    state = ResponseState(status: ResponseStatus.loading, message: '');
    try {
      final response = await createDigitalOrderRepository.createDigitalOrder(
          reference: reference,
          userId: userId,
          dealerId: dealerId,
          amount: amount,
          total: total,
          totalHrs: totalHrs,
          orderItems: orderItems,
          paymentPayment: paymentMethod,
          dealerUserId: dealerUserId);
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
