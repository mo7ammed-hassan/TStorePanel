import 'package:dartz/dartz.dart';

abstract class GenericRepository<T> {
  Future<Either<String, List<T>>> fetchItems();

  Future<Either<String, String>> createItem(T item);

  Future<Either<String, T>> updateItem(T item);

  Future<Either<String, Unit>> deleteItem(T item);
}
