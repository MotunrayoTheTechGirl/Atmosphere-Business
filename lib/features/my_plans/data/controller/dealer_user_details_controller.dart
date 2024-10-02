import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/enums.dart';
import '../../../../core/response_state.dart';
import '../models/get_dealer_user_details_res_model.dart';
import '../repository/dealer_user_details_repo.dart';

final fetchDealerUserDetailsControllerProvider = StateNotifierProvider<
    FetchDealerUserDetailsController,
    ResponseState<GetDealerUserDetailsResModel>>((ref) {
  final dealerUserRepo = ref.read(fetchDealerUserDetailsRepositoryProvider);
  return FetchDealerUserDetailsController(dealerUserRepo);
});

class FetchDealerUserDetailsController
    extends StateNotifier<ResponseState<GetDealerUserDetailsResModel>> {
  FetchDealerUserDetailsController(this.fetchDealerUserDetailsRepository)
      : super(
          ResponseState(status: ResponseStatus.initial, message: ''),
        );
  final FetchDealerUserDetailsRepository fetchDealerUserDetailsRepository;

  Future<bool> getDealerUserDetails({
    required String phoneNumber,
    required String dealerUserId,
  }) async {
    state = ResponseState(status: ResponseStatus.loading, message: '');
    try {
      final response =
          await fetchDealerUserDetailsRepository.fetchDealerUserDetails(
        phoneNumber: phoneNumber,
        dealerUserId: dealerUserId,
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
