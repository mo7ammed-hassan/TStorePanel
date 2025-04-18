import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  String id;
  String name;
  String? image;
  String parentId;
  bool? isFeatured;
  DateTime? createdAt;
  DateTime? updatedAt;

  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
    this.parentId = '',
    this.isFeatured = false,
    this.createdAt,
    this.updatedAt,
  });

  // Formatted Dates
  String? get formattedCreatedAt =>
      createdAt != null
          ? '${createdAt!.day}/${createdAt!.month}/${createdAt!.year}'
          : '';
  String? get formattedUpdatedAt =>
      updatedAt != null
          ? '${updatedAt!.day}/${updatedAt!.month}/${updatedAt!.year}'
          : '';

  // Empty Helper function
  static CategoryModel empty() => CategoryModel(id: '', name: '', image: '');

  // Convert Model to Json structure to storage in the database
  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'ImageUrl': image,
      'ParentId': parentId,
      'IsFeatured': isFeatured,
      'CreatedAt': createdAt,
      'UpdatedAt': updatedAt,
    };
  }

  // Convert Json structure from database to Model
  static CategoryModel fromJson(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    if (document.data() != null) {
      final data = document.data()!;

      return CategoryModel(
        id: document.id,
        name: data['Name'] ?? '',
        image: data['ImageUrl'] ?? '',
        parentId: data['ParentId'] ?? '',
        isFeatured: data['IsFeatured'] ?? false,
        createdAt:
            data['CreatedAt'] != null
                ? (data['CreatedAt'] as Timestamp).toDate()
                : null,
        updatedAt:
            data['UpdatedAt'] != null
                ? (data['UpdatedAt'] as Timestamp).toDate()
                : null,
      );
    } else {
      return CategoryModel.empty();
    }
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CategoryModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
