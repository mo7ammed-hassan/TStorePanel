import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store_admin_panel/config/service_locator/service_locator.dart';
import 'package:t_store_admin_panel/core/utils/storage/cache_storage_mangement.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/collection_constants.dart';
import 'package:t_store_admin_panel/core/utils/utils/dialogs/show_confirmation_dialog.dart';
import 'package:t_store_admin_panel/core/utils/utils/popups/loaders.dart';
import 'package:t_store_admin_panel/data/models/brands/brand_category_model.dart';
import 'package:t_store_admin_panel/data/models/brands/brand_model.dart';
import 'package:t_store_admin_panel/data/models/category/category_model.dart';
import 'package:t_store_admin_panel/data/models/image/image_model.dart';
import 'package:t_store_admin_panel/data/repositories/brands/brand_repo.dart';
import 'package:t_store_admin_panel/features/brands/presentation/screens/create_brands/cubits/create_brand_states.dart';
import 'package:t_store_admin_panel/features/categories/cubits/category/category_cubit.dart';
import 'package:t_store_admin_panel/features/media/cubits/media/media_cubit.dart';

class CreateBrandCubit extends Cubit<CreateBrandStates> {
  CreateBrandCubit(this._brandRepo, this._categoryCubit)
    : super(CreateBrandInitialState());

  final BrandRepo _brandRepo;
  final CategoryCubit _categoryCubit;

  final formKey = GlobalKey<FormState>();
  final TextEditingController brandNameController = TextEditingController();
  String? imageUrl = '';
  final List<CategoryModel> brandCategories = <CategoryModel>[];
  bool? isFeatured = false;
  final List<CategoryModel> categories = <CategoryModel>[];

  final CacheStorageManagement<BrandModel> cacheStorageManagement =
      CacheStorageManagementImpl(CollectionConstants.brands, 3)..init();

  // validatetion
  bool validateForm() => formKey.currentState?.validate() ?? false;

  Future<void> createBrand() async {
    if (!validateForm()) return;

    emit(CreateBrandLoadingState());
    CustomDialogs.showCircularLoader();

    final brand = BrandModel(
      id: '',
      name: brandNameController.text,
      image: imageUrl ?? '',
      isFeatured: isFeatured ?? false,
      productCount: 0,
      brandCategories: brandCategories,
      createdAt: DateTime.now(),
    );

    final result = await _brandRepo.createItem(brand);

    if (result.isLeft) {
      CustomDialogs.hideLoader();
      if (isClosed) return;
      emit(CreateBrandErrorState(result.fold((e) => e, (_) => '')));
      return;
    }

    brand.id = result.isRight ? result.right : '';

    bool hasError = false;

    for (var category in brandCategories) {
      final brandCategory = BrandCategoryModel(
        brandId: brand.id!,
        categoryId: category.id,
      );

      final brandCategoryResult = await _brandRepo.createBrandCategory(
        brandCategory,
      );

      if (brandCategoryResult.isLeft) {
        hasError = true;
        CustomDialogs.hideLoader();
        if (isClosed) return;
        emit(
          CreateBrandErrorState(brandCategoryResult.fold((e) => e, (_) => '')),
        );
        break;
      }
    }

    if (!hasError) {
      await cacheStorageManagement.storeItem(brand);
      CustomDialogs.hideLoader();

      if (isClosed) return;

      Loaders.successSnackBar(
        title: 'Congratulations',
        message: 'Brand created successfully.',
      );
      await cacheStorageManagement.restartCacheDuration();
      emit(CreateBrandSuccessState('Brand created successfully.', brand));
    }
  }

  // get all categories
  Future<void> fetchCategories() async {
    final result = await _categoryCubit.fetchItems();
    if (isClosed) return;
    return result.fold((error) => [], (success) {
      categories.clear();
      categories.addAll(success);
      emit(FetchCategoriesState(categories));
    });
  }

  // pick thumbnail image from media
  void pickImage() async {
    final mediaCubit = getIt<MediaCubit>();
    List<ImageModel>? selectedImages =
        await mediaCubit.selectionImagesFromMedia();

    if (selectedImages != null && selectedImages.isNotEmpty) {
      ImageModel selectedImage = selectedImages.first;
      imageUrl = selectedImage.url;
    }
  }

  // toggle isFeatured
  void toggleIsFeatured(bool? value) {
    isFeatured = value ?? false;
    emit(ToggleFeatured(isFeatured));
  }

  void toggleCategorySelection(CategoryModel category) {
    if (brandCategories.contains(category)) {
      brandCategories.remove(category);
    } else {
      brandCategories.add(category);
    }
    emit(ToggleCategorySelectionState(brandCategories));
  }
}
