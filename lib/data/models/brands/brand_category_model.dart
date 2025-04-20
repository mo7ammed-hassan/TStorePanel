import 'package:cloud_firestore/cloud_firestore.dart';

class BrandCategoryModel {
  String? id;
  final String brandId;
  final String categoryId;

  BrandCategoryModel({
    this.id,
    required this.brandId,
    required this.categoryId,
  });

  BrandCategoryModel.fromJson(Map<String, dynamic> json)
    : id = json['id'] as String?,
      brandId = json['brandId'] as String,
      categoryId = json['categoryId'] as String;

  Map<String, dynamic> toJson() {
    return {'brandId': brandId, 'categoryId': categoryId};
  }

  // from snapshot to json
  factory BrandCategoryModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

    return BrandCategoryModel(
      id: snapshot.id,
      brandId: data['brandId'] as String,
      categoryId: data['categoryId'] as String,
    );
  }
}
