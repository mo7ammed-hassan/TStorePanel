import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store_admin_panel/data/models/image/image_model.dart';
part 'media_action_state.dart';

class MediaActionCubit extends Cubit<MediaActionState> {
  MediaActionCubit() : super(MediaActionInitial());

  bool showMediaUploaderSection = false;

  final List<ImageModel> selectedImages = [];
  List<ImageModel> multiSelectionImages = [];

  void toggleMediaUploaderSection() {
    showMediaUploaderSection = !showMediaUploaderSection;
    emit(ToggleMediaUploaderSection(showMediaUploaderSection));
  }

  // Toggle Checkbox
  // we need to check if there are image selected in product when load
  void toggleImageCheckBox(
    ImageModel image,
    bool? selected,
    bool allowMultibleSelection,
  ) {
    if (selected != null) {
      image.isSelected = selected;

      if (selected) {
        if (!allowMultibleSelection) {
          for (var otherImage in selectedImages) {
            if (otherImage != image) {
              otherImage.isSelected = false;
              emit(ToggleImageCheckBox(otherImage));
            }
          }
          selectedImages.clear();
        }
        // allow multible selection
        selectedImages.add(image);
        emit(ToggleImageCheckBox(image));
      } else {
        selectedImages.remove(image);
        emit(ToggleImageCheckBox(image));
      }

      if (allowMultibleSelection) {
        multiSelectionImages = List.from(selectedImages);
      }
    }

    // debugPrint('Multi Selection Images Length: ${multiSelectionImages.length}');
  }

  // Reset Checkbox for all images
  // Use it when swapping path'Folders'
  // Use it when open add thumbnail image
  void resetCheckBox() {
    for (var image in selectedImages) {
      image.isSelected = false;
      emit(ToggleImageCheckBox(image));
    }
  }

  // Use it when swapping path'Folders' if needed 'IN MEDIA CUBIT 'changeCategory''
  void resetSelectedImages() {
    selectedImages.clear();
    //debugPrint('Selected Images Length: ${selectedImages.length}');
  }

  /// Use it when add multiple images
  void pickc() {
    for (var image in multiSelectionImages) {
      image.isSelected = true;
      emit(ToggleImageCheckBox(image));
    }
    selectedImages.clear();
    selectedImages.addAll(multiSelectionImages);
  }
}
