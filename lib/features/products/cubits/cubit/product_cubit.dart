import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store_admin_panel/config/service_locator/service_locator.dart';
import 'package:t_store_admin_panel/data/models/image/image_model.dart';
import 'package:t_store_admin_panel/features/media/cubits/actions/media_action_cubit.dart';
import 'package:t_store_admin_panel/features/media/cubits/media/media_cubit.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());

  String? selectedThumbnailImageUrl = '';
  List<String> additionalProductImagesUrls = [];

  // instance from media cubit
  final mediaCubit = getIt<MediaCubit>();
  final mediaActionCubit = getIt<MediaActionCubit>();

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
}
