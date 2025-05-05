import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store_admin_panel/config/service_locator/service_locator.dart';
import 'package:t_store_admin_panel/core/utils/dialogs/show_confirmation_dialog.dart';
import 'package:t_store_admin_panel/core/utils/popups/loaders.dart';
import 'package:t_store_admin_panel/data/models/category/category_model.dart';
import 'package:t_store_admin_panel/data/models/image/image_model.dart';
import 'package:t_store_admin_panel/domain/repositories/category/category_repo.dart';
import 'package:t_store_admin_panel/features/categories/cubits/create_category/create_category_state.dart';
import 'package:t_store_admin_panel/features/media/cubits/media/media_cubit.dart';

class CreateCategoryCubit extends Cubit<CreateCategoryState> {
  CreateCategoryCubit(this.categoryRepo) : super(CreateCategoryInitial());

  final CategoryRepo categoryRepo;

  // Form
  final formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();

  CategoryModel selectedParent = CategoryModel.empty();
  String imageUrl = '';
  bool isFeatured = false;

  // Create Category
  Future<void> createCategory() async {
    // check if form is valid
    if (!formKey.currentState!.validate()) return;

    emit(CreateCategoryLoadingState());
    CustomDialogs.showCircularLoader();

    // check Internet connection
    // final isConnected = await NetworkManager.instance.isConnected();
    // if (!isConnected) {
    //   CustomDialogs.hideLoader();
    //   Loaders.errorSnackBar(title: 'Error', message: 'No Internet Connection');
    //   return;
    // }

    // map data
    final category = CategoryModel(
      id: '',
      name: nameController.text.trim(),
      image: imageUrl,
      isFeatured: isFeatured,
      parentId: selectedParent.id!,
      createdAt: DateTime.now(),
    );

    var result = await categoryRepo.createCategory(category);
    if (isClosed) return;

    result.fold(
      (error) {
        CustomDialogs.hideLoader();
        emit(CreateCategoryFailureState(error));
      },
      (id) async {
        category.id = id;

        CustomDialogs.hideLoader();
        Loaders.successSnackBar(
          title: 'Congratulations',
          message: 'Category created successfully.',
        );

        getIt<MediaCubit>().reset();

        emit(CreateCategorySuccessState(category));
      },
    );
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

  void resetForm() {
    nameController.clear();
    imageUrl = '';
    isFeatured = false;
  }

  @override
  Future<void> close() {
    nameController.dispose();
    return super.close();
  }
}
