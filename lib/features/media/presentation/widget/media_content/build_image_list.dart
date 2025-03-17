import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store_admin_panel/data/models/image/image_model.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/colors.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/features/media/cubits/media/media_cubit.dart';
import 'package:t_store_admin_panel/features/media/presentation/widget/media_content/image_card.dart';

class BuildImageList extends StatelessWidget {
  const BuildImageList({super.key, required this.images});
  final List<ImageModel> images;
  @override
  Widget build(BuildContext context) {
    final mediaCubit = context.read<MediaCubit>();
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Media List
        Wrap(
          spacing: AppSizes.spaceBtwItems / 2,
          runSpacing: AppSizes.spaceBtwItems / 2,
          children:
              images
                  .map(
                    (image) => ImageCard(image: image, mediaCubit: mediaCubit),
                  )
                  .toList(),
        ),

        /// Load More Media Button
        _buildLoadMoreButton(mediaCubit),
      ],
    );
  }

  Padding _buildLoadMoreButton(MediaCubit mediaCubit) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSizes.spaceBtwSections),
      child: Row(
        // To make button in center
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: AppSizes.buttonWidth + 10,
            child: ElevatedButton.icon(
              onPressed: () async => mediaCubit.fetchMoreImages(10),
              icon: const Icon(Iconsax.arrow_down, color: AppColors.white),
              label: const Text('Load More'),
            ),
          ),
        ],
      ),
    );
  }
}
