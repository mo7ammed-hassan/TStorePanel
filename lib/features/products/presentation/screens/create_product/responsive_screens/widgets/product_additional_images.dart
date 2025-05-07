import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store_admin_panel/core/shared/widgets/containers/rounded_container.dart';
import 'package:t_store_admin_panel/core/shared/widgets/images/uploader_image.dart';
import 'package:t_store_admin_panel/core/utils/constants/colors.dart';
import 'package:t_store_admin_panel/core/utils/constants/enums.dart';
import 'package:t_store_admin_panel/core/utils/constants/images.dart';
import 'package:t_store_admin_panel/core/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/core/utils/helpers/helper_functions.dart';

class ProductAdditionalImages extends StatelessWidget {
  const ProductAdditionalImages({
    super.key,
    this.onTapAddImages,
    required this.additionalProductImagesUrls,
    this.onTapRemoveImage,
  });

  final Function()? onTapAddImages;
  final List<String> additionalProductImagesUrls;
  final void Function(int index)? onTapRemoveImage;

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    return SizedBox(
      height: 300,
      child: Column(
        children: [
          // section to add additional images
          Expanded(
            flex: 2,
            child: GestureDetector(
              onTap: onTapAddImages,
              child: RoundedContainer(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        AppImages.defaultProductImage,
                        width: 50,
                        height: 50,
                      ),
                      const Text('Add Additional Product Images'),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSizes.spaceBtwItems),
          // section to display uploaded Images
          Expanded(
            child: Row(
              children: [
                // images List
                Expanded(
                  flex: 2,
                  child: SizedBox(
                    height: 80,
                    child: _buildImagesOrEmptyList(isDark),
                  ),
                ),
                const SizedBox(width: AppSizes.spaceBtwItems / 2),

                // add image button
                RoundedContainer(
                  height: 80,
                  width: 80,
                  showBorder: true,
                  borderColor: AppColors.grey,
                  onTap: onTapAddImages,
                  child: const Center(child: Icon(Iconsax.add)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImagesOrEmptyList(isDark) {
    return additionalProductImagesUrls.isEmpty
        ? _buildEmptyList(isDark)
        : _buildUploadedImages();
  }

  Widget _buildEmptyList(isDark) {
    return ListView.separated(
      itemCount: 6,
      scrollDirection: Axis.horizontal,
      separatorBuilder:
          (context, index) => const SizedBox(width: AppSizes.defaultSpace / 2),
      itemBuilder: (context, index) {
        return RoundedContainer(
          height: 80,
          width: 80,
          backgroundColor:
              isDark ? AppColors.darkerGrey : AppColors.primaryBackground,
        );
      },
    );
  }

  Widget _buildUploadedImages() {
    return ListView.separated(
      itemCount: additionalProductImagesUrls.length,
      scrollDirection: Axis.horizontal,
      separatorBuilder:
          (context, index) => const SizedBox(width: AppSizes.defaultSpace / 2),
      itemBuilder: (context, index) {
        final image = additionalProductImagesUrls[index];
        return UploaderImage(
          top: 0,
          right: 0,
          height: 80,
          width: 80,
          left: null,
          bottom: null,
          imageType: ImageType.network,
          image: image,
          icon: Iconsax.trash,
          onIconButtonPressed: () => onTapRemoveImage!(index),
        );
      },
    );
  }
}
