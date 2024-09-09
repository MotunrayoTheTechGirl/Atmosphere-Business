import 'dart:developer';

import 'package:dealer_portal_mobile/core/enums.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/response_state.dart';
import '../models/invoice_url_res_model.dart';
import '../repository/invoice_url_repository.dart';

final invoiceUrlControllerProvider = StateNotifierProvider<InvoiceUrlController,
    ResponseState<InvoiceUrlResModel>>((ref) {
  final invoiceUrlProvider = ref.read(invoiceUrlRepositoryProvider);
  return InvoiceUrlController(invoiceUrlProvider);
});

class InvoiceUrlController
    extends StateNotifier<ResponseState<InvoiceUrlResModel>> {
  InvoiceUrlController(this.invoiceUrlRepository)
      : super(
          ResponseState(status: ResponseStatus.initial, message: ''),
        );
  final InvoiceUrlRepository invoiceUrlRepository;

  Future<bool> uploadInvoiceUrl(
      {required int invoiceId, required String invoicefileUrl}) async {
    state = ResponseState(status: ResponseStatus.loading, message: '');
    try {
      log('invoiceUrl: $invoicefileUrl');
      log('invoiceId: $invoiceId');
      final response = await invoiceUrlRepository.invoiceUrl(
        invoiceId: invoiceId,
        invoicefileUrl: invoicefileUrl,
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
