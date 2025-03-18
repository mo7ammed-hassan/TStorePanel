import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/enums.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/images_strings.dart';
import 'package:t_store_admin_panel/core/utils/utils/loaders/animation_loader.dart';
import 'package:t_store_admin_panel/data/models/image/image_model.dart';
import 'package:t_store_admin_panel/features/media/cubits/media/media_cubit.dart';
import 'package:t_store_admin_panel/features/media/presentation/widget/media_content/build_image_list.dart';

class ContentImagePreview extends StatelessWidget {
  const ContentImagePreview({
    super.key,
    required this.allowMultiSelection,
    required this.allowSelection,
  });

  final bool allowMultiSelection;
  final bool allowSelection;

  @override
  Widget build(BuildContext context) {
    final mediaCubit = context.read<MediaCubit>();
    return BlocBuilder<MediaCubit, MediaState>(
      buildWhen:
          (previous, current) =>
              current is FetchImagesSuccessState ||
              current is FetchImagesFailureState ||
              current is FetchImagesLoadingState ||
              current is SelectedCategoryState,
      builder: (context, state) {
        // Get selected Folder Images
        List<ImageModel> images = _getSelectedImages(mediaCubit);

        // if (state is FetchImagesLoadingState) {
        //   return _buildEmptyWidget();
        // }

        if (images.isEmpty) {
          return _buildEmptyWidget();
        }

        if (state is FetchImagesSuccessState) {
          if (state.images.isEmpty) return _buildEmptyWidget();
          return BuildImageList(
            images: state.images,
            allowMultiSelection: allowMultiSelection,
            allowSelection: allowSelection,
          );
        }

        if (state is FetchImagesFailureState) {
          return const SizedBox.shrink();
        }

        return (mediaCubit.selectedPath == MediaCategory.folders)
            ? _buildEmptyWidget()
            : BuildImageList(
              images: images,
              allowMultiSelection: allowMultiSelection,
              allowSelection: allowSelection,
            );
      },
    );
  }

  Widget _buildEmptyWidget() {
    return const TAnimationLoaderWidget(
      width: 300,
      height: 300,
      text: 'Select your Desired folder',
      animation: TImages.packaging,
    );
  }

  List<ImageModel> _getSelectedImages(MediaCubit mediaCubit) {
    List<ImageModel> images = [];

    if (mediaCubit.selectedPath == MediaCategory.banners) {
      images =
          mediaCubit.allBannerImages
              .where((image) => image.url.isNotEmpty)
              .toList();
    } else if (mediaCubit.selectedPath == MediaCategory.products) {
      images =
          mediaCubit.allProductImages
              .where((image) => image.url.isNotEmpty)
              .toList();
    } else if (mediaCubit.selectedPath == MediaCategory.brands) {
      images =
          mediaCubit.allBrandImages
              .where((image) => image.url.isNotEmpty)
              .toList();
    } else if (mediaCubit.selectedPath == MediaCategory.categories) {
      images =
          mediaCubit.allCategoryImages
              .where((image) => image.url.isNotEmpty)
              .toList();
    } else if (mediaCubit.selectedPath == MediaCategory.users) {
      images =
          mediaCubit.allUserImages
              .where((image) => image.url.isNotEmpty)
              .toList();
    }

    return images;
  }
}
