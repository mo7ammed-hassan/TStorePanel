import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store_admin_panel/core/shared/widgets/containers/rounded_container.dart';
import 'package:t_store_admin_panel/core/shared/widgets/images/rounded_image.dart';
import 'package:t_store_admin_panel/core/utils/device/device_utility.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/colors.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/images_strings.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/core/utils/utils/validators/validation.dart';

class ProductAttributes extends StatelessWidget {
  const ProductAttributes({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(color: AppColors.primaryBackground),
        const SizedBox(height: AppSizes.spaceBtwSections),

        Text(
          'Product Attributes',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: AppSizes.spaceBtwItems),

        // form to add new attribute
        Form(
          child:
              DeviceUtility.isDesktopScreen(context)
                  ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: _buildAttributeName()),
                      const SizedBox(width: AppSizes.spaceBtwItems),
                      Expanded(flex: 2, child: _buildAttributeValue()),
                      const SizedBox(width: AppSizes.spaceBtwItems),
                      _buildAtrributeButton(),
                    ],
                  )
                  : Column(
                    children: [
                      _buildAttributeName(),
                      const SizedBox(height: AppSizes.spaceBtwItems),
                      _buildAttributeValue(),
                      const SizedBox(height: AppSizes.spaceBtwItems),
                      _buildAtrributeButton(),
                    ],
                  ),
        ),
        const SizedBox(height: AppSizes.spaceBtwSections),

        // List of added attributes
        Text(
          'All Attributes',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: AppSizes.spaceBtwItems),

        // Display added attributes
        RoundedContainer(
          backgroundColor: AppColors.primaryBackground,
          child: Column(
            children: [_buildAttrivutesList(), _buildEmptyAttributesList()],
          ),
        ),
        const SizedBox(height: AppSizes.spaceBtwSections),

        Center(
          child: SizedBox(
            width: 200,
            child: FittedBox(
              child: ElevatedButton.icon(
                onPressed: () {},
                label: const Text('Generate Variations'),
                icon: const Icon(Iconsax.activity),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAttributeName() {
    return TextFormField(
      validator:
          (value) => TValidator.validateEmptyText('Attribute Name', value),
      decoration: const InputDecoration(
        labelText: 'Attribute Name',
        hintText: 'Colors, Sizes, Materials.',
        border: InputBorder.none,
      ),
    );
  }

  Widget _buildAttributeValue() {
    return SizedBox(
      height: 80,
      child: TextFormField(
        expands: true,
        maxLines: null,
        // textAlign: TextAlign.start,
        keyboardType: TextInputType.multiline,
        textAlignVertical: TextAlignVertical.top,
        validator:
            (value) => TValidator.validateEmptyText('Attribute Value', value),
        decoration: const InputDecoration(
          labelText: 'Attribute Value',
          hintText: 'Add attributes separated by | Ex: Red | Blue | Green',
          alignLabelWithHint: true,
        ),
      ),
    );
  }

  Widget _buildAtrributeButton() {
    return SizedBox(
      width: 100,
      child: ElevatedButton.icon(
        onPressed: () {},
        label: const Text('Add'),
        icon: const Icon(Iconsax.add),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.secondary,
          foregroundColor: AppColors.black,
          side: const BorderSide(color: AppColors.secondary),
        ),
      ),
    );
  }

  Widget _buildAttrivutesList() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 3,
      separatorBuilder:
          (context, index) => const SizedBox(height: AppSizes.spaceBtwItems),
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
          ),

          child: ListTile(
            contentPadding: const EdgeInsets.all(AppSizes.defaultSpace),
            title: const Text('Color'),
            subtitle: const Text('Red | Blue | Green'),
            trailing: IconButton(
              onPressed: () {},
              icon: const Icon(Iconsax.trash, color: AppColors.error),
            ),
          ),
        );
      },
    );
  }

  Widget _buildEmptyAttributesList() {
    return const Column(
      children: [
        RoundedImage(imageUrl: TImages.acerlogo, width: 150, height: 80),
        SizedBox(height: AppSizes.spaceBtwItems),
        Text('There are no attributes added yet.'),
      ],
    );
  }
}
