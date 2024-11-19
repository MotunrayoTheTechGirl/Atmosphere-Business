import 'dart:developer';

import 'package:dealer_portal_mobile/core/enums.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/response_state.dart';
import '../models/create_advertiser_res_model.dart';
import '../repository/create_advertiser_repository.dart';

final createAdvertiserControllerProvider = StateNotifierProvider<
    CreateAdvertiserController, ResponseState<CreateAdvertiserResModel>>((ref) {
  final advertiser = ref.read(createAdvertiserRepositoryProvider);
  return CreateAdvertiserController(advertiser);
});

class CreateAdvertiserController
    extends StateNotifier<ResponseState<CreateAdvertiserResModel>> {
  CreateAdvertiserController(this.createAdvertiserRepository)
      : super(
          ResponseState(status: ResponseStatus.initial, message: ''),
        );
  final CreateAdvertiserRepository createAdvertiserRepository;

  Future<bool> getAdvertiserId({
    required String name,
    required String businessName,
    required num userId,
    required String email,
    String? businessCategory,
    String? businessAddress,
  }) async {
    state = ResponseState(status: ResponseStatus.loading, message: '');
    try {
      final response = await createAdvertiserRepository.createAdvertiser(
          name: name, businessName: businessName, userId: userId, email: email);

      state = ResponseState(
        status: ResponseStatus.success,
        message: '',
        data: response,
      );
      return true;
    } catch (e) {
      state = ResponseState(status: ResponseStatus.error, message: "$e");
      log('fetch advertiser ID Error: $e');
      return false;
    }
  }
}
