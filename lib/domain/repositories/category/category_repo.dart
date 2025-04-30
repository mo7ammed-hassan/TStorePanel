import 'package:dartz/dartz.dart';
import 'package:t_store_admin_panel/data/models/category/category_model.dart';

abstract class CategoryRepo {
  Future<Either<String, List<CategoryModel>>> fetchCategories();

  Future<Either<String, String>> createCategory(CategoryModel category);

  Future<Either<String, Unit>> updateCategory(CategoryModel category);

  Future<Either<String, Unit>> deleteCategory(CategoryModel category);
}
