import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/core/shared/widgets/containers/rounded_container.dart';
import 'package:t_store_admin_panel/core/shared/widgets/images/t_rounded_image.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/enums.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/images_strings.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/sizes.dart';

class CustomerInfoSection extends StatelessWidget {
  const CustomerInfoSection({super.key});
  // final User Model
  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Customer Information',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: AppSizes.spaceBtwSections),

          // Personal Information
          Row(
            children: [
              const TRoundedImage(
                padding: 0,
                imageType: ImageType.asset,
                image: TImages.user,
                width: 50,
                height: 50,
              ),
              const SizedBox(width: AppSizes.spaceBtwItems),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Mohamed H.',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),

                    const Text(
                      'mohamedh7h@gmail.com',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.spaceBtwSections),

          // Meta Data
          Row(
            children: [
              const SizedBox(width: 120, child: Text('Username')),
              const Text(':'),
              const SizedBox(width: AppSizes.spaceBtwItems / 2),
              Expanded(
                child: Text(
                  'Mohamed hassan',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.spaceBtwItems),
          Row(
            children: [
              const SizedBox(width: 120, child: Text('country')),
              const Text(':'),
              const SizedBox(width: AppSizes.spaceBtwItems / 2),
              Expanded(
                child: Text(
                  'Egypt',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.spaceBtwItems),
          Row(
            children: [
              const SizedBox(width: 120, child: Text('Phone Number')),
              const Text(':'),
              const SizedBox(width: AppSizes.spaceBtwItems / 2),
              Expanded(
                child: Text(
                  '+201096493188',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.spaceBtwItems),
          const Divider(),
          const SizedBox(height: AppSizes.spaceBtwItems),

          // Additional details
          Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Last Order',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const Text('7 Days Ago, #[36d54]'),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Average Order Value',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const Text('\$100.00'),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.spaceBtwItems),
          Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Registered',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const Text('07/03/2025'),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Email Marketing',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const Text('Subscribed'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
