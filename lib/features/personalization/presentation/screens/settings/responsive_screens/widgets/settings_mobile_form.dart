import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store_admin_panel/core/shared/widgets/containers/rounded_container.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/sizes.dart';

class SettingsMobileForm extends StatelessWidget {
  const SettingsMobileForm({super.key});

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      padding: const EdgeInsets.symmetric(
        vertical: AppSizes.lg,
        horizontal: AppSizes.md,
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'App Settings',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: AppSizes.spaceBtwSections),

          // Form
          Form(
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'App Name',
                    label: Text('App Name'),
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
                const SizedBox(height: AppSizes.spaceBtwInputFields),

                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Tax %',
                    label: Text('Tax Rate (%)'),
                    prefixIcon: Icon(Iconsax.tag),
                  ),
                ),
                const SizedBox(height: AppSizes.spaceBtwItems),

                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Shipping Cost',
                    label: Text(r'Shipping Cost ($)'),
                    prefixIcon: Icon(Iconsax.ship),
                  ),
                ),
                const SizedBox(height: AppSizes.spaceBtwItems),

                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Free Shipping After (\$)',
                    label: Text('Free Shipping Threshold (\$)'),
                    prefixIcon: Icon(Iconsax.ship),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: AppSizes.spaceBtwInputFields * 2),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('Update App Settings'),
            ),
          ),
        ],
      ),
    );
  }
}
