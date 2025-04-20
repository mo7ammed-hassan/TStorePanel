import 'package:either_dart/either.dart';
import 'package:t_store_admin_panel/data/models/brands/brand_category_model.dart';

mixin BrandMixin {
  Future<Either<String, List<BrandCategoryModel>>> fetcCategoriesBrand();
}
