import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store_admin_panel/config/service_locator/service_locator.dart';
import 'package:t_store_admin_panel/core/utils/utils/dialogs/show_confirmation_dialog.dart';
import 'package:t_store_admin_panel/core/utils/utils/popups/loaders.dart';
import 'package:t_store_admin_panel/data/models/category/category_model.dart';
import 'package:t_store_admin_panel/data/models/image/image_model.dart';
import 'package:t_store_admin_panel/domain/repositories/category/category_repo.dart';
import 'package:t_store_admin_panel/features/categories/cubits/edit_category/edit_category_state.dart';
import 'package:t_store_admin_panel/features/media/cubits/media/media_cubit.dart';

class EditCategoryCubit extends Cubit<EditCategoryState> {
  EditCategoryCubit(this.categoryRepo) : super(EditCategoryInitial());
  final CategoryRepo categoryRepo;

  // Form
  final formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();

  CategoryModel selectedParent = CategoryModel.empty();
  String? imageUrl = '';
  bool isFeatured = false;

  bool _isInitialized = false; //  To prevent double init

  void initData(CategoryModel? category, List<CategoryModel> allCategories) {
    if (_isInitialized) return;
    _isInitialized = true;

    nameController.text = category?.name ?? '';
    imageUrl = category?.image ?? '';
    isFeatured = category?.isFeatured ?? false;

    if (category?.parentId != null && category!.parentId.isNotEmpty) {
      selectedParent = allCategories.firstWhere(
        (item) => item.id == category.parentId,
        orElse: () => CategoryModel.empty(),
      );
    }
  }

  // update Category
  Future<void> updateCategory(CategoryModel category) async {
    emit(EditCategoryLoadingState());

    if (!formKey.currentState!.validate()) return;

    CustomDialogs.showCircularLoader();

    // map data
    category.image = imageUrl;
    category.isFeatured = isFeatured;
    category.parentId = selectedParent.id;
    category.name = nameController.text.trim();
    category.updatedAt = DateTime.now();

    var result = await categoryRepo.updateCategory(category);

    result.fold((error) => emit(EditCategoryFailureState(error)), (_) {
      CustomDialogs.hideLoader();

      Loaders.successSnackBar(
        message: 'Category updated successfully',
        title: 'Success',
      );

      emit(EditCategorySuccessState(category));
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

  // reset all fields
  void reset() {
    emit(EditCategoryInitial());
  }

  @override
  Future<void> close() {
    nameController.dispose();
    return super.close();
  }
}
