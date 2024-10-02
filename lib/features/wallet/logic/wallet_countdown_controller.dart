// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/controller/verify_and_update_wallet_controller.dart';
import '../presentation/screens/fund_wallet_screen.dart';
import 'wallet_countdown_state.dart';

final walletPaystackCountdownProvider =
    StateNotifierProvider.autoDispose<CountdownController, CountdownState>(
  (ref) => CountdownController(
    initialMinutes: 30,
    ref: ref,
    successMessage: 'You account has been topup successfully',
  ),
);

class CountdownController extends StateNotifier<CountdownState> {
  final Ref ref;
  final int initialMinutes;

  final String successMessage;
  late Duration _initialDuration;
  Timer? _timer;
  bool _isMounted = true;

  CountdownController({
    required this.ref,
    this.initialMinutes = 2,
    this.successMessage = '',
  }) : super(CountdownState(
          remainingTime: Duration(minutes: initialMinutes),
        )) {
    _initialDuration = Duration(minutes: initialMinutes);
  }

  void startTimer() {
    int intervalCounter = 0;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_isMounted) return;

      intervalCounter++;
      if (intervalCounter >= 1) {
        intervalCounter = 0;

        ref
            .read(verifyAndUpdateWalletControllerProvider.notifier)
            .verifyPaymentAndUpdateWallet(
                amount: ref.watch(amountStateProvider),
                reference: ref.watch(generatedReferenceStateProvider),
                userId: ref.watch(userIdStateProvider));

        // intervalCounter = 0;

        // ref
        //     .read(fetchUserBalanceControllerProvider.notifier)
        //     .userBalance(userId: ref.watch(userIdStateProvider));
      } else if (state.remainingTime.inSeconds <= 0) {
        timer.cancel();
      }
    });
  }

  void stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  void restartTimer() {
    if (!_isMounted) return;

    if (_timer != null) {
      _timer!.cancel();
      _initialDuration = Duration(minutes: initialMinutes);
      state = CountdownState(remainingTime: _initialDuration);
      startTimer();
    } else {
      startTimer();
    }
  }

  @override
  void dispose() {
    _isMounted = false;
    if (_timer == null) _timer!.cancel();
    super.dispose();
  }
}

// class CountdownController extends StateNotifier<CountdownState> {
//   final Ref ref;
//   final int initialMinutes;
//   final String successMessage;
//   late Duration _initialDuration;
//   Timer? _timer;
//   bool _isMounted = true;

//   CountdownController({
//     required this.ref,
//     this.initialMinutes = 2,
//     this.successMessage = '',
//   }) : super(CountdownState(
//           remainingTime: Duration(minutes: initialMinutes),
//         )) {
//     _initialDuration = Duration(minutes: initialMinutes);
//   }

//   void startTimer() {
//     int intervalCounter = 0;
//     _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       if (!_isMounted) return;
//       state = state.copyWith(
//           remainingTime: state.remainingTime - const Duration(seconds: 1));
//       intervalCounter++;
//       if (intervalCounter >= 5) {
//         intervalCounter = 0;
//         _callApi();
//       }
//       if (state.remainingTime.inSeconds <= 0) {
//         timer.cancel();
//       }
//     });
//   }

//   void _callApi() {
//     ref
//         .read(verifyAndUpdateWalletControllerProvider.notifier)
//         .verifyPaymentAndUpdateWallet(
//             amount: ref.watch(amountStateProvider),
//             reference: ref.watch(generatedReferenceStateProvider),
//             userId: ref.watch(userIdStateProvider));
//     ref.read(fetchUserBalanceControllerProvider.notifier).userBalance();
//   }

//   void restartTimer() {
//     if (!_isMounted) return;
//     if (_timer != null) {
//       _timer!.cancel();
//       state = CountdownState(remainingTime: _initialDuration);
//       startTimer();
//     } else {
//       startTimer();
//     }
//   }

//   void stopTimer() {
//     _timer?.cancel();
//     _timer = null;
//   }

//   @override
//   void dispose() {
//     _isMounted = false;
//     if (_timer == null) _timer!.cancel();
//     super.dispose();
//   }
// }
