import 'dart:developer';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/enums.dart';
import '../../../../core/response_state.dart';
import '../repository/file_upload_repository.dart';

final fileUploadControllerProvider =
    StateNotifierProvider<FileUploadController, ResponseState<String>>((ref) {
  final receiptFileUploadProvider = ref.read(fileUploadRepositoryProvider);
  return FileUploadController(receiptFileUploadProvider);
});

/// i duplicated provider up here,
final receiptFileUploadControllerProvider =
    StateNotifierProvider<FileUploadController, ResponseState<String>>((ref) {
  final receiptFileUploadProvider = ref.read(fileUploadRepositoryProvider);
  return FileUploadController(receiptFileUploadProvider);
});

class FileUploadController extends StateNotifier<ResponseState<String>> {
  FileUploadController(this.fileUploadRepository)
      : super(
          ResponseState(status: ResponseStatus.initial, message: ''),
        );
  final FileUploadRepository fileUploadRepository;

  Future<bool> uploadFile({
    required File file,
  }) async {
    state = ResponseState(status: ResponseStatus.loading, message: '');
    try {
      final response = await fileUploadRepository.fileUpload(
        file: file,
      );
      log('file upload response: $response');
      state = ResponseState(
        status: ResponseStatus.success,
        message: '',
        data: response,
      );
      return true;
    } catch (e) {
      state = ResponseState(status: ResponseStatus.error, message: "$e");
      log('file upload error: $e');
      return false;
    }
  }
}
