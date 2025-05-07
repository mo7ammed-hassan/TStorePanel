import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store_admin_panel/core/shared/widgets/containers/rounded_container.dart';
import 'package:t_store_admin_panel/core/utils/constants/colors.dart';
import 'package:t_store_admin_panel/core/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/features/customers/presentation/screens/customer_detail/table/data_table.dart';

class CustomerOrderSection extends StatelessWidget {
  const CustomerOrderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      padding: const EdgeInsets.all(AppSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'Orders',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              const Spacer(),
              Flexible(
                child: Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(text: 'Total Spent '),
                      TextSpan(
                        text: '\$500.0',
                        style: Theme.of(
                          context,
                        ).textTheme.bodyLarge!.apply(color: AppColors.primary),
                      ),
                      TextSpan(
                        text: 'on ${5} orders',
                        style: Theme.of(context).textTheme.bodyLarge!,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.spaceBtwItems),

          TextFormField(
            onChanged: (value) {},
            decoration: const InputDecoration(
              prefixIcon: Icon(Iconsax.search_normal),
              hintText: 'Search Orders',
            ),
          ),
          const SizedBox(height: AppSizes.spaceBtwSections),

          const CustomOrderTable(),
        ],
      ),
    );
  }
}
