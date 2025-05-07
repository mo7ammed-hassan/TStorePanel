import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:t_store_admin_panel/core/utils/formatters/formatter.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ImageModel {
  String id;
  final String url;
  final String folder;
  final int? sizeBytes;
  String mediaCategory;
  final String fileName;
  final String? fullPath;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? contentType;

  // Not Mapped
 // final DropzoneFileInterface? file;
  final Uint8List? localImageToDisplay;
  bool isSelected = false;

  ImageModel({
    this.id = '',
    required this.url,
    required this.folder,
    this.sizeBytes,
    required this.fileName,
    this.fullPath,
    this.mediaCategory = '',
    this.createdAt,
    this.updatedAt,
    this.contentType,
    //this.file,
    this.localImageToDisplay,
  });

  /// Static function to create an empty user Model
  static ImageModel empty() => ImageModel(url: '', fileName: '', folder: '');

  String get createAtFormatted => TFormatter.formatDate(createdAt);
  String get updateAtFormatted => TFormatter.formatDate(updatedAt);

  /// Convert to Json to Store in DB
  Map<String, dynamic> toJson() => <String, dynamic>{
    'url': url,
    'folder': folder,
    'sizeBytes': sizeBytes,
    'fileName': fileName,
    'fullPath': fullPath,
    'createdAt': createdAt,
    'contentType': contentType,
    'mediaCategory': mediaCategory,
  };

  /// ---Convert Json to model---
  /// Convert Firestore json and map on model
  factory ImageModel.fromJson(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) =>
      document.data() != null
          ? ImageModel.fromMap(document.data()!, document.id)
          : ImageModel.empty();

  /// Map json to model
  factory ImageModel.fromMap(Map<String, dynamic> data, String id) =>
      ImageModel(
        id: id,
        url: data['url'] ?? '',
        folder: data['folder'] ?? '',
        sizeBytes: data['sizeBytes'] ?? 0,
        fileName: data['fileName'] ?? '',
        fullPath: data['fullPath'] ?? '',
        createdAt:
            data.containsKey('createdAt') ? data['createdAt']?.toDate() : null,
        updatedAt:
            data.containsKey('updatedAt') ? data['updatedAt']?.toDate() : null,
        contentType: data['contentType'] ?? '',
        mediaCategory: data['mediaCategory'],
      );

  /// Map Firestore json to model
  factory ImageModel.fromFirebaseMetaData(
    FullMetadata metaData,
    String folder,
    String fileName,
    String downloadUrl,
  ) => ImageModel(
    url: downloadUrl,
    folder: folder,
    fileName: fileName,
    sizeBytes: metaData.size,
    createdAt: metaData.timeCreated,
    updatedAt: metaData.timeCreated,
    contentType: metaData.contentType,
    fullPath: metaData.fullPath,
  );
}
