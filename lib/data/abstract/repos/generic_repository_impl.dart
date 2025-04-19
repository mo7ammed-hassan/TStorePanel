import 'package:either_dart/either.dart';
import 'package:t_store_admin_panel/data/abstract/repos/generic_repository.dart';
import 'package:t_store_admin_panel/data/services/abstract/generic_firebase_services.dart';

class GenericRepositoryImpl<T> implements GenericRepository<T> {
  final GenericFirebaseServices<T> _firebaseServices;
  GenericRepositoryImpl(this._firebaseServices);

  @override
  Future<Either<String, String>> createItem(T item) async {
    return await _firebaseServices.createItem(item);
  }

  @override
  Future<Either<String, void>> deleteItem(T item) async {
    return await _firebaseServices.deleteItem(item);
  }

  @override
  Future<Either<String, List<T>>> fetchItems() async {
    return await _firebaseServices.fetchItems();
  }

  @override
  Future<Either<String, void>> updateItem(T item) async {
    return await _firebaseServices.updateItem(item);
  }
}
