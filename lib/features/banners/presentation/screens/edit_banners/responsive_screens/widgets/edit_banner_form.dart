import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/core/shared/widgets/containers/rounded_container.dart';
import 'package:t_store_admin_panel/core/shared/widgets/images/t_rounded_image.dart';
import 'package:t_store_admin_panel/core/utils/device/device_utility.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/colors.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/enums.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/images_strings.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/core/utils/utils/helpers/helper_functions.dart';

class EditBannerForm extends StatelessWidget {
  const EditBannerForm({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    return RoundedContainer(
      width: DeviceUtility.isMobileScreen(context) ? double.infinity : 500,
      padding: const EdgeInsets.all(AppSizes.defaultSpace),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Heading
            const SizedBox(height: AppSizes.sm),

            Text(
              'Update Banner',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: AppSizes.spaceBtwSections),

            Column(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: TRoundedImage(
                    width: 400,
                    height: 200,
                    fit: BoxFit.cover,
                    backgroundColor:
                        isDark
                            ? AppColors.darkerGrey
                            : AppColors.primaryBackground,

                    imageType: ImageType.asset,
                    image: TImages.banner1,
                  ),
                ),
                const SizedBox(height: AppSizes.spaceBtwItems),
                const Text('Select Image'),
              ],
            ),
            const SizedBox(height: AppSizes.spaceBtwInputFields),

            Text(
              'Make your Banner Active or Inactive',
              style: Theme.of(context).textTheme.bodyMedium,
            ),

            CheckboxMenuButton(
              value: true,
              onChanged: (value) {},
              child: const Text('Active'),
            ),

            const SizedBox(height: AppSizes.spaceBtwInputFields),

            DropdownButton(
              value: 'search',
              items: const [
                DropdownMenuItem(value: 'home', child: Text('Home')),
                DropdownMenuItem(value: 'search', child: Text('Search')),
              ],
              onChanged: (value) {},
            ),

            const SizedBox(height: AppSizes.spaceBtwInputFields * 2),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Create'),
              ),
            ),

            const SizedBox(height: AppSizes.spaceBtwInputFields * 2),
          ],
        ),
      ),
    );
  }
}
