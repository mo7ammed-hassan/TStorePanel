import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class FlutterSecureStorageUtils {
  FlutterSecureStorageUtils._();

  static final FlutterSecureStorageUtils _instance =
      FlutterSecureStorageUtils._();
  static FlutterSecureStorageUtils get instance => _instance;

  final storage = const FlutterSecureStorage();
  
  // read data
  Future<String?> read(String key) async => await storage.read(key: key);

  // write data
  Future<void> write(String key, String value) async =>
      await storage.write(key: key, value: value);

  // delete data
  Future<void> delete(String key) async => await storage.delete(key: key);

  // delete all data
  Future<void> deleteAll() async => await storage.deleteAll();
}
