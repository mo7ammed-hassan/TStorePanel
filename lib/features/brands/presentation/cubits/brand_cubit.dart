import 'package:dartz/dartz.dart';
import 'package:t_store_admin_panel/config/service_locator/service_locator.dart';
import 'package:t_store_admin_panel/core/utils/storage/cache_storage_mangement.dart';
import 'package:t_store_admin_panel/core/utils/constants/firebase_collections.dart';
import 'package:t_store_admin_panel/data/abstract/cubit/base_data_table_cubit.dart';
import 'package:t_store_admin_panel/data/abstract/cubit/base_data_table_states.dart';
import 'package:t_store_admin_panel/data/models/brands/brand_model.dart';
import 'package:t_store_admin_panel/data/models/category/category_model.dart';
import 'package:t_store_admin_panel/data/repositories/brands/brand_repo.dart';
import 'package:t_store_admin_panel/features/categories/cubits/category/category_cubit.dart';

class BrandCubit extends BaseDataTableCubit<BrandModel> {
  BrandCubit(this.brandRepository)
    : super(
        DataTableInitial(),
        CacheStorageManagementImpl<BrandModel>(
          FirebaseCollections.brands,
          3,
          adapter: BrandModelAdapter(),
        ),
      );

  final BrandRepo brandRepository;
  final List<CategoryModel> categories = [];

  @override
  bool containSearchQuery(BrandModel item, String query) {
    return item.name.toLowerCase().contains(query.toLowerCase());
  }

  @override
  Future<Either<String, Unit>> deleteItem(BrandModel item) async {
    if (item.id == null) {
      return const Left("Item ID is null");
    }

    return await brandRepository.deleteItem(item);
  }

  @override
  Future<Either<String, List<BrandModel>>> fetchItems() async {
    return await brandRepository.fetchItems();
  }

  void sortByColumn(int columnIndex, bool ascending) {
    sortColumnIndex = columnIndex;
    sortAscending = ascending;

    switch (columnIndex) {
      case 0:
        return sortByProperty(
          columnIndex,
          ascending,
          (dynamic brand) => (brand as BrandModel).name.toLowerCase(),
        );
      default:
        return;
    }
  }

  Future fetcCategories() async {
    var result = await getIt<CategoryCubit>().fetchItems();

    result.fold((error) => null, (data) {
      categories.clear();
      categories.addAll(data);
    });
  }
}
