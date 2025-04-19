import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:t_store_admin_panel/data/models/abstract/has_id.dart';
import 'package:t_store_admin_panel/data/services/abstract/generic_firebase_services.dart';

class GenericFirebaseServicesImpl<T extends HasId>
    extends GenericFirebaseServices<T> {
  final String collectionName;

  final FirebaseStorage storage = FirebaseStorage.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Generic Factory Method
  final T Function(Map<String, dynamic> json, [String? id]) fromJson;
  final Map<String, dynamic> Function(T item) toJson;

  GenericFirebaseServicesImpl(this.collectionName, this.fromJson, this.toJson);
  @override
  Future<Either<String, String>> createItem(T item) async {
    try {
      final data = await firestore.collection(collectionName).add(toJson(item));

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
  Future<Either<String, void>> deleteItem(T item) async {
    if (item.id == null) return const Left("Item has no ID");

    final docRef = firestore.collection(collectionName).doc(item.id);
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
  Future<Either<String, List<T>>> fetchItems() async {
    try {
      final queryData = await firestore.collection(collectionName).get();

      final List<T> items =
          queryData.docs.map((e) => fromJson(e.data(), e.id)).toList();

      return Right(items);
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
  Future<Either<String, void>> updateItem(T item) async {
    try {
      if (item.id == null) return const Left("Item has no ID");
      await firestore
          .collection(collectionName)
          .doc(item.id)
          .update(toJson(item));

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
