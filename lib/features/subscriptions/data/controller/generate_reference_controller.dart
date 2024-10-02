import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/enums.dart';
import '../../../../core/response_state.dart';
import '../repository/generate_reference_repository.dart';

final generateReferenceControllerProvider =
    StateNotifierProvider<GenerateReferenceController, ResponseState<String>>(
        (ref) {
  final referenceProvider = ref.read(generateReferenceRepositoryProvider);
  return GenerateReferenceController(referenceProvider);
});

class GenerateReferenceController extends StateNotifier<ResponseState<String>> {
  GenerateReferenceController(this.generateReferenceRepository)
      : super(
          ResponseState(status: ResponseStatus.initial, message: ''),
        );
  final GenerateReferenceRepository generateReferenceRepository;

  Future<bool> generateReference({
    required num amount,
    required String userId,
    required String paymentMethod,
    String? transactionType,
    String? note,
  }) async {
    state = ResponseState(status: ResponseStatus.loading, message: '');
    try {
      final response = await generateReferenceRepository.reference(
        amount: amount,
        userId: userId,
        paymentMethod: paymentMethod,
        note: note,
        transactionType: transactionType,
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
