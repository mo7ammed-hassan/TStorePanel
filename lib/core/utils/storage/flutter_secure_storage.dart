import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class FlutterSecureStorageUtils {
  FlutterSecureStorageUtils._();

  static final FlutterSecureStorageUtils _instance =
      FlutterSecureStorageUtils._();
  static FlutterSecureStorageUtils get instance => _instance;

  final storage = const FlutterSecureStorage();

  Future<String?> read(String key) async => await storage.read(key: key);

  Future<void> write(String key, String value) async =>
      await storage.write(key: key, value: value);

  Future<void> delete(String key) async => await storage.delete(key: key);

  Future<void> deleteAll() async => await storage.deleteAll();
}
