import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:t_store_admin_panel/core/errors/firebase_error.dart';
import 'package:t_store_admin_panel/data/models/abstract/has_id.dart';
import 'package:t_store_admin_panel/data/services/abstract/generic_firebase_services.dart';

class GenericFirebaseServicesImpl<T extends HasId> extends GenericFirebaseServices<T> {
  final String collectionPath;
  final FirebaseStorage storage = FirebaseStorage.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseErrorHandler _errorHandler = FirebaseErrorHandler();

  // Generic Factory Method
  final T Function(Map<String, dynamic> json, [String? id]) fromJson;
  final Map<String, dynamic> Function(T item) toJson;

  GenericFirebaseServicesImpl(this.collectionPath, this.fromJson, this.toJson);
 
  /// Creates a new item in the Firestore collection.
  @override
  Future<Either<String, String>> createItem(T item) async {
    return _errorHandler.handleErrorEitherAsync(() async {
      final data = await firestore.collection(collectionPath).add(toJson(item));
      return data.id;
    });
  }
  
  /// Deletes an item from the Firestore collection.
  @override
  Future<Either<String, void>> deleteItem(T item) async {
    if (item.id == null) return const Left("Item has no ID");

    return _errorHandler.handleErrorEitherAsync(() async {
      await firestore.collection(collectionPath).doc(item.id).delete();
    });
  }
  
  /// Fetches all items from the Firestore collection.
  @override
  Future<Either<String, List<T>>> fetchItems() async {
    return _errorHandler.handleErrorEitherAsync(() async {
      final queryData = await firestore.collection(collectionPath).get();
      return queryData.docs.map((e) => fromJson(e.data(), e.id)).toList();
    });
  }
  
  /// Fetches a single item by its ID from the Firestore collection.
  @override
  Future<Either<String, void>> updateItem(T item) async {
    if (item.id == null) return const Left("Item has no ID");

    return _errorHandler.handleErrorEitherAsync(() async {
      await firestore
          .collection(collectionPath)
          .doc(item.id)
          .update(toJson(item));
    });
  }
}
