import 'dart:typed_data';
import 'package:either_dart/either.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/enums.dart';
import 'package:t_store_admin_panel/data/models/image/image_model.dart';
import 'package:t_store_admin_panel/data/services/media/media_firebase_services.dart';
import 'package:t_store_admin_panel/domain/repositories/media/media_repository.dart';

class MediaRepositoryImpl extends MediaRepository {
  final MediaFirebaseServices _mediaServices;

  MediaRepositoryImpl(this._mediaServices);
  @override
  Future<Either<String, ImageModel>> uploadImages({
    required Uint8List fileBytes,
    required String path,
    required String imageName,
  }) async {
    try {
      // upload images
      var imageModel = await _mediaServices.uploadImages(
        fileBytes: fileBytes,
        path: path,
        imageName: imageName,
      );

      return Right(imageModel);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<String> uploadImageFileInDatabase(
    ImageModel image, {
    required String path,
  }) async {
    try {
      return await _mediaServices.uploadImageFileInDatabase(image, path: path);
    } catch (e) {
      return e.toString();
    }
  }

  @override
  Future<Either<String, List<ImageModel>>> fetchImagesFromDatabase(
    MediaCategory selectedPath,
    limit, {
    required String path,
  }) async {
    try {
      var images = await _mediaServices.fetchImagesFromDatabase(
        selectedPath,
        limit,
        path: path,
      );

      return Right(images);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<ImageModel>>> fetchMoreImages(
    MediaCategory mediaCategory,
    int limit,
    DateTime lastFetchTime, {
    required String path,
  }) async {
    try {
      var images = await _mediaServices.fetchMoreImages(
        mediaCategory,
        limit,
        lastFetchTime,
        path: path,
      );

      return Right(images);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, void>> deleteImageFromStorage(ImageModel image) async {
    try {
      await _mediaServices.deleteImageFromStorage(image);
      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
