import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store_admin_panel/core/utils/storage/cache_storage_mangement.dart';
import 'package:t_store_admin_panel/core/utils/utils/popups/loaders.dart';
import 'package:t_store_admin_panel/data/abstract/base_data_table_states.dart';

import '../../core/utils/utils/dialogs/show_confirmation_dialog.dart';

abstract class BaseDataTableCubit<T> extends Cubit<BaseDataTableStates> {
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
  Future<Either<String, void>> deleteItem(T item);

  /// Method for searching data
  bool containSearchQuery(T item, String query);

  Future<void> fetchData() async {
    emit(DataTableLoadingState());

    // Try cache first
    final cachedData = await cacheStorageManagement.fetchData();
    if (cachedData.isNotEmpty) {
      _updateLists(cachedData);
      emit(DataTableLoadedState(filteredItems));
      return;
    }

    // Fetch from Database
    final result = await fetchItems();
    if (isClosed) return;

    result.fold(
      (error) {
        if (allItems.isEmpty) emit(DataTableFailureState(error));
      },
      (items) async {
        _updateLists(items);
        await cacheStorageManagement.storeData(items);
        emit(DataTableLoadedState(filteredItems));
      },
    );
  }

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

  /// Method for show dialog for deleting data
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

    result.fold((error) => emit(DataTableFailureState(error)), (_) {
      removeItemFromList(item);

      CustomDialogs.hideLoader();
      Loaders.successSnackBar(
        title: 'Item Deleted',
        message: 'Your item has been deleted successfully.',
      );

      emit(DataTableLoadedState(List<T>.from(allItems)));
    });
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

  /// Method for updating state
  void updateState() {
    emit(DataTableLoadedState(filteredItems));
  }
}
