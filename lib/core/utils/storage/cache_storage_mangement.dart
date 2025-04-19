import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

abstract class CacheStorageManagement<T> {
  // init
  Future<void> init();

  // Method for fetching data
  Future<List<T>> fetchData();

  // Method for deleting data
  Future<void> deleteItem(int index);

  // Method for storage data
  Future<void> storeData(List<T> items);

  /// Clear Cache Storage
  Future<void> clearCacheStorage();
}

class CacheStorageManagementImpl<T> implements CacheStorageManagement<T> {
  late Box _box;
  final String _boxName;
  final int _adapterTypeId;
  final TypeAdapter<T>? _adapter;
  final Duration _cacheDuration;

  static const String _dataKey = 'data';
  static const String _timestampKey = 'timestamp';

  CacheStorageManagementImpl(
    this._boxName,
    this._adapterTypeId, {
    TypeAdapter<T>? adapter,
    Duration cacheDuration = const Duration(minutes: 7),
  }) : _adapter = adapter,
       _cacheDuration = cacheDuration;

  @override
  Future<void> init() async {
    // Register adapter if provided
    if (_adapter != null && !Hive.isAdapterRegistered(_adapterTypeId)) {
      Hive.registerAdapter(_adapter);
    }

    final appDocumentDir =
        await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);

    // Open the box for this type
    _box = await Hive.openBox<dynamic>(_boxName);
  }

  // @override
  // Future<List<T>> fetchData() async {
  //   final data = _box.get('data');
  //   final timestamp = _box.get('timestamp');

  //   // Check if cache is expired
  //   if (timestamp as DateTime == null ||
  //       DateTime.now().isAfter(timestamp.add(_cacheDuration))) {
  //     await clearCacheStorage(); // Clear expired cache
  //     return [];
  //   }

  //   if (data == null) return [];
  //   return data.cast<T>();
  // }

  // @override
  // Future<void> storeData(List<T> items) async {
  //   await _box.put('data', items);
  //   await _box.put('timestamp', DateTime.now()); // Store current timestamp
  // }

  // @override
  // Future<void> deleteItem(int index) async {
  //   final currentData = await fetchData();
  //   if (index >= 0 && index < currentData.length) {
  //     currentData.removeAt(index);
  //     await storeData(currentData);
  //   }
  // }

  // @override
  // Future<void> clearCacheStorage() async {
  //   await _box.clear();
  //   await _box.delete('timestamp');
  // }

  @override
  Future<List<T>> fetchData() async {
    try {
      final timestamp =
          _box.get(_timestampKey, defaultValue: null) as DateTime?;

      // Check if cache is expired
      if (timestamp == null ||
          DateTime.now().isAfter(timestamp.add(_cacheDuration))) {
        await clearCacheStorage();
        return [];
      }

      final data = _box.get(_dataKey, defaultValue: []) as List;
      return data.cast<T>();
    } catch (e) {
      await clearCacheStorage();
      return [];
    }
  }

  @override
  Future<void> storeData(List<T> items) async {
    await _box.put(_dataKey, items);
    await _box.put(_timestampKey, DateTime.now());
  }

  @override
  Future<void> deleteItem(int index) async {
    final currentData = await fetchData();
    _box.delete(_dataKey);
    if (index >= 0 && index < currentData.length) {
      currentData.removeAt(index);
      await storeData(currentData);
    }
  }

  @override
  Future<void> clearCacheStorage() async {
    await _box.delete(_dataKey);
    await _box.delete(_timestampKey);
  }

  Future<bool> isCacheValid() async {
    final timestamp = _box.get(_timestampKey, defaultValue: null) as DateTime?;
    return timestamp != null &&
        !DateTime.now().isAfter(timestamp.add(_cacheDuration));
  }
}
