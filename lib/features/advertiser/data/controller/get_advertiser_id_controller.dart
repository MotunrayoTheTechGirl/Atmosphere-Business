

// final fetchAdvertiserByUserIdControllerProvider = StateNotifierProvider<
//     FetchAdvertiserByUserIdController,
//     ResponseState<GetAdvertiserIdResModel>>((ref) {
//   final advertiserId = ref.read(getAdvertiserByUserIdRepositoryProvider);
//   return FetchAdvertiserByUserIdController(advertiserId);
// });

// class FetchAdvertiserByUserIdController
//     extends StateNotifier<ResponseState<GetAdvertiserIdResModel>> {
//   FetchAdvertiserByUserIdController(this.getAdvertiserByUserIdRepository)
//       : super(
//           ResponseState(status: ResponseStatus.initial, message: ''),
//         );
//   final GetAdvertiserByUserIdRepository getAdvertiserByUserIdRepository;

//   Future<bool> getAdvertiserId({
//     required String userId,
//   }) async {
//     state = ResponseState(status: ResponseStatus.loading, message: '');
//     try {
//       final response = await getAdvertiserByUserIdRepository
//           .getadvertiserByUserId(userId: userId);
//       state = ResponseState(
//         status: ResponseStatus.success,
//         message: '',
//         data: response,
//       );
//       return true;
//     } catch (e) {
//       state = ResponseState(status: ResponseStatus.error, message: "$e");
//       log('fetch advertiser ID Error: $e');
//       return false;
//     }
//   }
// }
