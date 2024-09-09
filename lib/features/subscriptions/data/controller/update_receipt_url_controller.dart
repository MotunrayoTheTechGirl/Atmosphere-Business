import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/enums.dart';
import '../../../../core/response_state.dart';
import '../models/update_receipt_res_model.dart';
import '../repository/update_receipt_url_repository.dart';

final updateReceiptUrlControllerProvider = StateNotifierProvider<
    UpdateReceiptUrlController, ResponseState<UpdateReceiptUrlResModel>>((ref) {
  final receiptUrlProvider = ref.read(updateReceiptUrlRepositoryProvider);
  return UpdateReceiptUrlController(receiptUrlProvider);
});

class UpdateReceiptUrlController
    extends StateNotifier<ResponseState<UpdateReceiptUrlResModel>> {
  UpdateReceiptUrlController(this.updateReceiptUrlRepository)
      : super(
          ResponseState(status: ResponseStatus.initial, message: ''),
        );
  final UpdateReceiptUrlRepository updateReceiptUrlRepository;

  Future<bool> updateReceiptUrl(
      {required int invoiceId, required String receiptfileUrl}) async {
    state = ResponseState(status: ResponseStatus.loading, message: '');
    try {
      final response = await updateReceiptUrlRepository.updateReceipt(
        invoiceId: invoiceId,
        receiptfileUrl: receiptfileUrl,
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
