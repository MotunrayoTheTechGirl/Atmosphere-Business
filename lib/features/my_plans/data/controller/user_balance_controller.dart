import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/enums.dart';
import '../../../../core/response_state.dart';
import '../../../onboarding/data/controller/user_details_controller.dart';
import '../models/user_balance_res_model.dart';
import '../repository/user_balance_repository.dart';

// final fetchUserBalanceControllerProvider = StateNotifierProvider<
//     FetchUserBalanceController, ResponseState<UserBalanceResModel>>((ref) {
//   final balanceProvider = ref.read(userBalanceRepositoryProvider);
//   return FetchUserBalanceController(balanceProvider);
// });

// class FetchUserBalanceController
//     extends StateNotifier<ResponseState<UserBalanceResModel>> {
//   FetchUserBalanceController(this.fetchUserBalanceRepository)
//       : super(
//           ResponseState(status: ResponseStatus.initial, message: ''),
//         );
//   final FetchUserBalanceRepository fetchUserBalanceRepository;

//   Future<bool> userBalance({required String userId}) async {
//     state = ResponseState(status: ResponseStatus.loading, message: '');
//     try {
//       final response =
//           await fetchUserBalanceRepository.userBalance(userId: userId);
//       state = ResponseState(
//         status: ResponseStatus.success,
//         message: '',
//         data: response,
//       );
//       return true;
//     } catch (e) {
//       state = ResponseState(status: ResponseStatus.error, message: "$e");
//       log('Error: $e');
//       return false;
//     }
//   }
// }

final fetchUserBalanceControllerProvider = StateNotifierProvider<
    FetchUserBalanceController, AsyncValue<UserBalanceResModel>>((ref) {
  return FetchUserBalanceController(
      ref.read(userBalanceRepositoryProvider), ref);
});

class FetchUserBalanceController
    extends StateNotifier<AsyncValue<UserBalanceResModel>> {
  final FetchUserBalanceRepository fetchUserBalanceRepository;
  final Ref ref;

  FetchUserBalanceController(this.fetchUserBalanceRepository, this.ref)
      : super(const AsyncValue.loading());

  Future<void> userBalance() async {
    state = const AsyncValue.loading();
    try {
      final data = await fetchUserBalanceRepository.userBalance(
          userId: ref
                  .watch(userDetailsControllerProvider.notifier)
                  .state
                  .data
                  ?.data
                  ?.user
                  ?.id
                  .toString() ??
              '');
      state = AsyncValue.data(data);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
