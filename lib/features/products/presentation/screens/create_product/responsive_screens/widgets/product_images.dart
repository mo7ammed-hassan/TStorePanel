import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/core/shared/widgets/containers/rounded_container.dart'
    show RoundedContainer;
import 'package:t_store_admin_panel/core/utils/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/features/products/presentation/screens/create_product/responsive_screens/widgets/product_additional_images.dart';

class ProductImages extends StatelessWidget {
  const ProductImages({super.key});

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'All Product Images',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: AppSizes.spaceBtwItems),

          // Images
          ProductAdditionalImages(
            additionalProductImagesUrls: const [],
            onTapAddImages: () {},
            onTapRemoveImage: (index) {},
          ),
        ],
      ),
    );
  }
}
