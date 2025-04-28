import 'package:t_store_admin_panel/data/models/brands/brand_model.dart';
import 'package:t_store_admin_panel/data/models/category/category_model.dart';

sealed class EditBrandStates {}

// Initial
class EditBrandInitialState extends EditBrandStates {}

// Loading
class EditBrandLoadingState extends EditBrandStates {}

// Success
class EditBrandSuccessState extends EditBrandStates {
  final String message;
  EditBrandSuccessState({required this.message});
}

// Completed after full update
class EditBrandCompletedState extends EditBrandStates {
  final BrandModel brand;
  EditBrandCompletedState({required this.brand});
}

// Error
class EditBrandErrorState extends EditBrandStates {
  final String errorMessage;
  EditBrandErrorState({required this.errorMessage});
}

// Toggle Featured
class ToggleFeatured extends EditBrandStates {
  final bool isFeatured;
  ToggleFeatured(this.isFeatured);
}

// Toggle Category Selection
class ToggleBrandSelectionState extends EditBrandStates {
  final List<CategoryModel> selectedCategories;
  ToggleBrandSelectionState(this.selectedCategories);
}

// Image Picked
class EditBrandImagePickedState extends EditBrandStates {
  final String imageUrl;
  EditBrandImagePickedState(this.imageUrl);
}

class FetchCategoriesState extends EditBrandStates {
  final List<CategoryModel> categories;
  FetchCategoriesState(this.categories);
}
