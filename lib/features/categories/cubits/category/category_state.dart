part of 'category_cubit.dart';

sealed class CategoryState {
  const CategoryState();
}

final class CategoryInitial extends CategoryState {}

final class CategoryLoadedState extends CategoryState {
  final List<CategoryModel> categories;
  const CategoryLoadedState(this.categories);
}

final class CategoryErrorState extends CategoryState {
  final String error;
  const CategoryErrorState(this.error);
}

final class CategoryLoadingState extends CategoryState {}

final class ToggleState extends CategoryState {}
