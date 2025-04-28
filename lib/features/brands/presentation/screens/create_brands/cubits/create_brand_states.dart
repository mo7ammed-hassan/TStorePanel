import 'package:t_store_admin_panel/data/models/brands/brand_model.dart';
import 'package:t_store_admin_panel/data/models/category/category_model.dart';

sealed class CreateBrandStates {}

class CreateBrandInitialState extends CreateBrandStates {}

class CreateBrandLoadingState extends CreateBrandStates {}

class CreateBrandSuccessState extends CreateBrandStates {
  final String message;
  final BrandModel brand;
  CreateBrandSuccessState(this.message, this.brand);
}

class CreateBrandErrorState extends CreateBrandStates {
  final String errorMessage;
  CreateBrandErrorState(this.errorMessage);
}

class FetchCategoriesState extends CreateBrandStates {
  final List<CategoryModel> categories;
  FetchCategoriesState(this.categories);
}

class ToggleFeatured extends CreateBrandStates {
  final bool isFeatured;
  ToggleFeatured(this.isFeatured);
}

class ToggleCategorySelectionState extends CreateBrandStates {
  final List<CategoryModel> selectedCategories;
  ToggleCategorySelectionState(this.selectedCategories);
}
