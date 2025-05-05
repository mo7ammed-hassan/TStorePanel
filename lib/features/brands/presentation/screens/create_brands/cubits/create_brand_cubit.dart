import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store_admin_panel/config/service_locator/service_locator.dart';
import 'package:t_store_admin_panel/core/utils/dialogs/show_confirmation_dialog.dart';
import 'package:t_store_admin_panel/core/utils/popups/loaders.dart';
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
  final List<CategoryModel> selectedBrandCategories = <CategoryModel>[];
  bool isFeatured = false;
  final List<CategoryModel> categories = <CategoryModel>[];

  bool validateForm() => formKey.currentState?.validate() ?? false;

  Future<void> createBrand() async {
    if (!validateForm()) return;

    emit(CreateBrandLoadingState());
    CustomDialogs.showCircularLoader();

    final newBrand = BrandModel(
      id: '',
      name: brandNameController.text.trim(),
      image: imageUrl ?? '',
      isFeatured: isFeatured,
      productCount: 0,
      brandCategories: selectedBrandCategories,
      createdAt: DateTime.now(),
    );

    final result = await _brandRepo.createItem(newBrand);

    result.fold(
      (error) {
        CustomDialogs.hideLoader();
        if (!isClosed) emit(CreateBrandErrorState(error));
      },
      (brandId) async {
        newBrand.id = brandId;

        CustomDialogs.hideLoader();
        Loaders.successSnackBar(
          title: 'Congratulations',
          message: 'Brand created successfully.',
        );

        if (!isClosed) {
          emit(
            CreateBrandSuccessState('Brand created successfully.', newBrand),
          );
        }
      },
    );
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

  void pickImage() async {
    final mediaCubit = getIt<MediaCubit>();
    List<ImageModel>? selectedImages =
        await mediaCubit.selectionImagesFromMedia();

    if (selectedImages != null && selectedImages.isNotEmpty) {
      ImageModel selectedImage = selectedImages.first;
      imageUrl = selectedImage.url;
    }
  }

  void toggleIsFeatured(bool? value) {
    isFeatured = value ?? false;
    emit(ToggleFeatured(isFeatured));
  }

  void toggleCategorySelection(CategoryModel category) {
    if (selectedBrandCategories.contains(category)) {
      selectedBrandCategories.remove(category);
    } else {
      selectedBrandCategories.add(category);
    }
    emit(ToggleCategorySelectionState(selectedBrandCategories));
  }

  @override
  Future<void> close() {
    brandNameController.dispose();
    return super.close();
  }

  void resetForm() {
    brandNameController.clear();
    isFeatured = false;
  }
}
