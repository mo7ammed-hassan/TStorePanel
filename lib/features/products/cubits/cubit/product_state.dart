part of 'product_cubit.dart';

sealed class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

final class ProductInitial extends ProductState {}

final class SelectedThumbnailImage extends ProductState {
  final String? selectedThumbnailImageUrl;
  const SelectedThumbnailImage(this.selectedThumbnailImageUrl);

  @override
  List<Object> get props => [selectedThumbnailImageUrl ?? ''];
}

final class SelectedAdditionalImage extends ProductState {
  final List<String> additionalProductImagesUrls;
  @override
  List<Object> get props => [additionalProductImagesUrls];

  // @override
  // List<Object> get props => [
  //   const DeepCollectionEquality().hash(additionalProductImagesUrls),
  // ];

  const SelectedAdditionalImage(this.additionalProductImagesUrls);
}
