import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/enums.dart';
import '../../../../core/response_state.dart';
import '../models/update_ads_res_model.dart';
import '../repository/update_ads_repository.dart';

final updateAdsControllerProvider = StateNotifierProvider<UpdateAdsController,
    ResponseState<UpdateAdsResModel>>((ref) {
  final updateAdsProvider = ref.read(updateAdsRepositoryProvider);
  return UpdateAdsController(updateAdsProvider);
});

class UpdateAdsController
    extends StateNotifier<ResponseState<UpdateAdsResModel>> {
  UpdateAdsController(this.updateAdsRepository)
      : super(
          ResponseState(status: ResponseStatus.initial, message: ''),
        );
  final UpdateAdsRepository updateAdsRepository;

  Future<bool> updateAdvert({
    required String advertId,
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
    log('start date: $startDate');
    log('duration: $duration');
    log('region: $regionIds');
    try {
      final response = await updateAdsRepository.updateAds(
          advertId: advertId,
          advertiserId: advertiserId,
          title: title,
          description: description,
          adType: adType,
          status: 'pending',
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
