import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/enums.dart';
import '../../../../core/response_state.dart';
import '../models/get_advertiser_id_res_model.dart';
import '../repository/get_advertiser_id_repository.dart';

final fetchAdvertiserByUserIdControllerProvider = StateNotifierProvider<
    FetchAdvertiserByUserIdController,
    ResponseState<GetAdvertiserIdResModel>>((ref) {
  final advertiserId = ref.read(getAdvertiserByUserIdRepositoryProvider);
  return FetchAdvertiserByUserIdController(advertiserId);
});

class FetchAdvertiserByUserIdController
    extends StateNotifier<ResponseState<GetAdvertiserIdResModel>> {
  FetchAdvertiserByUserIdController(this.getAdvertiserByUserIdRepository)
      : super(
          ResponseState(status: ResponseStatus.initial, message: ''),
        );
  final GetAdvertiserByUserIdRepository getAdvertiserByUserIdRepository;

  Future<bool> getAdvertiserId({
    required String userId,
  }) async {
    state = ResponseState(status: ResponseStatus.loading, message: '');
    try {
      final response = await getAdvertiserByUserIdRepository
          .getadvertiserByUserId(userId: userId);

      state = ResponseState(
        status: ResponseStatus.success,
        message: '',
        data: response,
      );
      return true;
    } catch (e) {
      if (e is AdvertiserNotFoundException) {
        state = ResponseState(
            status: ResponseStatus.notFound, message: 'Advertiser not found');
        return false;
      }
      state = ResponseState(status: ResponseStatus.error, message: "$e");
      log('fetch advertiser ID Error: $e');
      return false;
    }
  }
}
