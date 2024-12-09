import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedRegionProvider =
    StateNotifierProvider<SelectedRegionNotifier, Set<String>>(
  (ref) => SelectedRegionNotifier(),
);

class SelectedRegionNotifier extends StateNotifier<Set<String>> {
  SelectedRegionNotifier() : super({});

  void toggle(String regionName) {
    if (state.contains(regionName)) {
      state = Set.from(state)..remove(regionName);
    } else {
      state = Set.from(state)..add(regionName);
    }
  }

  void clear() {
    state = {};
  }
}
