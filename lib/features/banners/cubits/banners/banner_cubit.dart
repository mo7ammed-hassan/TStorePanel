import 'package:dartz/dartz.dart';
import 'package:t_store_admin_panel/core/utils/storage/cache_storage_mangement.dart';
import 'package:t_store_admin_panel/core/utils/constants/firebase_collections.dart';
import 'package:t_store_admin_panel/data/abstract/cubit/base_data_table_cubit.dart';
import 'package:t_store_admin_panel/data/abstract/cubit/base_data_table_states.dart';
import 'package:t_store_admin_panel/data/abstract/repos/generic_repository.dart';
import 'package:t_store_admin_panel/data/models/banners/banner_model.dart';

class BannerCubit extends BaseDataTableCubit<BannerModel> {
  BannerCubit(this.repository)
    : super(
        DataTableInitial(),
        CacheStorageManagementImpl<BannerModel>(
          FirebaseCollections.banners,
          2,
          adapter: BannerModelAdapter(),
        ),
      );

  final GenericRepository<BannerModel> repository;

  @override
  Future<Either<String, List<BannerModel>>> fetchItems() async {
    return await repository.fetchItems();
  }

  @override
  bool containSearchQuery(BannerModel item, String query) {
    return item.targetScreen.toLowerCase().contains(query.toLowerCase());
  }

  @override
  Future<Either<String, Unit>> deleteItem(BannerModel item) async {
    return await repository.deleteItem(item);
  }
}
