part of 'product_cubit.dart';

sealed class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

final class ProductInitial extends ProductState {}

final class ProductsLoadingState extends ProductState {}

final class ProductsLoadedState extends ProductState {
  final List<ProductModel> products;
  const ProductsLoadedState(this.products);

  @override
  List<Object> get props => [products];
}

final class ProductErrorState extends ProductState {
  final String message;
  const ProductErrorState(this.message);
}

final class DeleteItemFailureState extends ProductState {
  final String error;

  const DeleteItemFailureState(this.error);
}

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
