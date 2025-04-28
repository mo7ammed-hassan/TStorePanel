// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brand_category_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BrandCategoryModelAdapter extends TypeAdapter<BrandCategoryModel> {
  @override
  final int typeId = 4;

  @override
  BrandCategoryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BrandCategoryModel(
      id: fields[0] as String?,
      brandId: fields[1] as String,
      categoryId: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, BrandCategoryModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.brandId)
      ..writeByte(2)
      ..write(obj.categoryId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BrandCategoryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
