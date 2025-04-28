// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:t_store_admin_panel/data/models/abstract/has_id.dart';

part 'banner_model.g.dart';

@HiveType(typeId: 2)
class BannerModel implements HasId {
  @override
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? image;
  @HiveField(2)
  final String targetScreen;
  @HiveField(3)
  final bool active;

  BannerModel({
    required this.image,
    required this.targetScreen,
    required this.active,
    this.id,
  });

  static BannerModel empty() =>
      BannerModel(image: '', targetScreen: '', active: false);

  Map<String, dynamic> toJson() => {
    'Image': image,
    'TargetScreen': targetScreen,
    'Active': active,
    'id': id,
  };

  factory BannerModel.fromJson(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return BannerModel(
      id: snapshot.id,
      image: data['Image'] ?? '',
      targetScreen: data['TargetScreen'] ?? '',
      active: data['Active'] ?? false,
    );
  }

  factory BannerModel.fromMap(Map<String, dynamic> json, [String? id]) {
    return BannerModel(
      id: id,
      image: json['Image'] ?? '',
      targetScreen: json['TargetScreen'] ?? '',
      active: json['Active'] ?? false,
    );
  }

  // Helper to check if there was an update in model or not
  static bool isSameModel(BannerModel model1, BannerModel model2) {
    return model1.id == model2.id &&
        model1.image == model2.image &&
        model1.targetScreen == model2.targetScreen &&
        model1.active == model2.active;
  }

  // copyWith method to create a new instance with updated values
  BannerModel copyWith({
    String? id,
    String? image,
    String? targetScreen,
    bool? active,
  }) {
    return BannerModel(
      id: id ?? this.id,
      image: image ?? this.image,
      targetScreen: targetScreen ?? this.targetScreen,
      active: active ?? this.active,
    );
  }
}
