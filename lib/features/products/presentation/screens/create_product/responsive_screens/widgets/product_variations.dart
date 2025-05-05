import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:t_store_admin_panel/core/shared/widgets/images/t_rounded_image.dart';
import 'package:t_store_admin_panel/core/utils/constants/colors.dart';
import 'package:t_store_admin_panel/core/utils/constants/enums.dart';
import 'package:t_store_admin_panel/core/utils/constants/images.dart';
import 'package:t_store_admin_panel/core/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/core/utils/helpers/helper_functions.dart';

class ProductVariations extends StatelessWidget {
  const ProductVariations({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Product Variations',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            TextButton(
              onPressed: () {},
              child: const Text('Remove Variations'),
            ),
          ],
        ),
        const SizedBox(height: AppSizes.spaceBtwItems),

        // Variations List
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 2,
          separatorBuilder:
              (context, index) =>
                  const SizedBox(height: AppSizes.spaceBtwItems),
          itemBuilder: (context, index) => _buildVariationItem(context, isDark),
        ),

        // No Variation Message
        //_buildNoVariationMessage(context),
      ],
    );
  }

  Widget _buildVariationItem(BuildContext context, isDark) {
    return ExpansionTile(
      collapsedBackgroundColor: isDark ? AppColors.dark : AppColors.lightGrey,
      backgroundColor: isDark ? AppColors.dark : AppColors.lightGrey,
      childrenPadding: const EdgeInsets.all(AppSizes.md),
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
      ),
      title: const Text('Color: Green'),
      children: [
        // upload variation
        const TRoundedImage(
          imageType: ImageType.asset,
          width: 100,
          height: 100,
          image: AppImages.acerlogo,
        ),
        const SizedBox(height: AppSizes.spaceBtwInputFields),

        // variation price and stock
        Row(
          children: [
            Expanded(
              child: TextFormField(
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
                  labelText: 'Stock',
                  hintText: 'Add Stock, only numbers allowed',
                ),
              ),
            ),
            const SizedBox(width: AppSizes.spaceBtwInputFields),

            Expanded(
              child: TextFormField(
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                ],

                decoration: const InputDecoration(
                  labelText: 'Price',
                  hintText: 'Price with up-to 2 decimal places',
                ),
              ),
            ),
            const SizedBox(width: AppSizes.spaceBtwInputFields),

            Expanded(
              child: TextFormField(
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                ],

                decoration: const InputDecoration(
                  labelText: 'Discount Price',
                  hintText: 'Price with up-to 2 decimal places',
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSizes.spaceBtwInputFields),

        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Discription',
            hintText: 'Add discription of this variation...',
          ),
        ),
        const SizedBox(height: AppSizes.spaceBtwSections),
      ],
    );
  }

  // Widget _buildNoVariationMessage(BuildContext context) {
  //   return const Column(
  //     children: [
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           TRoundedImage(
  //             imageType: ImageType.asset,
  //             width: 200,
  //             height: 200,
  //             image: TImages.acerlogo,
  //           ),
  //         ],
  //       ),
  //       SizedBox(height: AppSizes.spaceBtwItems),
  //       Text('There are no variations added yet.'),
  //     ],
  //   );
  // }
}
