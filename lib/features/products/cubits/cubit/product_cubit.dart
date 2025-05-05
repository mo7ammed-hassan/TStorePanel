import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store_admin_panel/config/service_locator/service_locator.dart';
import 'package:t_store_admin_panel/core/utils/dialogs/show_confirmation_dialog.dart';
import 'package:t_store_admin_panel/core/utils/popups/loaders.dart';
import 'package:t_store_admin_panel/data/abstract/repos/generic_repository.dart';
import 'package:t_store_admin_panel/data/models/image/image_model.dart';
import 'package:t_store_admin_panel/data/models/product/product_model.dart';
import 'package:t_store_admin_panel/features/media/cubits/actions/media_action_cubit.dart';
import 'package:t_store_admin_panel/features/media/cubits/media/media_cubit.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit(this.productRepo) : super(ProductInitial()) {
    init();
  }
  final GenericRepository<ProductModel> productRepo;

  final List<ProductModel> allProducts = [];
  final List<bool> selectedRows = [];
  String? selectedThumbnailImageUrl = '';
  List<String> additionalProductImagesUrls = [];

  // instance from media cubit
  final mediaCubit = getIt<MediaCubit>();
  final mediaActionCubit = getIt<MediaActionCubit>();

  /// -- init--
  void init() async {
    await fetchProducts();
  }

  Future<void> fetchProducts() async {
    emit(ProductsLoadingState());

    var result = await productRepo.fetchItems();
    result.fold(
      (error) {
        emit(ProductErrorState(error));
      },
      (data) {
        debugPrint('Products Length: ${data.length}');
        allProducts
          ..clear
          ..addAll(data);
        selectedRows
          ..clear()
          ..addAll(List.generate(data.length, (index) => false));
        emit(ProductsLoadedState(data));
      },
    );
  }

  /// -- Select Thumbnail Image --
  void selectThumbnailImage() async {
    // Reset selected images
    mediaActionCubit.resetCheckBox();

    // trigger selection of images
    List<ImageModel>? selectedImages =
        await mediaCubit.selectionImagesFromMedia();

    // Handle selected images
    if (selectedImages != null && selectedImages.isNotEmpty) {
      // set the selected image to the main image
      ImageModel selectedImage = selectedImages.first;
      // update selected thumbnail image
      selectedThumbnailImageUrl = selectedImage.url;

      // emit selected thumbnail image
      emit(SelectedThumbnailImage(selectedThumbnailImageUrl));

      // because we select thumbnail image only once .. we must reset the checkbox for this image
      mediaActionCubit.toggleImageCheckBox(selectedImage, false, false);
    }

    debugPrint('Selected Thumbnail Image: $selectedThumbnailImageUrl');
  }

  /// -- Select Additional Images --
  void selectAdditionalImage() async {
    //
    mediaActionCubit.pickc();
    // pass select additional images from bottom sheet
    final List<ImageModel>? selectedImages = await mediaCubit
        .selectionImagesFromMedia(
          allowMultiSelection: true,
          selectedImagesUrls: additionalProductImagesUrls,
        );

    // Handle selected images
    if (selectedImages != null && selectedImages.isNotEmpty) {
      additionalProductImagesUrls = List.from(selectedImages.map((e) => e.url));
      emit(SelectedAdditionalImage(additionalProductImagesUrls));
    }

    debugPrint(
      'Additional Images Length: ${additionalProductImagesUrls.length}',
    );
  }

  /// -- Remove Additional Image --
  void removeImage(int index) async {
    additionalProductImagesUrls.removeAt(index);
    emit(SelectedThumbnailImage(selectedThumbnailImageUrl));
  }

  /// -- show confirmation dialog for deleting --
  Future<void> confirmDeleteDialog(ProductModel product) async {
    final result = await CustomDialogs.showConfirmationDialog(
      title: 'Delete Item',
      message: 'Are you sure you want to delete this Item?',
      confirmButtonText: 'Delete',
      cancelButtonText: 'Cancel',
    );

    if (result) {
      await deleteItemOnConfirmation(product);
    }
  }

  // -- delete item on confirmation --
  Future<void> deleteItemOnConfirmation(ProductModel product) async {
    CustomDialogs.showCircularLoader();

    final result = await productRepo.deleteItem(product);
    if (isClosed) return;

    result.fold(
      (error) {
        CustomDialogs.hideLoader();
        Loaders.errorSnackBar(
          title: 'Error',
          message: 'Failed to delete item.\n$error',
        );
        emit(DeleteItemFailureState(error));
      },
      (_) {
        removeItemFromList(product);

        CustomDialogs.hideLoader();
        Loaders.successSnackBar(
          title: 'Item Deleted',
          message: 'Your item has been deleted successfully.',
        );

        emit(ProductsLoadedState(List.from(allProducts)));
      },
    );
  }

  /// -- remove item from list --
  void removeItemFromList(ProductModel item) {
    final index = allProducts.indexOf(item);
    // // Remove from local storage
    // cacheStorageManagement.deleteItem(allProducts.indexOf(item));

    // Remove from lists
    allProducts.remove(item);
    selectedRows.removeAt(index);

    emit(ProductsLoadedState(List.from(allProducts)));
  }

 
}
