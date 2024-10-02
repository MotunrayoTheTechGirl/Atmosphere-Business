import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/enums.dart';
import '../../../../core/response_state.dart';
import '../models/get_dealer_by_identity_res_model.dart';
import '../repository/get_dealer_identity_repo.dart';

final fetchDealerByIdentityControllerProvider = StateNotifierProvider<
    FetchDealerByIdentityController,
    ResponseState<GetDealerByIdentityResModel>>((ref) {
  final dealerIdentity = ref.read(fetchDealerByIdentityRepositoryProvider);
  return FetchDealerByIdentityController(dealerIdentity);
});

class FetchDealerByIdentityController
    extends StateNotifier<ResponseState<GetDealerByIdentityResModel>> {
  FetchDealerByIdentityController(this.fetchDealerByIdentityRepository)
      : super(
          ResponseState(status: ResponseStatus.initial, message: ''),
        );
  final FetchDealerByIdentityRepository fetchDealerByIdentityRepository;

  Future<bool> dealerIdentity({
    required String phoneNumber,
  }) async {
    state = ResponseState(status: ResponseStatus.loading, message: '');
    try {
      final response =
          await fetchDealerByIdentityRepository.fetchDealerByIdentity(
        phoneNumber: phoneNumber,
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
