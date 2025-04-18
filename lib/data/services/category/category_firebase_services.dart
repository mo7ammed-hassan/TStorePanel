import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:t_store_admin_panel/data/models/category/category_model.dart';

abstract class CategoryFirebaseServices {
  // fetrch all categories
  Future<Either<String, List<CategoryModel>>> fetchCategories();

  // create new category
  Future<Either<String, String>> createCategory(CategoryModel category);

  // update category
  Future<Either<String, void>> updateCategory(CategoryModel category);

  // delete category
  Future<Either<String, void>> deleteCategory(CategoryModel category);
}

class CategoryFirebaseServicesImpl implements CategoryFirebaseServices {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final String collectionName = 'Categories';
  final FirebaseStorage storage = FirebaseStorage.instance;
  @override
  Future<Either<String, String>> createCategory(CategoryModel category) async {
    try {
      final data = await firestore
          .collection(collectionName)
          .add(category.toJson());

      return Right(data.id);
    } on FirebaseException catch (e) {
      return Left(e.message ?? 'Unknown error');
    } on SocketException catch (e) {
      return Left(e.message);
    } on PlatformException catch (e) {
      return Left(e.message ?? 'Unknown error');
    } catch (e, stackTrace) {
      Error.throwWithStackTrace(Exception('Unexpected Error: $e'), stackTrace);
    }
  }

  @override
  Future<Either<String, void>> deleteCategory(CategoryModel category) async {
    final docRef = firestore.collection(collectionName).doc(category.id);
    try {
      await docRef.delete();
      return const Right(null);
    } on FirebaseException catch (e) {
      return Left(e.message ?? 'Unknown error');
    } on SocketException catch (e) {
      return Left(e.message);
    } on PlatformException catch (e) {
      return Left(e.message ?? 'Unknown error');
    } catch (e, stackTrace) {
      Error.throwWithStackTrace(Exception('Unexpected Error: $e'), stackTrace);
    }
  }

  @override
  Future<Either<String, List<CategoryModel>>> fetchCategories() async {
    try {
      final categories = await firestore.collection(collectionName).get();
      return Right(
        categories.docs.map((e) => CategoryModel.fromJson(e)).toList(),
      );
    } on FirebaseException catch (e) {
      return Left(e.message ?? 'Unknown error');
    } on SocketException catch (e) {
      return Left(e.message);
    } on PlatformException catch (e) {
      return Left(e.message ?? 'Unknown error');
    } catch (e, stackTrace) {
      Error.throwWithStackTrace(Exception('Unexpected Error: $e'), stackTrace);
    }
  }

  @override
  Future<Either<String, void>> updateCategory(CategoryModel category) async {
    try {
      await firestore
          .collection(collectionName)
          .doc(category.id)
          .update(category.toJson());

      return const Right(null);
    } on FirebaseException catch (e) {
      return Left(e.message ?? 'Unknown error');
    } on SocketException catch (e) {
      return Left(e.message);
    } on PlatformException catch (e) {
      return Left(e.message ?? 'Unknown error');
    } catch (e, stackTrace) {
      Error.throwWithStackTrace(Exception('Unexpected Error: $e'), stackTrace);
    }
  }
}
