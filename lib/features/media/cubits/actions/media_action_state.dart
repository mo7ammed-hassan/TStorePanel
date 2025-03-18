part of 'media_action_cubit.dart';

sealed class MediaActionState {}

final class MediaActionInitial extends MediaActionState {}

final class ToggleMediaUploaderSection extends MediaActionState {
  final bool showMediaUploaderSection;

  ToggleMediaUploaderSection(this.showMediaUploaderSection);
}

final class ToggleImageCheckBox extends MediaActionState {
  final List<ImageModel> selectedImagesCheckBox;

  ToggleImageCheckBox(this.selectedImagesCheckBox);
}
