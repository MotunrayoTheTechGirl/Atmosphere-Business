import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedRegionIdProvider =
    StateNotifierProvider<SelectedRegionIdNotifier, List<int>>(
  (ref) => SelectedRegionIdNotifier(),
);

class SelectedRegionIdNotifier extends StateNotifier<List<int>> {
  SelectedRegionIdNotifier() : super([]);

  void addSelectedIdRegion(int id) {
    state = [...state, id];
  }

  void removeSelectedIdRegion(int id) {
    state = state.where((element) => element != id).toList();
  }

  void clear() {
    state = [];
  }
}
