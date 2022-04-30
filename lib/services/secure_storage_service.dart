import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sanjaya/models/storage_item.dart';

class SecureStorageService {
  final _secureStorage = const FlutterSecureStorage();

  AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );

  Future<void> writeSecureData(StorageItem newItem) async {
    await _secureStorage.write(
      key: newItem.key,
      value: newItem.value,
      aOptions: _getAndroidOptions(),
    );
  }

  Future<String?> readSecureData(String key) async {
    var readData = await _secureStorage.read(
      key: key,
      aOptions: _getAndroidOptions(),
    );
    return readData;
  }

  Future<void> deleteSecureData(String key) async {
    await _secureStorage.delete(
      key: key,
      aOptions: _getAndroidOptions(),
    );
  }

  Future<bool> containsKeyInStorage(String key) async {
    return await _secureStorage.containsKey(
      key: key,
      aOptions: _getAndroidOptions(),
    );
  }

  Future<List<StorageItem>> readAllSecureData() async {
    var allData = await _secureStorage.readAll(aOptions: _getAndroidOptions());
    List<StorageItem> list = allData.entries
        .map((e) => StorageItem(key: e.key, value: e.value))
        .toList();
    return list;
  }

  Future<void> deleteAllStorage() async {
    await _secureStorage.deleteAll(aOptions: _getAndroidOptions());
  }
}
