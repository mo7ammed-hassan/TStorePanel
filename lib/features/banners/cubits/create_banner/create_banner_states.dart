import 'package:t_store_admin_panel/data/models/banners/banner_model.dart';

sealed class CreateBannerStates {}

class CreateBannerInitialState extends CreateBannerStates {}

class CreateBannerLoadingState extends CreateBannerStates {}  

class CreateBannerSuccessState extends CreateBannerStates {
  final BannerModel banner;
  CreateBannerSuccessState({required this.banner});
}

class CreateBannerFailureState extends CreateBannerStates {
  final String errorMessage;
  CreateBannerFailureState({required this.errorMessage});
}

class ToggleActiveState extends CreateBannerStates {
  final bool active;
  ToggleActiveState({required this.active});
}

class SelectedImageState extends CreateBannerStates {
  final String imageUrl;
  SelectedImageState({required this.imageUrl});
}

class TargetScreenState extends CreateBannerStates {
  final String targetScreen;
  TargetScreenState({required this.targetScreen});
}