class ProductVariationModel {
  final String? id;
  final String? sku;
  final String image;
  final String? description;
  final double price;
  final double? salePrice;
  final int stock;
  final Map<String, String> attributeValues;

  ProductVariationModel(
    this.id,
    this.sku,
    this.image,
    this.description,
    this.price,
    this.salePrice,
    this.stock,
    this.attributeValues,
  );

  ProductVariationModel copyWith({
    String? id,
    String? sku,
    String? image,
    String? description,
    double? price,
    double? salePrice,
    int? stock,
    Map<String, String>? attributeValues,
  }) {
    return ProductVariationModel(
      id ?? this.id,
      sku ?? this.sku,
      image ?? this.image,
      description ?? this.description,
      price ?? this.price,
      salePrice ?? this.salePrice,
      stock ?? this.stock,
      attributeValues ?? this.attributeValues,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'sku': sku,
    'image': image,
    'description': description,
    'price': price,
    'salePrice': salePrice,
    'stock': stock,
    'attributeValues': attributeValues,
  };

  factory ProductVariationModel.fromJson(Map<String, dynamic> json) =>
      ProductVariationModel(
        json['id'] as String?,
        json['sku'] as String?,
        json['image'] as String,
        json['description'] as String?,
        (json['price'] as num).toDouble(),
        (json['salePrice'] as num?)?.toDouble(),
        json['stock'] as int,
        Map<String, String>.from(json['attributeValues']),
      );
}
