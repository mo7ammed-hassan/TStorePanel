class BrandModel {
  String id;
  String name;
  String image;
  bool? isFeatured;
  int? productCount;

  BrandModel({
    required this.id,
    required this.name,
    required this.image,
    this.isFeatured,
    this.productCount,
  });

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
    };
  }

  factory BrandModel.fromJson(Map<String, dynamic> map) {
    return BrandModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      image: map['image'] ?? '',
      isFeatured: map['isFeatured'] ?? false,
      productCount: map['productCount'] ?? 0,
    );
  }
}

// extension BrandXModel on BrandModel {
//   BrandEntity toEntity() {
//     return BrandEntity(
//       id: id,
//       name: name,
//       image: image,
//       isFeatured: isFeatured ?? false,
//       productCount: productCount ?? 0,
//     );
//   }
// }
