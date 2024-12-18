import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/enums.dart';
import '../../../../core/response_state.dart';
import '../models/change_advert_status_res_model.dart';
import '../repository/change_advert_status_repository.dart';

final changeAdvertStatusControllerProvider = StateNotifierProvider<
    ChangeAdvertStatusController,
    ResponseState<ChangeAdvertStatusResModel>>((ref) {
  final changeStatus = ref.read(changeAdvertStatusRepositoryProvider);
  return ChangeAdvertStatusController(changeStatus, ref);
});

class ChangeAdvertStatusController
    extends StateNotifier<ResponseState<ChangeAdvertStatusResModel>> {
  ChangeAdvertStatusController(this.changeAdvertStatusRepository, this.ref)
      : super(
          ResponseState(status: ResponseStatus.initial, message: ''),
        );
  final ChangeAdvertStatusRepository changeAdvertStatusRepository;
  final Ref ref;

  Future<bool> changeAdsStatus(
      {required String status, required String advertId}) async {
    state = ResponseState(status: ResponseStatus.loading, message: '');
    try {
      final response = await changeAdvertStatusRepository.changeAdvertStatus(
          advertId: advertId, status: status);

      state = ResponseState(
        status: ResponseStatus.success,
        message: '',
        data: response,
      );
      return true;
    } catch (e) {
      state = ResponseState(status: ResponseStatus.error, message: "$e");
      log('change status ctrl error: $e');
      return false;
    }
  }
}
