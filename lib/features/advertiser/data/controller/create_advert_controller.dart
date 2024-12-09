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
    num? advertiserId,
    String? title,
    String? description,
    String? adType,
    String? status,
    String? adSize,
    String? deviceType,
    String? mediaUrl,
    String? targetUrl,
    num? budget,
    String? businessCategory,
    String? callToActionText,
    num? duration,
    String? startDate,
    String? desiredScreen,
    List? regionIds,
  }) async {
    state = ResponseState(status: ResponseStatus.loading, message: '');
    log('start date cc: $startDate');
    log('duration cc: $duration');
    log('region cc: $regionIds');
    try {
      final response = await createAdvertRepository.createAdvert(
          advertiserId: advertiserId,
          title: title,
          description: description,
          adType: adType,
          status: status,
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
          regionIds: regionIds);
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
