import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';

part 'brand_category_model.g.dart';

@HiveType(typeId: 4)
class BrandCategoryModel {
  @HiveField(0)
  String? id;
  @HiveField(1)
  final String brandId;
  @HiveField(2)
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
