// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:either_dart/either.dart';
// import 'package:t_store_admin_panel/core/errors/firebase_error.dart';
// import 'package:t_store_admin_panel/core/utils/utils/constants/collection_constants.dart';
// import 'package:t_store_admin_panel/data/models/brands/brand_category_model.dart';
// import 'package:t_store_admin_panel/data/models/brands/brand_model.dart';
// import 'package:t_store_admin_panel/data/services/abstract/generic_firebase_services.dart';

// class BrandsFirebaseServices implements GenericFirebaseServices<BrandModel> {
//   BrandsFirebaseServices(this._firebaseServices);

//   final GenericFirebaseServices<BrandModel> _firebaseServices;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final FirebaseErrorHandler _errorHandler = FirebaseErrorHandler();

//   final collectionPath = CollectionConstants.brandCategories;

//   @override
//   Future<Either<String, String>> createItem(BrandModel item) async {
//     return await _firebaseServices.createItem(item);
//   }

//   @override
//   Future<Either<String, void>> deleteItem(BrandModel item) async {
//     return await _firebaseServices.deleteItem(item);
//   }

//   //
//   Future<Either<String, List<BrandCategoryModel>>> fetcCategoriesBrand() async {
//     return await _errorHandler.handleErrorEitherAsync(() async {
//       final queryData = await _firestore.collection(collectionPath).get();

//       final List<BrandCategoryModel> brandCategories =
//           queryData.docs
//               .map((e) => BrandCategoryModel.fromSnapshot(e))
//               .toList();

//       return brandCategories;
//     });
//   }

//   Future<Either<String, String>> createBrandCategory(
//     BrandCategoryModel brandCategory,
//   ) async {
//     return await _errorHandler.handleErrorEitherAsync(() async {
//       final queryData = await _firestore
//           .collection(collectionPath)
//           .add(brandCategory.toJson());

//       return queryData.id;
//     });
//   }

//   @override
//   Future<Either<String, List<BrandModel>>> fetchItems() async {
//     return await _errorHandler.handleErrorEitherAsync(() async {
//       final queryData =
//           await _firestore.collection(CollectionConstants.brands).get();

//       final List<BrandModel> brands =
//           queryData.docs.map((e) => BrandModel.fromSnapshot(e)).toList();

//       return brands;
//     });
//   }

//   @override
//   Future<Either<String, void>> updateItem(BrandModel item) async {
//     return await _firebaseServices.updateItem(item);
//   }

//   Future<Either<String, void>> updateCategoryBrand(
//     BrandCategoryModel brandCategory,
//   ) async {
//     return await _errorHandler.handleErrorEitherAsync(() async {
//       await _firestore.collection(collectionPath).add(brandCategory.toJson());
//     });
//   }

//   // delete brandCategory
//   Future<Either<String, void>> deleteBrandCategory(
//     BrandCategoryModel brandCategory,
//   ) async {
//     return await _errorHandler.handleErrorEitherAsync(() async {
//       await _firestore
//           .collection(collectionPath)
//           .doc(brandCategory.id)
//           .delete();
//     });
//   }
// }
