import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store_admin_panel/data/models/image/image_model.dart';
part 'media_action_state.dart';

class MediaActionCubit extends Cubit<MediaActionState> {
  MediaActionCubit() : super(MediaActionInitial());

  bool showMediaUploaderSection = false;
  bool imageIsSelected = false;

  final List<ImageModel> selectedImages = [];

  void toggleMediaUploaderSection() {
    showMediaUploaderSection = !showMediaUploaderSection;
    emit(ToggleMediaUploaderSection(showMediaUploaderSection));
  }

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
              //selectedImages.remove(otherImage);
            }
          }
          selectedImages.clear();
        }
        selectedImages.add(image);
      } else {
        selectedImages.remove(image);
      }

      emit(ToggleImageCheckBox(List.of(selectedImages)));
    }
  }

  // Reset State
  void resetCheckBox() {
    imageIsSelected = false;
    selectedImages.clear();
    emit(MediaActionInitial());
  }
}
