import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/enums.dart';
import '../../../../core/response_state.dart';
import '../models/create_digital_product_res_model.dart';
import '../repository/create_digital_prd_repo.dart';

final createDigitalProductsControllerProvider = StateNotifierProvider<
    CreateDigitalProductsController,
    ResponseState<CreateDigitalProductResModel>>((ref) {
  final createDigitalProducts =
      ref.read(createDigitalProductsRepositoryProvider);
  return CreateDigitalProductsController(createDigitalProducts);
});

class CreateDigitalProductsController
    extends StateNotifier<ResponseState<CreateDigitalProductResModel>> {
  CreateDigitalProductsController(this.createDigitalProductsRepository)
      : super(
          ResponseState(status: ResponseStatus.initial, message: ''),
        );
  final CreateDigitalProductsRepository createDigitalProductsRepository;

  Future<bool> createDigitalPrd({
    required num amount,
  }) async {
    state = ResponseState(status: ResponseStatus.loading, message: '');
    try {
      final response = await createDigitalProductsRepository.createDigitalPrd(
        price: amount,
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
