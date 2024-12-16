import 'package:dealer_portal_mobile/features/advertiser/data/repository/get_adverts_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/screens/create_ads_screen.dart';
import '../models/get_adverts_res_model.dart';

final getAdvertsControllerProvider = StateNotifierProvider<GetAdvertsController,
    AsyncValue<List<GetAdsByAdvertiserIdResModel>>>((ref) {
  return GetAdvertsController(
      ref.read(getAdvertsByAdvertiserRepositoryProvider), ref);
});

class GetAdvertsController
    extends StateNotifier<AsyncValue<List<GetAdsByAdvertiserIdResModel>>> {
  final GetAdvertsByAdvertiserRepository getAdvertsByAdvertiserRepository;
  final Ref ref;

  GetAdvertsController(this.getAdvertsByAdvertiserRepository, this.ref)
      : super(const AsyncValue.loading());

  Future<void> fetchAdverts() async {
    state = const AsyncValue.loading();
    try {
      final data =
          await getAdvertsByAdvertiserRepository.getAdvertsByAdvertiserId(
              advertiserId: ref.watch(advertiserIdStateProvider));
      state = AsyncValue.data(data);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
