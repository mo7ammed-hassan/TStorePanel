import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:t_store_admin_panel/core/utils/constants/enums.dart';
import 'package:t_store_admin_panel/data/models/image/image_model.dart';

abstract class MediaFirebaseServices {
  // Upload Images specifiy category to DB
  Future<ImageModel> uploadImages({
    required Uint8List fileBytes,
    required String path,
    required String imageName,
  });

  // Upload Image data in FireStore
  Future<String> uploadImageFileInDatabase(
    ImageModel imagem, {
    required String path,
  });

  // fetch Image data from FireStore
  Future<List<ImageModel>> fetchImagesFromDatabase(
    MediaCategory mediaCategory,
    int limit, {
    required String path,
  });

  // fetch more images
  Future<List<ImageModel>> fetchMoreImages(
    MediaCategory mediaCategory,
    int limit,
    DateTime lastFetchTime, {
    required String path,
  });

  // delete image from storage
  Future<void> deleteImageFromStorage(ImageModel image);
}

class MediaFirebaseServicesImpl implements MediaFirebaseServices {
  // final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // We use Secoundry app to store images so we need to access it here
  final FirebaseApp firebaseSecondaryApp = Firebase.app('StorageBucket');

  @override
  Future<ImageModel> uploadImages({
    required Uint8List fileBytes,
    required String path,
    required String imageName,
  }) async {
    try {
      debugPrint("🚀 Compressing image...");

      // Clean up the path
      String cleanString(String input) =>
          input.replaceAll(RegExp(r'[()\s]'), '').replaceAll('//', '/');

      final String filePath =
          'TStore/images${cleanString(path)}/${cleanString(imageName)}';

      debugPrint("📂 File Path: $filePath");

      // Initialize Firebase Storage
      FirebaseStorage storage = FirebaseStorage.instanceFor(
        app: firebaseSecondaryApp,
      );
      final Reference ref = storage.ref(filePath);

      // Upload the file
      final UploadTask uploadTask = ref.putData(fileBytes);
      await uploadTask.whenComplete(() => debugPrint("✅ Upload finished"));

      // Get download URL
      final String downloadUrl = await ref.getDownloadURL();

      // Wait a bit before fetching metadata (Fix for "file not found" error)
      await Future.delayed(const Duration(seconds: 1));

      // Fetch metadata
      final FullMetadata metadata = await ref.getMetadata();

      return ImageModel.fromFirebaseMetaData(
        metadata,
        cleanString(path),
        cleanString(imageName),
        downloadUrl,
      );
    } on FirebaseException catch (e) {
      throw Exception('Firebase Error: ${e.message ?? 'Unknown error'}');
    } on SocketException catch (e) {
      throw Exception('No internet connection: ${e.toString()}');
    } on PlatformException catch (e) {
      throw Exception('Platform Error: ${e.message ?? 'Unknown error'}');
    } catch (e, stackTrace) {
      Error.throwWithStackTrace(Exception('Unexpected Error: $e'), stackTrace);
    }
  }

  @override
  Future<String> uploadImageFileInDatabase(
    ImageModel image, {
    required String path,
  }) async {
    try {
      final data = await _firestore
          .collection('Images')
          .doc(path)
          .collection('Images')
          .add(image.toJson());

      return data.id;
    } on FirebaseException catch (e) {
      throw Exception('Firebase Error: ${e.message ?? 'Unknown error'}');
    } on SocketException catch (e) {
      throw Exception('No internet connection: ${e.toString()}');
    } on PlatformException catch (e) {
      throw Exception('Platform Error: ${e.message ?? 'Unknown error'}');
    } catch (e, stackTrace) {
      Error.throwWithStackTrace(Exception('Unexpected Error: $e'), stackTrace);
    }
  }

  @override
  Future<List<ImageModel>> fetchImagesFromDatabase(
    MediaCategory mediaCategory,
    int limit, {
    required String path,
  }) async {
    try {
      final querySnapshot =
          await _firestore
              .collection('Images')
              .doc(path)
              .collection('Images')
              // .where('mediaCategory', isEqualTo: mediaCategory.name.toString())
              .orderBy('createdAt', descending: true)
              .limit(limit)
              .get();

      return querySnapshot.docs.map((e) => ImageModel.fromJson(e)).toList();
    } on FirebaseException catch (e) {
      throw Exception('Firebase Error: ${e.message ?? 'Unknown error'}');
    } on SocketException catch (e) {
      throw Exception('No internet connection: ${e.toString()}');
    } on PlatformException catch (e) {
      throw Exception('Platform Error: ${e.message ?? 'Unknown error'}');
    } catch (e, stackTrace) {
      Error.throwWithStackTrace(Exception('Unexpected Error: $e'), stackTrace);
    }
  }

  @override
  Future<List<ImageModel>> fetchMoreImages(
    MediaCategory mediaCategory,
    int limit,
    DateTime lastFetchTime, {
    required String path,
  }) async {
    try {
      final querySnapshot =
          await _firestore
              .collection('Images')
              .doc(path)
              .collection('Images')
              .orderBy('createdAt', descending: true)
              .startAfter([lastFetchTime])
              .limit(limit)
              .get();

      return querySnapshot.docs.map((e) => ImageModel.fromJson(e)).toList();
    } on FirebaseException catch (e) {
      throw Exception('Firebase Error: ${e.message ?? 'Unknown error'}');
    } on SocketException catch (e) {
      throw Exception('No internet connection: ${e.toString()}');
    } on PlatformException catch (e) {
      throw Exception('Platform Error: ${e.message ?? 'Unknown error'}');
    } catch (e, stackTrace) {
      Error.throwWithStackTrace(Exception('Unexpected Error: $e'), stackTrace);
    }
  }

  @override
  Future<void> deleteImageFromStorage(ImageModel image) async {
    try {
      // access storage
      FirebaseStorage storage = FirebaseStorage.instanceFor(
        app: firebaseSecondaryApp,
      );

      // Delete image from storage
      await storage.ref(image.fullPath).delete();

      // Delete image from database
      await _firestore
          .collection('Images')
          .doc(image.folder)
          .collection('Images')
          .doc(image.id)
          .delete();
    } on FirebaseException catch (e) {
      throw Exception('Firebase Error: ${e.message ?? 'Unknown error'}');
    } on SocketException catch (e) {
      throw Exception('No internet connection: ${e.toString()}');
    } on PlatformException catch (e) {
      throw Exception('Platform Error: ${e.message ?? 'Unknown error'}');
    } catch (e, stackTrace) {
      Error.throwWithStackTrace(Exception('Unexpected Error: $e'), stackTrace);
    }
  }
}
