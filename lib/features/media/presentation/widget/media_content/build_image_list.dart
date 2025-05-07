import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store_admin_panel/config/service_locator/service_locator.dart';
import 'package:t_store_admin_panel/data/models/image/image_model.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store_admin_panel/core/utils/constants/colors.dart';
import 'package:t_store_admin_panel/core/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/features/media/cubits/actions/media_action_cubit.dart';
import 'package:t_store_admin_panel/features/media/cubits/media/media_cubit.dart';
import 'package:t_store_admin_panel/features/media/presentation/widget/media_content/image_card.dart';

class BuildImageList extends StatelessWidget {
  const BuildImageList({
    super.key,
    required this.images,
    required this.allowSelection,
    required this.allowMultiSelection,
  });
  final List<ImageModel> images;
  final bool allowSelection;
  final bool allowMultiSelection;
  @override
  Widget build(BuildContext context) {
    final mediaCubit = context.read<MediaCubit>();
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Media List
        if (!allowSelection)
          _buildDefaultMediaList(mediaCubit)
        else
          _buildMediaListCheckbox(mediaCubit),

        /// Load More Media Button
        _buildLoadMoreButton(mediaCubit),
      ],
    );
  }

  // Default Media List 'Without checkbox'
  Wrap _buildDefaultMediaList(MediaCubit mediaCubit) {
    return Wrap(
      spacing: AppSizes.spaceBtwItems / 2,
      runSpacing: AppSizes.spaceBtwItems / 2,
      children:
          images
              .map((image) => ImageCard(image: image, mediaCubit: mediaCubit))
              .toList(),
    );
  }

  // Media List 'With checkbox'
  Widget _buildMediaListCheckbox(MediaCubit mediaCubit) {
    return BlocProvider.value(
      value: getIt<MediaActionCubit>(),
      child: Wrap(
        spacing: AppSizes.spaceBtwItems / 2,
        runSpacing: AppSizes.spaceBtwItems / 2,
        children:
            images
                .map(
                  (image) => Stack(
                    children: [
                      ImageCard(image: image, mediaCubit: mediaCubit),
                      Positioned(
                        top: AppSizes.md,
                        right: AppSizes.md,
                        child: BlocSelector<
                          MediaActionCubit,
                          MediaActionState,
                          bool
                        >(
                          selector: (state) {
                            if (state is ToggleImageCheckBox) {
                              if (state.selectedImageVal == image) {
                                return state.selectedImageVal.isSelected;
                              }
                              return image.isSelected;
                            } else {
                              return image.isSelected;
                            }
                          },
                          builder: (context, isSelected) {
                            // debugPrint(
                            //   'isSelected: $isSelected ${image.fileName}',
                            // );
                            return Checkbox(
                              value: image.isSelected,
                              onChanged: (select) {
                                context
                                    .read<MediaActionCubit>()
                                    .toggleImageCheckBox(
                                      image,
                                      select,
                                      allowMultiSelection,
                                    );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                )
                .toList(),
      ),
    );
  }

  Padding _buildLoadMoreButton(MediaCubit mediaCubit) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSizes.spaceBtwSections),
      child: Row(
        // To make button in center
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: ElevatedButton.icon(
              onPressed: () async => mediaCubit.fetchMoreImages(10),
              icon: const Icon(Iconsax.arrow_down, color: AppColors.white),
              label: const FittedBox(child: Text('Load More')),
            ),
          ),
        ],
      ),
    );
  }
}
