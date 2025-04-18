import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store_admin_panel/core/utils/utils/dialogs/show_confirmation_dialog.dart';
import 'package:t_store_admin_panel/core/utils/utils/popups/loaders.dart';
import 'package:t_store_admin_panel/data/models/category/category_model.dart';
import 'package:t_store_admin_panel/domain/repositories/category/category_repo.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit(this.categoryRepo) : super(CategoryInitial());

  final CategoryRepo categoryRepo;

  bool sortAscending = true;
  int sortColumnIndex = 1;

  final List<CategoryModel> categories = [];
  final List<CategoryModel> filteredCategories = [];

  final List<bool> selectedCategories = <bool>[];

  // Fetch categories
  Future<void> fetchCategories() async {
    emit(CategoryLoadingState());

    if (categories.isNotEmpty &&
        filteredCategories.isNotEmpty &&
        selectedCategories.isNotEmpty) {
      emit(CategoryLoadedState(categories));
    }

    final result = await categoryRepo.fetchCategories();
    if (isClosed) return;

    result.fold((error) => emit(CategoryErrorState(error)), (categories) {
      this.categories
        ..clear()
        ..addAll(categories);
      filteredCategories
        ..clear()
        ..addAll(categories);

      selectedCategories
        ..clear()
        ..addAll(List.generate(categories.length, (index) => false));
      emit(CategoryLoadedState(categories));
    });
  }

  // -- Unified Sort Method --
  void sortByColumn(int columnIndex, bool ascending) {
    sortColumnIndex = columnIndex;
    sortAscending = ascending;

    final sortedList = [...filteredCategories]..sort((a, b) {
      switch (columnIndex) {
        case 0: // Category name
          return ascending
              ? a.name.toLowerCase().compareTo(b.name.toLowerCase())
              : b.name.toLowerCase().compareTo(a.name.toLowerCase());
        case 1: // Parent ID
          return ascending
              ? a.parentId.toLowerCase().compareTo(b.parentId.toLowerCase())
              : b.parentId.toLowerCase().compareTo(a.parentId.toLowerCase());
        case 2: // Featured
          return ascending
              ? a.isFeatured.toString().compareTo(b.isFeatured.toString())
              : b.isFeatured.toString().compareTo(a.isFeatured.toString());
        // case 3: // Date
        //   return ascending
        //       ? a.createdAt!.compareTo(b.createdAt!)
        //       : b.createdAt!.compareTo(a.createdAt!);
        default:
          return 0;
      }
    });

    emit(CategoryLoadedState(sortedList));
  }

  // -- Search --
  void searchCategories(String query) {
    filteredCategories.clear();

    if (query.isEmpty) {
      filteredCategories.addAll(categories);
    } else {
      filteredCategories.addAll(
        categories.where(
          (category) =>
              category.name.toLowerCase().contains(query.toLowerCase()),
        ),
      );
    }

    emit(CategoryLoadedState(filteredCategories));
  }

  // -- Delete Category --
  // show confirmation dialog
  Future<void> showDeleteConfirmationDialog(CategoryModel category) async {
    final result = await CustomDialogs.showConfirmationDialog(
      title: 'Delete Category',
      message: 'Are you sure you want to delete this category?',
      confirmButtonText: 'Delete',
      cancelButtonText: 'Cancel',
    );

    if (result) {
      await deleteCategory(category);
    }
  }

  Future<void> deleteCategory(CategoryModel category) async {
    CustomDialogs.showCircularLoader();

    final result = await categoryRepo.deleteCategory(category);
    if (isClosed) return;

    result.fold((error) => emit(CategoryErrorState(error)), (_) {
      removeItemFromList(category);
      CustomDialogs.hideLoader();

      Loaders.successSnackBar(
        title: 'Item Deleted',
        message: 'Your item has been deleted successfully.',
      );

      emit(CategoryLoadedState(List<CategoryModel>.from(categories)));
    });
  }

  void toggleSelection(int index, bool? value) {
    selectedCategories[index] = value ?? false;
    final newList = List<CategoryModel>.from(categories);
    emit(CategoryLoadedState(newList));
  }

  // -- remove item from list
  void removeItemFromList(CategoryModel category) {
    categories.remove(category);
    filteredCategories.remove(category);
    selectedCategories.addAll(
      List.generate(categories.length, (index) => false),
    );
  }

  void updateCategoriesState() {
    emit(CategoryLoadedState(categories));
  }
}
