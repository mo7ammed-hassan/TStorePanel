import 'package:dartz/dartz.dart';
import 'package:t_store_admin_panel/data/abstract/repos/generic_repository.dart';
import 'package:t_store_admin_panel/data/models/product/product_model.dart';
import 'package:t_store_admin_panel/data/services/abstract/generic_firebase_services.dart';

class ProductRepoImpl extends GenericRepository<ProductModel> {
  final GenericFirebaseServices<ProductModel> genericFirebaseServices;

  ProductRepoImpl(this.genericFirebaseServices);

  @override
  Future<Either<String, String>> createItem(ProductModel item) async {
    return await genericFirebaseServices.createItem(item);
  }

  @override
  Future<Either<String, Unit>> deleteItem(ProductModel item) async {
    return await genericFirebaseServices.deleteItem(item);
  }

  @override
  Future<Either<String, List<ProductModel>>> fetchItems() async {
    return await genericFirebaseServices.fetchItems();
  }

  @override
  Future<Either<String, ProductModel>> updateItem(ProductModel item) async {
    return await genericFirebaseServices.updateItem(item);
  }
}
