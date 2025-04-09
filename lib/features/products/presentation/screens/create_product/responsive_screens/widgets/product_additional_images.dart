import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store_admin_panel/core/shared/widgets/containers/rounded_container.dart';
import 'package:t_store_admin_panel/core/shared/widgets/images/uploader_image.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/colors.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/enums.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/images_strings.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/sizes.dart';

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
                        TImages.defaultProductImage,
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

          // section to display uploaded Images
          Expanded(
            child: Row(
              children: [
                // images List
                Expanded(
                  flex: 2,
                  child: SizedBox(height: 80, child: _buildImagesOrEmptyList()),
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

  Widget _buildImagesOrEmptyList() {
    return additionalProductImagesUrls.isEmpty
        ? _buildEmptyList()
        : _buildUploadedImages();
  }

  Widget _buildEmptyList() {
    return ListView.separated(
      itemCount: 6,
      scrollDirection: Axis.horizontal,
      separatorBuilder:
          (context, index) => const SizedBox(width: AppSizes.defaultSpace / 2),
      itemBuilder: (context, index) {
        return const RoundedContainer(
          height: 80,
          width: 80,
          backgroundColor: AppColors.primaryBackground,
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
