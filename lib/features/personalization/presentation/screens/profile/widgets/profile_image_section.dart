import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store_admin_panel/core/shared/widgets/containers/rounded_container.dart';
import 'package:t_store_admin_panel/core/shared/widgets/images/uploader_image.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/enums.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/images_strings.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/sizes.dart';

class ProfileImageSection extends StatelessWidget {
  const ProfileImageSection({super.key});

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
                 UploaderImage(
                  imageType: ImageType.asset,
                  image: TImages.user,
                  right: 10,
                  bottom: 20,
                  width: 200,
                  height: 200,
                  circular: true,
                  left: null,
                  icon: Iconsax.camera,
                  onIconButtonPressed: (){},
                ),
                const SizedBox(height: AppSizes.spaceBtwItems),

                Text(
                  'Mohamed H.',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const Text('mohamedh7h@gmail.com'),
                const SizedBox(height: AppSizes.spaceBtwItems),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
