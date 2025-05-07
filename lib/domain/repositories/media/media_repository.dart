import 'dart:typed_data';
import 'package:dartz/dartz.dart';
import 'package:t_store_admin_panel/core/utils/constants/enums.dart';
import 'package:t_store_admin_panel/data/models/image/image_model.dart';

abstract class MediaRepository {
  Future<Either<String, ImageModel>> uploadImages({
    required Uint8List fileBytes,
    required String path,
    required String imageName,
  });

  Future<String> uploadImageFileInDatabase(
    ImageModel image, {
    required String path,
  });

  Future<Either<String, List<ImageModel>>> fetchImagesFromDatabase(
    MediaCategory selectedPath,
    limit, {
    required String path,
  });

  Future<Either<String, List<ImageModel>>> fetchMoreImages(
    MediaCategory mediaCategory,
    int limit,
    DateTime lastFetchTime, {
    required String path,
  });

  Future<Either<String, Unit>> deleteImageFromStorage(ImageModel image);
}
