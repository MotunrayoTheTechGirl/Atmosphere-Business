import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageService {
  final FlutterSecureStorage secureStorage;
  StorageService({required this.secureStorage});

  Future<void> write({required String key, required String value}) async {
    log('Writing to secure storage ===> $key: $value');
    await secureStorage.write(key: key, value: value);
  }

  Future<String?> read({required String key}) async {
    return await secureStorage.read(key: key);
  }

  Future<void> delete({required String key}) async {
    await secureStorage.delete(key: key);
  }

  Future<void> deleteAll() async {
    await secureStorage.deleteAll();
  }
}
