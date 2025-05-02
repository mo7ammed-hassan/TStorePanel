import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:t_store_admin_panel/core/utils/utils/helpers/helper_functions.dart';
import 'package:t_store_admin_panel/data/models/abstract/has_id.dart';
import 'package:t_store_admin_panel/data/models/brands/brand_model.dart';
import 'package:t_store_admin_panel/data/models/product/product_attributes_model.dart';
import 'package:t_store_admin_panel/data/models/product/product_variation_model.dart';

class ProductModel implements HasId {
  @override
  final String id;
  final String title;
  final String? thumbnail;
  final List<String?>? images;
  final int stock;
  final num price;
  final double? salePrice;
  final String? sku;
  final String productType;
  final List<ProductVariationModel>? productVariations;
  final List<ProductAttributesModel>? productAttributes;
  final bool? isFeatured;
  final BrandModel? brand;
  final String? description;
  final String? categoryId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ProductModel({
    required this.id,
    required this.title,
    required this.thumbnail,
    this.images,
    required this.stock,
    required this.price,
    this.salePrice,
    this.sku,
    required this.productType,
    this.productVariations,
    this.productAttributes,
    this.isFeatured,
    this.brand,
    this.description,
    this.categoryId,
    this.createdAt,
    this.updatedAt,
  });

  String? get formattedCreatedAt =>
      HelperFunctions.getFormattedDate(createdAt ?? DateTime.now());
  String? get formattedUpdatedAt =>
      HelperFunctions.getFormattedDate(updatedAt ?? DateTime.now());

  ProductModel copyWith({
    String? id,
    String? title,
    String? thumbnail,
    List<String?>? images,
    int? stock,
    double? price,
    double? salePrice,
    String? sku,
    String? productType,
    List<ProductVariationModel>? productVariations,
    List<ProductAttributesModel>? productAttributes,
    bool? isFeatured,
    BrandModel? brand,
    String? description,
    String? categoryId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ProductModel(
      id: id ?? this.id,
      title: title ?? this.title,
      thumbnail: thumbnail ?? this.thumbnail,
      images: images ?? this.images,
      stock: stock ?? this.stock,
      price: price ?? this.price,
      salePrice: salePrice ?? this.salePrice,
      sku: sku ?? this.sku,
      productType: productType ?? this.productType,
      productVariations: productVariations ?? this.productVariations,
      productAttributes: productAttributes ?? this.productAttributes,
      isFeatured: isFeatured ?? this.isFeatured,
      brand: brand ?? this.brand,
      description: description ?? this.description,
      categoryId: categoryId ?? this.categoryId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  static ProductModel empty() => ProductModel(
    id: '',
    title: '',
    thumbnail: '',
    stock: 0,
    price: 0,
    productType: '',
  );

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'title': title,
    'thumbnail': thumbnail,
    'images': images,
    'stock': stock,
    'price': price,
    'salePrice': salePrice,
    'sku': sku,
    'productType': productType,
    'productAttributes': productAttributes?.map((e) => e.toJson()).toList(),
    'productVariations': productVariations?.map((e) => e.toJson()).toList(),
    'isFeatured': isFeatured,
    'brand': brand,
    'description': description,
    'categoryId': categoryId,
    'createdAt': createdAt != null ? Timestamp.fromDate(createdAt!) : null,
    'updatedAt': updatedAt != null ? Timestamp.fromDate(updatedAt!) : null,
  };

  factory ProductModel.fromJson(Map<String, dynamic> json, [String? id]) =>
      ProductModel(
        id: id ?? json['id'] as String,
        title: json['title'] as String,
        thumbnail: json['thumbnail'] as String,
        images:
            json['images'] != null ? List<String?>.from(json['images']) : null,
        stock: json['stock'] as int,
        price: (json['price'] as num).toDouble(),
        salePrice: (json['salePrice'] as num?)?.toDouble(),
        sku: json['sku'] as String?,
        productType: json['productType'] as String,
        productAttributes:
            (json['productAttributes'] as List<dynamic>?)
                ?.map((e) => ProductAttributesModel.fromJson(e))
                .toList() ??
            const [],
        productVariations:
            (json['productVariations'] as List<dynamic>?)
                ?.map((e) => ProductVariationModel.fromJson(e))
                .toList() ??
            const [],
        isFeatured: json['isFeatured'] as bool?,
        brand: BrandModel.fromMap(json['brand']) as BrandModel?,
        description: json['description'] as String?,
        categoryId: json['categoryId'] as String?,
        createdAt: parseDate(json['createdAt']),
        updatedAt: parseDate(json['updatedAt']),
      );

  factory ProductModel.fromSnapshot(DocumentSnapshot document) {
    final data = document.data() as Map<String, dynamic>;

    if (data.isNotEmpty) {
      return ProductModel.fromJson(data);
    } else {
      return ProductModel.empty();
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

  bool isSameModel(ProductModel model) {
    return model.id == id &&
        model.title == title &&
        model.thumbnail == thumbnail &&
        model.images == images &&
        model.stock == stock &&
        model.price == price &&
        model.salePrice == salePrice &&
        model.sku == sku &&
        model.productType == productType &&
        model.productVariations == productVariations &&
        model.productAttributes == productAttributes &&
        model.isFeatured == isFeatured &&
        model.brand == brand &&
        model.description == description &&
        model.categoryId == categoryId;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductModel &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  set id(String? id) {
    this.id = id;
  }
}
