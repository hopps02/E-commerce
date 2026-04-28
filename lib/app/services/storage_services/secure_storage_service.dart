import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class SecureStorageServiceBase {
  final FlutterSecureStorage _storage;
  static const _tokenKey = 'access-token';
  static const _userDataKey = 'user-data';
  SecureStorageServiceBase(this._storage);

  // Token
  Future<void> setToken(String token) async =>
      await _storage.write(key: _tokenKey, value: token);
  Future<String?> get token async => await _storage.read(key: _tokenKey);
  Future<void> deleteToken() async => await _storage.delete(key: _tokenKey);
  Future<bool> isUserRegistered() async => (await _storage.read(key: _tokenKey)) != null;

  // User Data
  Future<void> setUserData(Map<String, dynamic> userData) async =>
      await _storage.write(key: _userDataKey, value: jsonEncode(userData));
  Future<Map<String, dynamic>?> get userData async {
    final data = await _storage.read(key: _userDataKey);
    return data != null ? jsonDecode(data) : null;
  }

  Future<void> deleteUserData() async =>
      await _storage.delete(key: _userDataKey);

  // Clear
  Future<void> clearAll() async => await _storage.deleteAll();
}

class SecureStorageService extends SecureStorageServiceBase {
  SecureStorageService([FlutterSecureStorage? storage])
    : super(
        storage ??
            const FlutterSecureStorage(
              aOptions: AndroidOptions(encryptedSharedPreferences: true),
              iOptions: IOSOptions(
                accessibility: KeychainAccessibility.first_unlock_this_device,
              ),
            ),
      );
}
