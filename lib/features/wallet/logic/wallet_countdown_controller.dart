// ignore_for_file: curly_braces_in_flow_control_structures, avoid_print

import 'dart:async';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../my_plans/data/controller/user_balance_controller.dart';
import '../data/controller/verify_and_update_wallet_controller.dart';
import '../data/controller/wallet_history_controller.dart';
import '../presentation/widgets/fundwallet_tile.dart';
import 'wallet_countdown_state.dart';

final walletPaystackCountdownProvider =
    StateNotifierProvider.autoDispose<CountdownController, CountdownState>(
  (ref) => CountdownController(
    // initialSeconds: 600,
    ref: ref,
    // successMessage: 'You account has been topup successfully',
  ),
);

class CountdownController extends StateNotifier<CountdownState> {
  final Ref ref;
  final int initialSeconds;
  Timer? _timer;
  bool _isActive = false;

  CountdownController({
    required this.ref,
    this.initialSeconds = 1,
  }) : super(CountdownState(
          remainingTime: Duration(seconds: initialSeconds),
        ));

  void startVerificationTimer() {
    print("Starting verification timer - ${DateTime.now()}");

    // Check if timer is already running
    if (_timer != null && _timer!.isActive) {
      print("Timer is already running, cancelling old timer");
      _timer!.cancel();
    }

    _isActive = true;
    print("_isActive set to: $_isActive");

    // Immediate verification
    _performVerification();

    try {
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        _onTimerTick(timer);
      });
      print("Timer successfully created - ID: ${_timer.hashCode}");
    } catch (e, stackTrace) {
      print("Error creating timer: $e");
      print("Stack trace: $stackTrace");
    }
  }

  void _onTimerTick(Timer timer) {
    print("Timer tick at ${DateTime.now()} - Timer ID: ${timer.hashCode}");

    if (!_isActive) {
      print("Timer is no longer active, stopping - ${DateTime.now()}");
      stopTimer();
      return;
    }

    _performVerification();
  }

  void _performVerification() {
    if (!_isActive) return;

    try {
      print("Attempting to verify payment - ${DateTime.now()}");
      ref
          .read(verifyAndUpdateWalletControllerProvider.notifier)
          .verifyPaymentAndUpdateWallet(
              amount: ref.read(amountStateProvider),
              reference: ref.read(generatedReferenceStateProvider),
              userId: ref.read(userIdStateProvider));
      print("Payment verification completed - ${DateTime.now()}");
    } catch (e, stackTrace) {
      print("Error during payment verification: $e");
      print("Stack trace: $stackTrace");
    }
  }

  void stopTimer() {
    print("Stopping timer - ${DateTime.now()}");
    _isActive = false;
    log('Timer: $_timer');
    if (_timer != null) {
      print("Cancelling timer - ID: ${_timer.hashCode}");
      _timer!.cancel();
      _timer = null;
    }

    try {
      print("Updating final balance - ${DateTime.now()}");
      ref.read(fetchUserBalanceControllerProvider.notifier).userBalance();
      ref.read(walletHistoryControllerProvider.notifier).fetchWalletHistory();
      print("Final balance update completed - ${DateTime.now()}");
    } catch (e, stackTrace) {
      print("Error updating final balance: $e");
      print("Stack trace: $stackTrace");
    }
  }

  // @override
  // void dispose() {
  //   print("Disposing CountdownController - ${DateTime.now()}");
  //   // stopTimer();
  //   _timer?.cancel();
  //   super.dispose();
  // }
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
//       if (_isMounted) return;

//       intervalCounter++;
//       if (intervalCounter >= 1) {
//         intervalCounter = 0;

//         ref
//             .read(verifyAndUpdateWalletControllerProvider.notifier)
//             .verifyPaymentAndUpdateWallet(
//                 amount: ref.watch(amountStateProvider),
//                 reference: ref.watch(generatedReferenceStateProvider),
//                 userId: ref.watch(userIdStateProvider));

//         // ref
//         //     .read(fetchUserBalanceControllerProvider.notifier)
//         //     .userBalance(userId: ref.watch(userIdStateProvider));
//       } else if (state.remainingTime.inSeconds <= 0) {
//         timer.cancel();
//       }
//     });
//   }

//   // void startTimer() {
//   //   int intervalCounter = 0;
//   //   _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//   //     if (!_isMounted) return;
//   //     if (state.remainingTime.inSeconds <= 0) {
//   //       timer.cancel();
//   //     } else {
//   //       state = state.copyWith(
//   //         remainingTime: state.remainingTime - const Duration(seconds: 1),
//   //       );
//   //       intervalCounter++;
//   //       if (intervalCounter >= 1) {
//   //         intervalCounter = 0;
//   //         ref
//   //             .read(verifyAndUpdateWalletControllerProvider.notifier)
//   //             .verifyPaymentAndUpdateWallet(
//   //                 amount: ref.watch(amountStateProvider),
//   //                 reference: ref.watch(generatedReferenceStateProvider),
//   //                 userId: ref.watch(userIdStateProvider));
//   //       }
//   //     }
//   //   });
//   // }

//   void stopTimer() {
//     _timer?.cancel();
//     _timer = null;
//   }

//   void restartTimer() {
//     if (!_isMounted) return;

//     if (_timer != null) {
//       _timer!.cancel();
//       _initialDuration = Duration(minutes: initialMinutes);
//       state = CountdownState(remainingTime: _initialDuration);
//       startTimer();
//     } else {
//       startTimer();
//     }
//   }

//   @override
//   void dispose() {
//     _isMounted = false;
//     if (_timer == null) _timer!.cancel();
//     super.dispose();
//   }
// }
