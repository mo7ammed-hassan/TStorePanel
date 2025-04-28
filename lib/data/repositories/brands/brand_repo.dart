import 'package:either_dart/either.dart';
import 'package:t_store_admin_panel/data/abstract/repos/generic_repository.dart';
import 'package:t_store_admin_panel/data/models/brands/brand_model.dart';
import 'package:t_store_admin_panel/data/services/brands/brand_firebase_services.dart';

class BrandRepo implements GenericRepository<BrandModel> {
  final BrandFirebaseServices _firebaseServices;

  BrandRepo(this._firebaseServices);
  @override
  Future<Either<String, String>> createItem(item) async {
    return await _firebaseServices.createBrand(item);
  }

  @override
  Future<Either<String, void>> deleteItem(item) async {
    return await _firebaseServices.deleteBrand(item);
  }

  @override
  Future<Either<String, List<BrandModel>>> fetchItems() async {
    return await _firebaseServices.fetchBrands();
  }

  @override
  Future<Either<String, void>> updateItem(item) async {
    return await _firebaseServices.updateBrand(item);
  }
}
