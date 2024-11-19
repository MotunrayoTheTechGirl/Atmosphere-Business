import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/enums.dart';
import '../../../../core/response_state.dart';
import '../models/create_ads_res_model.dart';
import '../repository/create_ads_repository.dart';

final createAdvertControllerProvider = StateNotifierProvider<
    CreateAdvertController, ResponseState<CreateAdsResModel>>((ref) {
  final createAdsProvider = ref.read(createAdvertRepositoryProvider);
  return CreateAdvertController(createAdsProvider);
});

class CreateAdvertController
    extends StateNotifier<ResponseState<CreateAdsResModel>> {
  CreateAdvertController(this.createAdvertRepository)
      : super(
          ResponseState(status: ResponseStatus.initial, message: ''),
        );
  final CreateAdvertRepository createAdvertRepository;

  Future<bool> createAds({
    required num advertiserId,
    required String title,
    required String description,
    required String adType,
    required String adSize,
    required String mediaUrl,
    required String targetUrl,
    required num budget,
    required num duration,
    required String startDate,
    required String businessCategory,
    required num deviceType,
    required String callToActionText,
    required String desiredScreen,
    List? regionIds,
  }) async {
    state = ResponseState(status: ResponseStatus.loading, message: '');
    try {
      final response = await createAdvertRepository.createAdvert(
          advertiserId: advertiserId,
          title: title,
          description: description,
          adType: adType,
          adSize: adSize,
          mediaUrl: mediaUrl,
          targetUrl: targetUrl,
          budget: budget,
          duration: duration,
          startDate: startDate,
          businessCategory: businessCategory,
          deviceType: deviceType,
          callToActionText: callToActionText,
          desiredScreen: desiredScreen,
          regionIds: regionIds ?? []);
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
