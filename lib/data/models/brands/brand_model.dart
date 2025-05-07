import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:t_store_admin_panel/core/utils/helpers/helper_functions.dart';
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
  DateTime? updatedAt;

  @HiveField(7)
  List<CategoryModel>? brandCategories;

  BrandModel({
    this.id,
    required this.name,
    required this.image,
    this.isFeatured,
    this.productCount,
    this.createdAt,
    this.updatedAt,
    this.brandCategories,
  });

  String? get formattedCreatedAt =>
      HelperFunctions.getFormattedDate(createdAt ?? DateTime.now());

  String? get formattedUpdatedAt =>
      HelperFunctions.getFormattedDate(updatedAt ?? DateTime.now());

  static BrandModel empty() {
    return BrandModel(
      id: '',
      name: '',
      image: '',
      isFeatured: false,
      productCount: 0,
    );
  }

  BrandModel copyWith({
    String? id,
    String? name,
    String? image,
    bool? isFeatured,
    int? productCount,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<CategoryModel>? brandCategories,
  }) {
    return BrandModel(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      isFeatured: isFeatured ?? this.isFeatured,
      productCount: productCount ?? this.productCount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      brandCategories: brandCategories ?? this.brandCategories,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'image': image,
      'isFeatured': isFeatured,
      'productCount': productCount,
      'createdAt': createdAt != null ? Timestamp.fromDate(createdAt!) : null,
      'updatedAt': updatedAt != null ? Timestamp.fromDate(updatedAt!) : null,
    };
  }

  factory BrandModel.fromMap(Map<String, dynamic> map, [String? id]) {
    return BrandModel(
      id: id ?? safeGet<String>(map, 'id') ?? '',
      name: safeGet<String>(map, 'name') ?? '',
      image: safeGet<String>(map, 'image') ?? '',
      isFeatured: safeGet<bool>(map, 'isFeatured') ?? false,
      productCount: safeGet<int>(map, 'productCount') ?? 0,
      createdAt: parseDate(map['createdAt']),
      updatedAt: parseDate(map['updatedAt']),
    );
  }

  factory BrandModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    if (snapshot.data() != null) {
      final data = snapshot.data()!;
      return BrandModel.fromMap(data, snapshot.id);
    } else {
      return BrandModel.empty();
    }
  }

  static DateTime? parseDate(dynamic value) {
    if (value == null) {
      return null;
    } else if (value is Timestamp) {
      return value.toDate();
    } else if (value is String) {
      return DateTime.tryParse(value);
    } else {
      return null;
    }
  }

  // Helper to check if there was an update in model or not
  static bool isSameModel(BrandModel model1, BrandModel model2) {
    return model1.name == model2.name &&
        model1.image == model2.image &&
        model1.isFeatured == model2.isFeatured &&
        model1.productCount == model2.productCount &&
        listEquals(
          List.from(model1.brandCategories ?? []),
          List.from(model2.brandCategories ?? []),
        );
  }
}

T? safeGet<T>(Map<String, dynamic> map, String key) {
  final value = map[key];
  if (value is T) return value;
  return null;
}
