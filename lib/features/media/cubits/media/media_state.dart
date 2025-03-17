part of 'media_cubit.dart';

sealed class MediaState {}

final class MediaInitial extends MediaState {}

/// -- Selected Category States --
final class SelectedCategoryState extends MediaState {}

/// -- Selected Images States --
final class SelectedImagesLoadedState extends MediaState {}

final class SelectedImagesFailedState extends MediaState {}

/// -- Uploaded Images States --
final class UploadedImagesSuccessState extends MediaState {
  final String title;
  final String message;

  UploadedImagesSuccessState(this.title, this.message);
}

final class UploadImagesFailureState extends MediaState {
  final ErrorModel errorModel;

  UploadImagesFailureState(this.errorModel);
}

final class UploadedImagesLoadingState extends MediaState {}

/// -- Fetch Images States --
final class FetchImagesLoadingState extends MediaState {}

final class FetchImagesSuccessState extends MediaState {
  final List<ImageModel> images;

  FetchImagesSuccessState(this.images);
}

final class FetchImagesFailureState extends MediaState {
  final String error;

  FetchImagesFailureState(this.error);
}

/// -- Delete Images States --
final class DeleteImageSuccessState extends MediaState {}

final class DeleteImageFailureState extends MediaState {
  final String? error;

  DeleteImageFailureState(this.error);
}

final class DeleteImageLoadingState extends MediaState {}
