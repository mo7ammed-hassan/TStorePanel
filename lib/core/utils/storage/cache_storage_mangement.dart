import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:t_store_admin_panel/data/models/abstract/has_id.dart';

abstract class CacheStorageManagement<T extends HasId> {
  Future<Either<String, Unit>> init();
  Future<Either<String, List<T>>> fetchData();
  Future<Either<String, Unit>> deleteItem(int index);
  Future<Either<String, Unit>> storeData(List<T> items);
  Future<Either<String, Unit>> storeItem(T item);
  Future<Either<String, Unit>> clearCacheStorage();
  Future<Either<String, Unit>> updateItem(T item);
  bool isCacheValid();
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
  static const String _lastCompactKey = 'last_compact';
  static const int _cacheDurationInMinutes = 7;

  CacheStorageManagementImpl(
    this._boxName,
    this._adapterTypeId, {
    TypeAdapter<T>? adapter,
    Duration cacheDuration = const Duration(minutes: _cacheDurationInMinutes),
  }) : _adapter = adapter,
       _cacheDuration = cacheDuration {
    init();
  }

  @override
  Future<Either<String, Unit>> init() async {
    try {
      if (_adapter != null && !Hive.isAdapterRegistered(_adapterTypeId)) {
        Hive.registerAdapter(_adapter);
      }
      _box = await Hive.openBox<dynamic>(_boxName);
      return right(unit);
    } catch (e) {
      return left('Failed to initialize cache: $e');
    }
  }

  @override
  Future<Either<String, List<T>>> fetchData() async {
    try {
      await _prepareCache();

      final data = _box.get(_dataKey, defaultValue: []) as List;
      return right(data.cast<T>());
    } catch (e) {
      await clearCacheStorage();
      return left('Failed to fetch data from cache: $e');
    }
  }

  @override
  Future<Either<String, Unit>> storeData(List<T> items) async {
    try {
      await _box.put(_dataKey, items);
      await _box.put(_timestampKey, DateTime.now());

      await _maybeCompactBox();

      return right(unit);
    } catch (e) {
      return left('Failed to store data in cache: $e');
    }
  }

  @override
  Future<Either<String, Unit>> deleteItem(int index) async {
    await _prepareCache();

    final result = await fetchData();
    return await result.fold((error) => left(error), (currentData) async {
      try {
        if (index >= 0 && index < currentData.length) {
          currentData.removeAt(index);
          return await storeData(currentData);
        }
        return left('Invalid index while deleting item');
      } catch (e) {
        return left('Error while deleting item from cache: $e');
      }
    });
  }

  @override
  Future<Either<String, Unit>> storeItem(T item) async {
    await _prepareCache();

    final result = await fetchData();
    return await result.fold((error) => left(error), (currentData) async {
      try {
        int index = currentData.indexWhere((e) => e.id == item.id);
        if (index == -1) {
          currentData.add(item);
        } else {
          currentData[index] = item;
        }
        return await storeData(currentData);
      } catch (e) {
        return left('Error while storing item in cache: $e');
      }
    });
  }

  @override
  Future<Either<String, Unit>> updateItem(T item) async {
    await _prepareCache();

    final result = await fetchData();
    return await result.fold((error) => left(error), (currentData) async {
      try {
        int index = currentData.indexWhere((e) => e.id == item.id);
        if (index != -1) {
          currentData[index] = item;
          return await storeData(currentData);
        }
        return left('Item not found for update');
      } catch (e) {
        return left('Failed to update item in cache: $e');
      }
    });
  }

  @override
  Future<Either<String, Unit>> clearCacheStorage() async {
    try {
      await _box.delete(_dataKey);
      await _box.delete(_timestampKey);

      await _box.compact();

      return right(unit);
    } catch (e) {
      return left('Failed to clear cache: $e');
    }
  }

  @override
  bool isCacheValid() {
    final timestamp = _box.get(_timestampKey) as DateTime?;
    return timestamp != null &&
        !DateTime.now().isAfter(timestamp.add(_cacheDuration));
  }

  Future<void> _prepareCache() async {
    if (!isCacheValid()) {
      await clearCacheStorage();
    }
  }

  Future<void> _maybeCompactBox() async {
    final lastCompact = _box.get(_lastCompactKey) as DateTime?;
    final now = DateTime.now();

    if (lastCompact == null || now.isAfter(lastCompact.add(_cacheDuration))) {
      await _box.compact();
      await _box.put(_lastCompactKey, now);
    }
  }
}
