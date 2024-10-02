class CountdownState {
  final Duration remainingTime;

  CountdownState({required this.remainingTime});

  CountdownState copyWith({Duration? remainingTime}) {
    return CountdownState(
      remainingTime: remainingTime ?? this.remainingTime,
    );
  }

  @override
  String toString() => 'CountdownState(remainingTime: $remainingTime)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CountdownState && other.remainingTime == remainingTime;
  }

  @override
  int get hashCode => remainingTime.hashCode;
}

// class CountdownState {
//   final Duration remainingTime;
//   CountdownState({required this.remainingTime});

//   CountdownState copyWith({Duration? remainingTime}) {
//     return CountdownState(
//       remainingTime: remainingTime ?? this.remainingTime,
//     );
//   }

//   @override
//   String toString() => 'CountdownState(remainingTime: $remainingTime)';

//   @override
//   bool operator ==(Object other) {
//     if (identical(this, other)) return true;
//     return other is CountdownState && other.remainingTime == remainingTime;
//   }

//   @override
//   int get hashCode => remainingTime.hashCode;
// }


