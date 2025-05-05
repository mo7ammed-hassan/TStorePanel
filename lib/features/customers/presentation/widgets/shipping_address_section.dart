import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/core/shared/widgets/containers/rounded_container.dart';
import 'package:t_store_admin_panel/core/utils/constants/sizes.dart';

class ShippingAddressSection extends StatelessWidget {
  const ShippingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Shipping Address',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: AppSizes.spaceBtwItems),

          Row(
            children: [
              const SizedBox(width: 120, child: Text('Name')),
              const Text(':'),
              const SizedBox(width: AppSizes.spaceBtwItems / 2),
              Expanded(
                child: Text(
                  'Address Name',
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
          Row(
            children: [
              const SizedBox(width: 120, child: Text('Address')),
              const Text(':'),
              const SizedBox(width: AppSizes.spaceBtwItems / 2),
              Expanded(
                child: Text(
                  'Cairo, Egypt,2659, 2nd floor',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
