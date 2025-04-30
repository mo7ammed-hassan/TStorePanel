import 'package:dartz/dartz.dart';
import 'package:t_store_admin_panel/data/models/brands/brand_category_model.dart';

mixin BrandMixin {
  Future<Either<String, List<BrandCategoryModel>>> fetcCategoriesBrand();

  Future<Either<String, String>> createBrandCategory(
    BrandCategoryModel brandCategory,
  );

  Future<Either<String, void>> updateCategoryBrand(
    BrandCategoryModel brandCategory,
  );

  Future<Either<String, void>> deleteCategoryBrand(
    BrandCategoryModel brandCategory,
  );
}
