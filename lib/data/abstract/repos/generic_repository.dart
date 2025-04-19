import 'package:either_dart/either.dart';

abstract class GenericRepository<T> {
  // Fetch all items
  Future<Either<String, List<T>>> fetchItems();

  // create new Item
  Future<Either<String, String>> createItem(T item);

  // update Item
  Future<Either<String, void>> updateItem(T item);

  // delete Item
  Future<Either<String, void>> deleteItem(T item);
}

