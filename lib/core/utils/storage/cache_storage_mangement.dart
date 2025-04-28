import 'package:hive/hive.dart';
import 'package:t_store_admin_panel/data/models/abstract/has_id.dart';

abstract class CacheStorageManagement<T extends HasId> {
  // init
  Future<void> init();

  // Method for fetching data
  Future<List<T>> fetchData();

  // Method for deleting data
  Future<void> deleteItem(int index);

  // Method for storage data
  Future<void> storeData(List<T> items);

  // Store item
  Future<void> storeItem(T item);

  /// Clear Cache Storage
  Future<void> clearCacheStorage();

  Future<void> updateItem(T item);
}

class CacheStorageManagementImpl<T extends HasId>
    implements CacheStorageManagement<T> {
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
       _cacheDuration = cacheDuration {
    init();
  }

  @override
  Future<void> init() async {
    // Register adapter if provided
    if (_adapter != null && !Hive.isAdapterRegistered(_adapterTypeId)) {
      Hive.registerAdapter(_adapter);
    }

    // final appDocumentDir =
    //     await path_provider.getApplicationDocumentsDirectory();
    // Hive.init(appDocumentDir.path);

    // Open the box for this type
    _box = await Hive.openBox<dynamic>(_boxName);
  }

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

  @override
  Future<void> storeItem(T item) async {
    final currentData = await fetchData();
    // Check if the item already exists in the cache
    int index = currentData.indexWhere((e) => e.id == item.id);
    if (index == -1) {
      // If it doesn't exist, add it to the list
      currentData.add(item);
    } else {
      // If it exists, update the existing item
      currentData[index] = item;
    }
    await storeData(currentData);
  }

  // update item in cache storage
  @override
  Future<void> updateItem(T item) async {
    final currentData = await fetchData();

    int index = currentData.indexWhere((e) => e.id == item.id);
    if (index != -1) {
      currentData[index] = item;
      await storeData(currentData);
    }
  }
}
