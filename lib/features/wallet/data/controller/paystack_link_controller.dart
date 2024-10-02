import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/enums.dart';
import '../../../../core/response_state.dart';
import '../models/paystack_link_res_model.dart';
import '../repository/paystack_link_repo.dart';

final generatePaystackLinResModelProvider = StateNotifierProvider<
    GeneratePayStackLinkController,
    ResponseState<GeneratePaystackLinResModel>>((ref) {
  final paymentLink = ref.read(generatePaystackLinkRepositoryProvider);
  return GeneratePayStackLinkController(paymentLink);
});

class GeneratePayStackLinkController
    extends StateNotifier<ResponseState<GeneratePaystackLinResModel>> {
  GeneratePayStackLinkController(this.generatePaystackLinkRepository)
      : super(
          ResponseState(status: ResponseStatus.initial, message: ''),
        );
  final GeneratePaystackLinkRepository generatePaystackLinkRepository;

  Future<bool> paystackPaymentLink({
    required String identity,
    required num amount,
    required String reference,
  }) async {
    state = ResponseState(status: ResponseStatus.loading, message: '');
    try {
      final response = await generatePaystackLinkRepository.paystackLink(
          identity: identity, amount: amount, reference: reference);
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
