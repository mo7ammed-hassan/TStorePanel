import 'package:either_dart/either.dart';

abstract class GenericFirebaseServices<T> {
  /// fetch all items
  Future<Either<String, List<T>>> fetchItems();

  /// create new item
  Future<Either<String, String>> createItem(T item);

  /// update Item
  Future<Either<String, void>> updateItem(T item);

  /// delete Item
  Future<Either<String, void>> deleteItem(T item);
}
