import 'package:either_dart/either.dart';
import 'package:t_store_admin_panel/core/utils/storage/cache_storage_mangement.dart';
import 'package:t_store_admin_panel/data/abstract/cubit/base_data_table_cubit.dart';
import 'package:t_store_admin_panel/data/abstract/cubit/base_data_table_states.dart';
import 'package:t_store_admin_panel/data/models/category/category_model.dart';
import 'package:t_store_admin_panel/domain/repositories/category/category_repo.dart';

class CategoryCubit extends BaseDataTableCubit<CategoryModel> {
  CategoryCubit(this.categoryRepo)
    : super(
        DataTableInitial(),
        CacheStorageManagementImpl<CategoryModel>(
          'categories',
          1,
          adapter: CategoryModelAdapter(),
        ),
      ) {
    init();
  }
  final CategoryRepo categoryRepo;

  @override
  Future<Either<String, List<CategoryModel>>> fetchItems() async {
    return await categoryRepo.fetchCategories();
  }

  @override
  Future<Either<String, void>> deleteItem(item) async {
    return await categoryRepo.deleteCategory(item);
  }

  void sortByColumn(int columnIndex, bool ascending) {
    sortColumnIndex = columnIndex;
    sortAscending = ascending;

    switch (columnIndex) {
      case 0: // Category name
        return sortByProperty(
          columnIndex,
          ascending,
          (dynamic category) => (category as CategoryModel).name.toLowerCase(),
        );
      case 1: // Parent ID
        return sortByProperty(
          columnIndex,
          ascending,
          (dynamic category) => (category as CategoryModel).parentId,
        );
      case 2: // Featured
        return sortByProperty(
          columnIndex,
          ascending,
          (dynamic category) => (category as CategoryModel).isFeatured == true ? 1 : 0,
        );
      default:
        return;
    }
  }

  @override
  bool containSearchQuery(CategoryModel item, String query) {
    return item.name.toLowerCase().contains(query.toLowerCase());
  }
}
