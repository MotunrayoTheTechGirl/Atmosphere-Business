import 'dart:developer';

import 'package:dealer_portal_mobile/core/response_state.dart';
import 'package:dealer_portal_mobile/features/onboarding/data/models/user_details_res_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/enums.dart';
import '../repository/user_details_repository.dart';

final userDetailsControllerProvider = StateNotifierProvider<
    UserDetailsController, ResponseState<LoginUserDetailsResModel>>((ref) {
  final getUserRepositoryProvider = ref.read(userDetailsRepositoryProvider);
  return UserDetailsController(getUserRepositoryProvider);
});

class UserDetailsController
    extends StateNotifier<ResponseState<LoginUserDetailsResModel>> {
  UserDetailsController(this.userDetailsRepository)
      : super(
          ResponseState(status: ResponseStatus.initial, message: ''),
        );
  final UserDetailsRepository userDetailsRepository;

  Future<bool> getUserDetails() async {
    state = ResponseState(status: ResponseStatus.loading, message: '');
    try {
      final response = await userDetailsRepository.userDetails();
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
