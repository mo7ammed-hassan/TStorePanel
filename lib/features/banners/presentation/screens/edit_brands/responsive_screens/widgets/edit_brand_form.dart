import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store_admin_panel/config/routes/routes.dart';
import 'package:t_store_admin_panel/core/shared/widgets/chip/choice_chip.dart';
import 'package:t_store_admin_panel/core/shared/widgets/containers/rounded_container.dart';
import 'package:t_store_admin_panel/core/shared/widgets/images/uploader_image.dart';
import 'package:t_store_admin_panel/core/utils/device/device_utility.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/enums.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/images_strings.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/core/utils/utils/helpers/navigation.dart';
import 'package:t_store_admin_panel/core/utils/utils/validators/validation.dart';
import 'package:t_store_admin_panel/data/models/category/category_model.dart';

class EditBrandForm extends StatelessWidget {
  const EditBrandForm({super.key});

  @override
  Widget build(BuildContext context) {
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
              'Update Brand',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: AppSizes.spaceBtwSections),

            TextFormField(
              validator: (value) => TValidator.validateEmptyText('Name', value),
              decoration: const InputDecoration(
                labelText: 'Brand Name',
                prefixIcon: Icon(Iconsax.box),
              ),
            ),
            const SizedBox(height: AppSizes.spaceBtwInputFields),

            Text(
              'Select Categories',
              style: Theme.of(context).textTheme.headlineMedium,
            ),

            const SizedBox(height: AppSizes.spaceBtwSections),

            Wrap(
              spacing: AppSizes.sm,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: AppSizes.sm),
                  child: TChoiceChip(
                    text: 'Shoes',
                    isSelected: true,
                    onSelected: (select) {},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: AppSizes.sm),
                  child: TChoiceChip(
                    text: 'Track suits',
                    isSelected: true,
                    onSelected: (select) {},
                  ),
                ),
              ],
            ),

            const SizedBox(height: AppSizes.spaceBtwInputFields * 2),

            UploaderImage(
              width: 80,
              height: 80,
              image: TImages.darkAppLogo,
              imageType: ImageType.asset,
              onIconButtonPressed:
                  () => context.pushNamedPage(
                    Routes.editCategory,
                    arguments: CategoryModel.empty(),
                  ),
            ),

            const SizedBox(height: AppSizes.spaceBtwInputFields),

            CheckboxMenuButton(
              value: true,
              onChanged: (value) {},
              child: const Text('Featured'),
            ),

            const SizedBox(height: AppSizes.spaceBtwInputFields * 2),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Update'),
              ),
            ),

            const SizedBox(height: AppSizes.spaceBtwInputFields * 2),
          ],
        ),
      ),
    );
  }
}
