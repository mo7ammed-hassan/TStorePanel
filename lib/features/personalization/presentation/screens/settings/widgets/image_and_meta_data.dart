import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store_admin_panel/core/shared/widgets/containers/rounded_container.dart';
import 'package:t_store_admin_panel/core/shared/widgets/images/uploader_image.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/enums.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/images_strings.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/sizes.dart';

class ImageAndMetaData extends StatelessWidget {
  const ImageAndMetaData({super.key});

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      padding: const EdgeInsets.symmetric(
        vertical: AppSizes.lg,
        horizontal: AppSizes.md,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Column(
              children: [
                const UploaderImage(
                  imageType: ImageType.asset,
                  image: TImages.user,
                  right: 10,
                  bottom: 20,
                  width: 200,
                  height: 200,
                  circular: true,
                  left: null,
                  icon: Iconsax.camera,
                ),
                const SizedBox(height: AppSizes.spaceBtwItems),

                Text(
                  'T Store',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
