import 'package:t_store_admin_panel/data/models/category/category_model.dart';

abstract class EditCategoryState {}

class EditCategoryInitial extends EditCategoryState {}

class EditCategoryFailureState extends EditCategoryState {
  final String error;

  EditCategoryFailureState(this.error);
}

class EditCategorySuccessState extends EditCategoryState {
  final CategoryModel category;

  EditCategorySuccessState(this.category);
}

class EditCategoryLoadingState extends EditCategoryState {}

class ToggleFeatured extends EditCategoryState {
  final bool isFeatured;

  ToggleFeatured(this.isFeatured);
}