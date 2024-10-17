import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../onboarding/data/controller/user_details_controller.dart';
import '../models/wallet_history_res_model.dart';
import '../repository/wallet_history_repo.dart';

final walletHistoryControllerProvider = StateNotifierProvider<
    WalletHistoryController, AsyncValue<WalletHistoryResModel>>((ref) {
  return WalletHistoryController(
      ref.read(walletHistoryRepositoryProvider), ref);
});

class WalletHistoryController
    extends StateNotifier<AsyncValue<WalletHistoryResModel>> {
  final WalletHistoryRepository walletHistoryRepository;
  final Ref ref;

  WalletHistoryController(this.walletHistoryRepository, this.ref)
      : super(const AsyncValue.loading());

  Future<void> fetchWalletHistory() async {
    state = const AsyncValue.loading();
    try {
      final data = await walletHistoryRepository.walletHistory(
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
