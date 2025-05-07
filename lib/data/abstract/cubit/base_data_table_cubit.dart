import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store_admin_panel/core/utils/storage/cache_storage_mangement.dart';
import 'package:t_store_admin_panel/core/utils/dialogs/show_confirmation_dialog.dart';
import 'package:t_store_admin_panel/core/utils/popups/loaders.dart';
import 'package:t_store_admin_panel/data/abstract/cubit/base_data_table_states.dart';
import 'package:t_store_admin_panel/data/models/abstract/has_id.dart';

abstract class BaseDataTableCubit<T extends HasId>
    extends Cubit<BaseDataTableStates> {
  BaseDataTableCubit(super.initialState, this.cacheStorageManagement) {
    init();
  }

  bool sortAscending = true;
  int sortColumnIndex = 1;

  final List<T> allItems = [];
  final List<T> filteredItems = [];
  final List<bool> selectedItems = <bool>[];

  final CacheStorageManagement<T> cacheStorageManagement;

  // init
  Future<void> init() async {
    // initialize the cache storage management
    await cacheStorageManagement.init();
    await fetchData();
  }

  /// Method for fetching data
  Future<Either<String, List<T>>> fetchItems();

  /// Method for deleting data
  Future<Either<String, Unit>> deleteItem(T item);

  /// Method for searching data
  bool containSearchQuery(T item, String query);

  Future<void> fetchData() async {
    emit(DataTableLoadingState());

    // Try cache first
    final cachedDataResult = await cacheStorageManagement.fetchData();

    cachedDataResult.fold(
      (error) async {
        // If cache fails, fetch data from the server/database
        await fetchFromServer();
      },
      (cachedData) async {
        if (cachedData.isNotEmpty) {
          _updateLists(cachedData);
          emit(DataTableLoadedState(cachedData));
          return;
        }

        await fetchFromServer();
      },
    );
  }

  // Fetch from server
  Future<void> fetchFromServer() async {
    final result = await fetchItems();
    result.fold(
      (error) {
        Loaders.errorSnackBar(title: 'Error', message: error);
        if (!isClosed) emit(DataTableFailureState(error));
      },
      (items) async {
        _updateLists(items);
        await cacheStorageManagement.storeData(items);
        if (!isClosed) emit(DataTableLoadedState(filteredItems));
      },
    );
  }

  // Update lists with items from the server
  void _updateLists(List<T> items) {
    allItems
      ..clear()
      ..addAll(items);
    filteredItems
      ..clear()
      ..addAll(items);
    selectedItems
      ..clear()
      ..addAll(List.generate(items.length, (index) => false));
  }

  /// Method for filtering data
  void filterData(String query) {
    filteredItems.clear();

    if (query.isEmpty) {
      filteredItems.addAll(allItems);
    } else {
      filteredItems.addAll(
        allItems.where((item) => containSearchQuery(item, query)),
      );
    }

    emit(DataTableLoadedState(filteredItems));
  }

  /// Method for sorting data
  void sortByProperty(
    int columnIndex,
    bool ascending,
    Function(T item) property,
  ) {
    sortColumnIndex = columnIndex;
    sortAscending = ascending;

    filteredItems.sort((a, b) {
      if (ascending) {
        return property(a).compareTo(property(b));
      } else {
        return property(b).compareTo(property(a));
      }
    });

    emit(DataTableLoadedState(filteredItems));
  }

  /// Method for showing dialog for deleting data
  Future<void> deleteOnConfirmation(T item) async {
    final result = await CustomDialogs.showConfirmationDialog(
      title: 'Delete Item',
      message: 'Are you sure you want to delete this Item?',
      confirmButtonText: 'Delete',
      cancelButtonText: 'Cancel',
    );

    if (result) {
      await deleteItemOnConfirmation(item);
    }
  }

  /// Method for deleting data
  Future<void> deleteItemOnConfirmation(T item) async {
    CustomDialogs.showCircularLoader();

    final result = await deleteItem(item);
    if (isClosed) return;

    result.fold(
      (error) {
        CustomDialogs.hideLoader();
        Loaders.errorSnackBar(
          title: 'Error',
          message: 'Failed to delete item.\n$error',
        );
        emit(DataTableFailureState(error));
      },
      (_) {
        removeItemFromList(item);

        CustomDialogs.hideLoader();
        Loaders.successSnackBar(
          title: 'Item Deleted',
          message: 'Your item has been deleted successfully.',
        );

        emit(DataTableLoadedState(List<T>.from(allItems)));
      },
    );
  }

  void removeItemFromList(T item) async {
    // Remove from local storage
    await cacheStorageManagement.deleteItem(allItems.indexOf(item));

    // Remove from lists
    allItems.remove(item);
    filteredItems.remove(item);
    selectedItems
      ..clear()
      ..addAll(List.generate(allItems.length, (index) => false));

    emit(DataTableLoadedState(filteredItems));
  }

  /// Method for toggling selection
  void toggleSelection(int index, bool? value) {
    selectedItems[index] = value ?? false;
    emit(DataTableLoadedState(filteredItems));
  }

  /// Method for adding new item
  void addNewItem(T item) async {
    allItems.add(item);
    filteredItems.add(item);
    selectedItems.add(false);

    // add item in cache storage
    final result = await cacheStorageManagement.storeItem(item);
    if (result.isLeft()) {
      // remove item from lists
      allItems.remove(item);
      filteredItems.remove(item);
      selectedItems.removeLast();
      Loaders.errorSnackBar(title: 'Error', message: 'Failed to add item');
      return;
    }

    if (!cacheStorageManagement.isCacheValid()) {
      await cacheStorageManagement.clearCacheStorage();
    }

    emit(DataTableLoadedState(filteredItems));
  }

  /// Method for editing an item
  void editItem(T item) async {
    final index = allItems.indexWhere((element) => element.id == item.id);
    if (index != -1) {
      // edit item in cache storage
      final result = await cacheStorageManagement.updateItem(item);
      if (result.isLeft()) {
        Loaders.errorSnackBar(title: 'Error', message: 'Failed to edit item');
        return;
      }
      // edit item in lists
      allItems[index] = item;
      filteredItems[index] = item;
      selectedItems[index] = false;

      // check if cache is valid then clear cache storage
      if (!cacheStorageManagement.isCacheValid()) {
        await cacheStorageManagement.clearCacheStorage();
      }

      emit(DataTableLoadedState(filteredItems));
    } else {
      emit(DataTableFailureState('Item not found'));
    }
  }

  /// Method for deleting item by index
  void deleteItemIndex(int index) async {
    // check if index is valid then delete item
    if (index < 0 || index >= allItems.length) {
      Loaders.errorSnackBar(title: 'Error', message: 'Invalid index');
      emit(DataTableFailureState('Item not found'));
      return;
    }

    // delete item in cache storage
    final result = await cacheStorageManagement.deleteItem(index);
    if (result.isLeft()) {
      Loaders.errorSnackBar(title: 'Error', message: 'Failed to delete item');
      return;
    }

    // delete item in lists
    allItems.removeAt(index);
    filteredItems.removeAt(index);
    selectedItems.removeAt(index);

    // check if cache is valid then clear cache storage
    if (!cacheStorageManagement.isCacheValid()) {
      await cacheStorageManagement.clearCacheStorage();
    }

    emit(DataTableLoadedState(filteredItems));
  }
}
