import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/core/shared/widgets/containers/rounded_container.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/sizes.dart';

class BillingAddress extends StatelessWidget {
  const BillingAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      padding: const EdgeInsets.all(AppSizes.defaultSpace),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Billing Address',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: AppSizes.spaceBtwSections),
          Text('Mohamed Hassan', style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: AppSizes.spaceBtwItems / 2),
          Text(
            'Cairo, Egypt, Al Zohour, 12454',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          
        ],
      ),
    );
  }
}
