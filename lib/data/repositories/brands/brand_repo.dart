import 'package:either_dart/either.dart';
import 'package:t_store_admin_panel/data/abstract/repos/generic_repository.dart';
import 'package:t_store_admin_panel/data/models/brands/brand_category_model.dart';
import 'package:t_store_admin_panel/data/models/brands/brand_model.dart';
import 'package:t_store_admin_panel/data/services/brands/brand_mixin.dart';
import 'package:t_store_admin_panel/data/services/brands/brands_firebase_services.dart';

class BrandRepo extends GenericRepository<BrandModel> with BrandMixin {
  final BrandsFirebaseServices _firebaseServices;

  BrandRepo(this._firebaseServices);
  @override
  Future<Either<String, String>> createItem(item) async {
    return await _firebaseServices.createItem(item);
  }

  @override
  Future<Either<String, void>> deleteItem(item) async {
    return await _firebaseServices.deleteItem(item);
  }

  @override
  Future<Either<String, List<BrandModel>>> fetchItems() async {
    return await _firebaseServices.fetchItems();
  }

  @override
  Future<Either<String, void>> updateItem(item) async {
    return await _firebaseServices.updateItem(item);
  }

  @override
  Future<Either<String, List<BrandCategoryModel>>> fetcCategoriesBrand() async {
    return await _firebaseServices.fetcCategoriesBrand();
  }
}
