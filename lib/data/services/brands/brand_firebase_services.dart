import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:t_store_admin_panel/core/errors/firebase_error.dart';
import 'package:t_store_admin_panel/core/utils/constants/firebase_collections.dart';
import 'package:t_store_admin_panel/data/models/brands/brand_category_model.dart';
import 'package:t_store_admin_panel/data/models/brands/brand_model.dart';
import 'package:t_store_admin_panel/data/models/category/category_model.dart';

abstract class BrandFirebaseServices {
  Future<Either<String, List<BrandModel>>> fetchBrands();

  Future<Either<String, String>> createBrand(BrandModel brand);

  Future<Either<String, BrandModel>> updateBrand(BrandModel brand);

  Future<Either<String, Unit>> deleteBrand(BrandModel brand);
}

class BrandFirebaseServicesImpl implements BrandFirebaseServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseErrorHandler _errorHandler = FirebaseErrorHandler();
  final brandcollection = FirebaseCollections.brands;
  final brandCategoryCollection = FirebaseCollections.brandCategories;

  @override
  Future<Either<String, String>> createBrand(BrandModel brand) async {
    return _errorHandler.handleErrorEitherAsync(() async {
      // Start a write batch
      WriteBatch batch = _firestore.batch();

      // Create a new brand document reference
      final brandDocRef = _firestore.collection(brandcollection).doc();
      final brandId = brandDocRef.id;

      // Prepare the brand model with the generated ID
      final brandWithId = brand.copyWith(id: brandId);

      // Set brand data
      batch.set(brandDocRef, brandWithId.toJson());

      // Create brand-category relations
      if (brand.brandCategories!.isNotEmpty) {
        for (final category in brand.brandCategories!) {
          final brandCategoryDocRef =
              _firestore.collection(brandCategoryCollection).doc();

          final brandCategoryData = BrandCategoryModel(
            brandId: brandId,
            categoryId: category.id!,
          );

          batch.set(brandCategoryDocRef, brandCategoryData.toJson());
        }
      }

      // Commit the batch
      await batch.commit();
      return brandId;
    });
  }

  @override
  Future<Either<String, List<BrandModel>>> fetchBrands() async {
    return await _errorHandler.handleErrorEitherAsync(() async {
      // 1. Fetch brands from the brands collection
      final brandSnapshot = await _firestore.collection(brandcollection).get();

      // 2. Prepare a list to store brands with their categories
      final brands = <BrandModel>[];

      for (var brandDoc in brandSnapshot.docs) {
        final brandId = brandDoc.id;
        final brandData = brandDoc.data();

        // 3. Fetch associated categories for the current brand
        final brandCategoriesSnapshot =
            await _firestore
                .collection(brandCategoryCollection)
                .where('brandId', isEqualTo: brandId)
                .get();

        // Get categoryIds from brandCategories
        final categoryIds =
            brandCategoriesSnapshot.docs
                .map((categoryDoc) => categoryDoc['categoryId'] as String)
                .toList();

        // 4. Fetch CategoryModel data for each categoryId
        final categoryModels = <CategoryModel>[];

        for (var categoryId in categoryIds) {
          final categoryDoc =
              await _firestore
                  .collection(FirebaseCollections.categories)
                  .doc(categoryId)
                  .get();

          if (categoryDoc.exists) {
            final categoryModel = CategoryModel.fromJson(categoryDoc);
            categoryModels.add(categoryModel);
          }
        }

        // 5. Create a BrandModel object with associated CategoryModels
        final brand = BrandModel.fromMap(
          brandData,
        ).copyWith(id: brandId, brandCategories: categoryModels);

        brands.add(brand);
      }

      return brands;
    });
  }

  @override
  Future<Either<String, BrandModel>> updateBrand(BrandModel brand) async {
    return _errorHandler.handleErrorEitherAsync(() async {
      WriteBatch batch = _firestore.batch();

      final brandDocRef = _firestore.collection(brandcollection).doc(brand.id);

      // Update the brand document
      batch.update(brandDocRef, brand.toJson());

      // Fetch existing brandCategories
      final brandCategoriesSnapshot =
          await _firestore
              .collection(brandCategoryCollection)
              .where('brandId', isEqualTo: brand.id)
              .get();

      final existingCategoryIds =
          brandCategoriesSnapshot.docs
              .map((doc) => doc['categoryId'] as String)
              .toList();

      final newCategoryIds =
          brand.brandCategories?.map((category) => category.id).toList() ?? [];

      final categoriesToDelete =
          existingCategoryIds
              .where((existingId) => !newCategoryIds.contains(existingId))
              .toList();

      final categoriesToAdd =
          newCategoryIds
              .where((newId) => !existingCategoryIds.contains(newId))
              .toList();

      // Delete categories that are no longer associated with the brand
      for (var categoryId in categoriesToDelete) {
        final brandCategoryDoc = brandCategoriesSnapshot.docs.firstWhere(
          (doc) => doc['categoryId'] == categoryId,
        );
        batch.delete(brandCategoryDoc.reference);
      }

      // Add new brand categories
      for (var categoryId in categoriesToAdd) {
        final brandCategory = BrandCategoryModel(
          brandId: brand.id!,
          categoryId: categoryId!,
        );
        final brandCategoryDocRef =
            _firestore.collection(brandCategoryCollection).doc();
        batch.set(brandCategoryDocRef, brandCategory.toJson());
      }

      // Commit the batch
      await batch.commit();

      return brand;
    });
  }

  @override
  Future<Either<String, Unit>> deleteBrand(BrandModel brand) async {
    return _errorHandler.handleErrorEitherAsync(() async {
      WriteBatch batch = _firestore.batch();

      final brandDocRef = _firestore.collection(brandcollection).doc(brand.id);

      // Delete the brand document
      batch.delete(brandDocRef);

      // Fetch all related brandCategories
      final brandCategoriesSnapshot =
          await _firestore
              .collection(brandCategoryCollection)
              .where('brandId', isEqualTo: brand.id)
              .get();

      // Delete all related brandCategories
      for (var doc in brandCategoriesSnapshot.docs) {
        batch.delete(doc.reference);
      }

      // Commit the batch
      await batch.commit();

      return unit;
    });
  }
}
