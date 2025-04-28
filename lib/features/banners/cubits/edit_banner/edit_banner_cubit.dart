import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store_admin_panel/config/service_locator/service_locator.dart';
import 'package:t_store_admin_panel/core/utils/storage/cache_storage_mangement.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/app_screens.dart';
import 'package:t_store_admin_panel/core/utils/utils/dialogs/show_confirmation_dialog.dart';
import 'package:t_store_admin_panel/core/utils/utils/popups/loaders.dart';
import 'package:t_store_admin_panel/data/abstract/repos/generic_repository.dart';
import 'package:t_store_admin_panel/data/models/banners/banner_model.dart';
import 'package:t_store_admin_panel/data/models/image/image_model.dart';
import 'package:t_store_admin_panel/features/banners/cubits/edit_banner/edit_banner_states.dart';
import 'package:t_store_admin_panel/features/media/cubits/media/media_cubit.dart';

class EditBannerCubit extends Cubit<EditBannerStates> {
  EditBannerCubit(this._repository, this._cacheStorageManagement)
    : super(EditBannerInitialState());

  final GenericRepository<BannerModel> _repository;
  final CacheStorageManagement _cacheStorageManagement;

  String? imageUrl = '';
  bool active = false;
  String targetScreen = AppScreens.allAppScreens[0];
  BannerModel oldBanner = BannerModel.empty();

  void init(BannerModel banner) {
    oldBanner = banner;
    imageUrl = banner.image;
    active = banner.active;
    targetScreen = banner.targetScreen;
  }

  Future<void> editBanner() async {
    emit(EditBannerLoadingState());
    if (imageUrl == null || imageUrl!.isEmpty) {
      Loaders.warningSnackBar(
        title: 'Error',
        message: 'Please select an image',
      );
      return;
    }

    CustomDialogs.showCircularLoader();

    // Mapping the old banner to the new one
    final updatedBanner = oldBanner.copyWith(
      image: imageUrl,
      active: active,
      targetScreen: targetScreen,
    );

    if (BannerModel.isSameModel(updatedBanner, oldBanner)) {
      CustomDialogs.hideLoader();
      Loaders.warningSnackBar(
        message: 'No changes detected!',
        title: 'Warning',
      );
      return;
    }

    final result = await _repository.updateItem(updatedBanner);

    result.fold(
      (error) {
        CustomDialogs.hideLoader();
        Loaders.errorSnackBar(
          title: 'Error',
          message: 'Failed to create banner: ${error.toString()}',
        );
        emit(EditBannerErrorState(error.toString()));
      },
      (_) async {
        await _cacheStorageManagement.updateItem(updatedBanner);
        if (!_cacheStorageManagement.isCacheValid()) {
          await _cacheStorageManagement.clearCacheStorage();
        }

        CustomDialogs.hideLoader();
        Loaders.successSnackBar(
          title: 'Congratulations',
          message: 'Banner created successfully',
        );
        emit(EditBannerSuccessState(updatedBanner));
      },
    );
  }

  void toggleActive(bool value) {
    active = value;
    emit(ToggleActiveState(active));
  }

  void pickImage() async {
    final mediaCubit = getIt<MediaCubit>();
    List<ImageModel>? selectedImages =
        await mediaCubit.selectionImagesFromMedia();

    if (selectedImages != null && selectedImages.isNotEmpty) {
      ImageModel selectedImage = selectedImages.first;
      imageUrl = selectedImage.url;
      emit(SelectedImageState(imageUrl));
    }
  }

  void setTargetScreen(String screen) {
    targetScreen = screen;
    emit(TargetScreenState(targetScreen));
  }

  void resetForm() {
    imageUrl = null;
    active = false;
    targetScreen = AppScreens.allAppScreens[0];
    emit(EditBannerInitialState());
  }
}
