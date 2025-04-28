import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store_admin_panel/config/service_locator/service_locator.dart';
import 'package:t_store_admin_panel/core/utils/storage/cache_storage_mangement.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/collection_constants.dart';
import 'package:t_store_admin_panel/core/utils/utils/dialogs/show_confirmation_dialog.dart';
import 'package:t_store_admin_panel/core/utils/utils/popups/loaders.dart';
import 'package:t_store_admin_panel/data/models/brands/brand_model.dart';
import 'package:t_store_admin_panel/data/models/category/category_model.dart';
import 'package:t_store_admin_panel/data/repositories/brands/brand_repo.dart';
import 'package:t_store_admin_panel/features/brands/presentation/screens/edit_brands/cubit/edit_brand_states.dart';
import 'package:t_store_admin_panel/features/categories/cubits/category/category_cubit.dart';
import 'package:t_store_admin_panel/features/media/cubits/media/media_cubit.dart';

class EditBrandCubit extends Cubit<EditBrandStates> {
  EditBrandCubit(this.brandRepo, this._categoryCubit)
    : super(EditBrandInitialState()) {
    // Initialize cache storage management
    cacheStorageManagement.init();

    // Fetch categories
    fetchCategories();
  }

  final BrandRepo brandRepo;
  final CategoryCubit _categoryCubit;
  final CacheStorageManagement<BrandModel> cacheStorageManagement =
      CacheStorageManagementImpl(CollectionConstants.brands, 3);

  final TextEditingController brandNameController = TextEditingController();
  final List<CategoryModel> categories = [];
  final List<CategoryModel> selectedCategories = [];
  bool isFeatured = false;
  String? imageUrl = '';

  final formKey = GlobalKey<FormState>();
  bool validate() => formKey.currentState?.validate() ?? false;

  void initData(BrandModel? brand) {
    brandNameController.text = brand?.name ?? '';
    imageUrl = brand?.image ?? '';
    isFeatured = brand?.isFeatured ?? false;
    selectedCategories
      ..clear()
      ..addAll(brand?.brandCategories ?? []);
  }

  Future<void> updateBrand(BrandModel brand) async {
    if (!validate()) return;

    final updatedBrand = brand.copyWith(
      name: brandNameController.text.trim(),
      image: imageUrl,
      isFeatured: isFeatured,
      updatedAt: DateTime.now(),
      brandCategories: selectedCategories,
    );

    // Optimistic update: Emit Success before waiting
    //emit(EditBrandSuccessState(message: 'Updating Brand...'));
    CustomDialogs.showCircularLoader();

    if (BrandModel.isSameModel(brand, updatedBrand)) {
      CustomDialogs.hideLoader();
      Loaders.warningSnackBar(
        message: 'No changes detected!',
        title: 'Warning',
      );
      return;
    }

    final result = await brandRepo.updateItem(updatedBrand);

    await result.fold(
      (error) async {
        CustomDialogs.hideLoader();
        Loaders.errorSnackBar(message: error, title: 'Oops!');
        if (!isClosed) emit(EditBrandErrorState(errorMessage: error));
      },
      (_) async {
        await cacheStorageManagement.updateItem(updatedBrand);
        CustomDialogs.hideLoader();
        Loaders.successSnackBar(
          message: 'Brand updated successfully',
          title: 'Congratulations',
        );
        if (!isClosed) emit(EditBrandCompletedState(brand: updatedBrand));
      },
    );
  }

  Future<void> pickImage() async {
    final mediaCubit = getIt<MediaCubit>();
    final selectedImages = await mediaCubit.selectionImagesFromMedia();

    if (selectedImages != null && selectedImages.isNotEmpty) {
      final selectedImage = selectedImages.first;
      imageUrl = selectedImage.url;

      // Instant UI feedback
      if (!isClosed) emit(EditBrandImagePickedState(imageUrl!));
    }
  }

  void toggleIsFeatured(bool? value) {
    final newValue = value ?? false;
    if (isFeatured != newValue) {
      isFeatured = newValue;
      emit(ToggleFeatured(isFeatured));
    }
  }

  void toggleSelectedCategory(CategoryModel category) {
    if (selectedCategories.contains(category)) {
      selectedCategories.remove(category);
    } else {
      selectedCategories.add(category);
    }
    emit(ToggleBrandSelectionState(List.from(selectedCategories)));
  }

  Future<void> fetchCategories() async {
    final result = await _categoryCubit.fetchItems();
    if (isClosed) return;
    result.fold((error) => null, (success) {
      categories.clear();
      categories.addAll(success);
      emit(FetchCategoriesState(categories));
    });
  }

  @override
  Future<void> close() {
    brandNameController.dispose();
    return super.close();
  }
}
