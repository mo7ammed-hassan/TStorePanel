import 'package:either_dart/either.dart';
import 'package:t_store_admin_panel/data/models/category/category_model.dart';
import 'package:t_store_admin_panel/data/services/category/category_firebase_services.dart';
import 'package:t_store_admin_panel/domain/repositories/category/category_repo.dart';

class CategoryRepoImpl implements CategoryRepo {
  final CategoryFirebaseServices _categoryFirebaseServices;

  CategoryRepoImpl(this._categoryFirebaseServices);
  @override
  Future<Either<String, String>> createCategory(
    CategoryModel category,
  ) async {
    return await _categoryFirebaseServices.createCategory(category);
  }

  @override
  Future<Either<String, void>> deleteCategory(CategoryModel category) async {
    return await _categoryFirebaseServices.deleteCategory(category);
  }

  @override
  Future<Either<String, List<CategoryModel>>> fetchCategories() async {
    return await _categoryFirebaseServices.fetchCategories();
  }

  @override
  Future<Either<String, void>> updateCategory(
    CategoryModel category,
  ) async {
    return await _categoryFirebaseServices.updateCategory(category);
  }
}
