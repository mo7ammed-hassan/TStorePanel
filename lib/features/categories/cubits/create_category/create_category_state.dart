import 'package:t_store_admin_panel/data/models/category/category_model.dart';

abstract class CreateCategoryState {}

class CreateCategoryInitial extends CreateCategoryState {}

class CreateCategorySuccessState extends CreateCategoryState {
  final CategoryModel category;

  CreateCategorySuccessState(this.category);
}

class CreateCategoryLoadingState extends CreateCategoryState {}

class CreateCategoryFailureState extends CreateCategoryState {
  final String error;

  CreateCategoryFailureState(this.error);
}

class ToggleFeatured extends CreateCategoryState {
  final bool isFeatured;

  ToggleFeatured(this.isFeatured);
}
