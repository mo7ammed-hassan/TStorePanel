import 'package:either_dart/either.dart';
import 'package:t_store_admin_panel/data/models/category/category_model.dart';

abstract class CategoryRepo {
  // fetrch all categories
  Future<Either<String, List<CategoryModel>>> fetchCategories();

  // create new category
  Future<Either<String, String>> createCategory(CategoryModel category);

  // update category
  Future<Either<String, CategoryModel>> updateCategory(CategoryModel category);

  // delete category
  Future<Either<String, void>> deleteCategory(CategoryModel category);
}
