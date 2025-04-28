import 'package:either_dart/either.dart';
import 'package:t_store_admin_panel/core/utils/storage/cache_storage_mangement.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/collection_constants.dart';
import 'package:t_store_admin_panel/data/abstract/cubit/base_data_table_cubit.dart';
import 'package:t_store_admin_panel/data/abstract/cubit/base_data_table_states.dart';
import 'package:t_store_admin_panel/data/models/brands/brand_model.dart';
import 'package:t_store_admin_panel/data/repositories/brands/brand_repo.dart';
import 'package:t_store_admin_panel/features/categories/cubits/category/category_cubit.dart';

class BrandCubit extends BaseDataTableCubit<BrandModel> {
  BrandCubit(this.brandRepository, this.categoryCubit)
    : super(
        DataTableInitial(),
        CacheStorageManagementImpl<BrandModel>(
          CollectionConstants.brands,
          3,
          adapter: BrandModelAdapter(),
        ),
      );

  final BrandRepo brandRepository;
  final CategoryCubit categoryCubit;

  @override
  bool containSearchQuery(BrandModel item, String query) {
    return item.name.toLowerCase().contains(query.toLowerCase());
  }

  @override
  Future<Either<String, void>> deleteItem(BrandModel item) async {
    if (item.id == null) {
      return const Left("Item ID is null");
    }

    return await brandRepository.deleteItem(item);
  }

  @override
  Future<Either<String, List<BrandModel>>> fetchItems() async {
    // // Fetch All Brands
    // final result = await brandRepository.fetchItems();
    // final fetchedBrands = result.fold(
    //   (failure) => <BrandModel>[],
    //   (brands) => brands,
    // );

    // // Fetch All BrandCategories
    // final fetchedBrandCategoriesResult =
    //     await brandRepository.fetcCategoriesBrand();
    // final fetchedBrandCategories = fetchedBrandCategoriesResult.fold(
    //   (failure) => <BrandCategoryModel>[],
    //   (list) => list,
    // );

    // // Fetch All Categories
    // final categoriesResult = await categoryCubit.fetchItems();
    // final fetchedCategories = categoriesResult.fold(
    //   (failure) => <CategoryModel>[],
    //   (list) => list,
    // );

    // // Set brand categories for each brand
    // for (var brand in fetchedBrands) {
    //   final categoryIds =
    //       fetchedBrandCategories
    //           .where((e) => e.brandId == brand.id)
    //           .map((e) => e.categoryId)
    //           .toList();

    //   brand.brandCategories =
    //       fetchedCategories
    //           .where((category) => categoryIds.contains(category.id))
    //           .toList();
    // }

    return await brandRepository.fetchItems();
  }

  void sortByColumn(int columnIndex, bool ascending) {
    sortColumnIndex = columnIndex;
    sortAscending = ascending;

    switch (columnIndex) {
      case 0: // name
        return sortByProperty(
          columnIndex,
          ascending,
          (dynamic brand) => (brand as BrandModel).name.toLowerCase(),
        );
      default:
        return;
    }
  }
}
