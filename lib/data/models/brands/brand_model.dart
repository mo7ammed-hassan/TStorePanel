import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:t_store_admin_panel/core/utils/utils/helpers/helper_functions.dart';
import 'package:t_store_admin_panel/data/models/abstract/has_id.dart';
import 'package:t_store_admin_panel/data/models/category/category_model.dart';

part 'brand_model.g.dart';

@HiveType(typeId: 3)
class BrandModel extends HasId {
  @HiveField(0)
  @override
  String? id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String? image;
  @HiveField(3)
  bool? isFeatured;
  @HiveField(4)
  int? productCount;
  @HiveField(5)
  final DateTime? createdAt;
  @HiveField(6)
  final DateTime? updatedAt;

  // not mapped
  @HiveField(7)
  final List<CategoryModel>? brandCategories;

  BrandModel({
    required this.id,
    required this.name,
    required this.image,
    this.isFeatured,
    this.productCount,
    this.brandCategories,
    this.createdAt,
    this.updatedAt,
  });

  // formate date 
  String? get formattedCreatedAt => HelperFunctions.getFormattedDate(createdAt ?? DateTime.now());
  String? get formattedUpdatedAt => HelperFunctions.getFormattedDate(updatedAt ?? DateTime.now());
      

  // empty
  static BrandModel empty() {
    return BrandModel(
      id: '',
      name: '',
      image: '',
      isFeatured: false,
      productCount: 0,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'image': image,
      'isFeatured': isFeatured,
      'productCount': productCount,
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  factory BrandModel.fromMap(Map<String, dynamic> map, [String? id]) {
    return BrandModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      image: map['image'] ?? '',
      isFeatured: map['isFeatured'] ?? false,
      productCount: map['productCount'] ?? 0,
    );
  }

  // from snapshot to json
  factory BrandModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    if (snapshot.data() != null) {
      final data = snapshot.data()!;

      return BrandModel(
        id: snapshot.id,
        name: data['name'] ?? '',
        image: data['image'] ?? '',
        isFeatured: data['isFeatured'] ?? false,
        productCount: data['productCount'] ?? 0,
        createdAt:
            data['createdAt'] != null
                ? (data['createdAt'] as Timestamp).toDate()
                : null,
        updatedAt:
            data['updatedAt'] != null
                ? (data['updatedAt'] as Timestamp).toDate()
                : null,
      );
    } else {
      return BrandModel.empty();
    }
  }
}
