import 'package:dealer_portal_mobile/features/subscriptions/data/models/get_digital_products_res_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectedDataPackNotifier
    extends StateNotifier<List<DigitalProductsResModel>> {
  SelectedDataPackNotifier() : super([]);

  double totalPrice = 0.0;

  void toggleSelection(DigitalProductsResModel product) {
    // state = state.any((prd) => prd.name == product.name)
    //     ? state.where((prd) => prd.name != product.name).toList()
    //     : [...state, product.copyWith(isSelected: true)];
    state = state.any((prd) => prd.id == product.id)
        ? state.where((prd) => prd.id != product.id).toList()
        : [...state, product.copyWith(isSelected: true)];
  }

  void setInitialProduct(List<DigitalProductsResModel> products) {
    state = products;
  }

  void removeProduct(DigitalProductsResModel product) {
    state = state.where((p) => p.id != product.id).toList();
  }
}

final selectedDataProvider = StateNotifierProvider.autoDispose<
    SelectedDataPackNotifier, List<DigitalProductsResModel>>((ref) {
  return SelectedDataPackNotifier();
});
