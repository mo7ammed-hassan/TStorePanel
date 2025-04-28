import 'package:t_store_admin_panel/data/models/banners/banner_model.dart';

sealed class EditBannerStates {}

class EditBannerInitialState extends EditBannerStates {}
class EditBannerLoadingState extends EditBannerStates {}
class EditBannerSuccessState extends EditBannerStates {
  final BannerModel banner;
  EditBannerSuccessState(this.banner);
}
class EditBannerErrorState extends EditBannerStates {
  final String errorMessage;
  EditBannerErrorState(this.errorMessage);
}

class ToggleActiveState extends EditBannerStates {
  final bool isActive;
  ToggleActiveState(this.isActive);
}

class SelectedImageState extends EditBannerStates {
  final String? imaegUrl;
  SelectedImageState(this.imaegUrl);
}

class TargetScreenState extends EditBannerStates {
  final String targetScreen;
  TargetScreenState(this.targetScreen);
}
