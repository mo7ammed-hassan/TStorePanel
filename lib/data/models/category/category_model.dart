import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  String id;
  String name;
  String? image;
  String parentId;
  bool? isFeatured;

  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
    this.parentId = '',
     this.isFeatured,
  });

  // Empty Helper function
  static CategoryModel empty() =>
      CategoryModel(id: '', name: '', image: '', isFeatured: false);

  // Convert Model to Json structure to storage in the database
  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'ImageUrl': image,
      'ParentId': parentId,
      'IsFeatured': isFeatured,
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
      );
    } else {
      return CategoryModel.empty();
    }
  }
}
