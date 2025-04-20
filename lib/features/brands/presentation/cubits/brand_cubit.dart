import 'package:either_dart/either.dart';
import 'package:t_store_admin_panel/core/utils/storage/cache_storage_mangement.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/collection_constants.dart';
import 'package:t_store_admin_panel/data/abstract/cubit/base_data_table_cubit.dart';
import 'package:t_store_admin_panel/data/abstract/cubit/base_data_table_states.dart';
import 'package:t_store_admin_panel/data/models/brands/brand_model.dart';
import 'package:t_store_admin_panel/data/repositories/brands/brand_repo.dart';

class BrandCubit extends BaseDataTableCubit<BrandModel> {
  BrandCubit(this.repository)
    : super(
        DataTableInitial(),
        CacheStorageManagementImpl<BrandModel>(
          CollectionConstants.brands,
          3,
          adapter: BrandModelAdapter(),
        ),
      ) {
    init();
  }

  final BrandRepo repository;

  @override
  bool containSearchQuery(BrandModel item, String query) {
    return item.name.toLowerCase().contains(query.toLowerCase());
  }

  @override
  Future<Either<String, void>> deleteItem(BrandModel item) async {
    return await repository.deleteItem(item);
  }

  @override
  Future<Either<String, List<BrandModel>>> fetchItems() async {
    // await repository.fetcCategoriesBrand();
    // final Either<String, List<BrandModel>> result = await repository.fetchItems();
    return await repository.fetchItems();
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
