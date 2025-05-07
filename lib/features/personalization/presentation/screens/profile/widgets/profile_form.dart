import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store_admin_panel/core/shared/widgets/containers/rounded_container.dart';
import 'package:t_store_admin_panel/core/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/core/utils/validators/validation.dart';

class ProfileForm extends StatelessWidget {
  const ProfileForm({super.key});

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
            'Profile Details',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: AppSizes.spaceBtwSections),

          // Form
          Form(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        validator:
                            (value) => ValidatorFields.validateEmptyText(
                              'First Name',
                              value,
                            ),
                        decoration: const InputDecoration(
                          hintText: 'First Name',
                          label: Text('First Name'),
                          prefixIcon: Icon(Iconsax.user),
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSizes.spaceBtwItems),

                    Expanded(
                      child: TextFormField(
                        validator:
                            (value) => ValidatorFields.validateEmptyText(
                              'Last Name',
                              value,
                            ),
                        decoration: const InputDecoration(
                          hintText: 'Last Name',
                          label: Text('Last Name'),
                          prefixIcon: Icon(Iconsax.user),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: AppSizes.spaceBtwInputFields),

                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        validator:
                            (value) => ValidatorFields.validateEmail(value),
                        decoration: const InputDecoration(
                          hintText: 'Email',
                          label: Text('Email'),
                          prefixIcon: Icon(Iconsax.forward),
                          enabled: false,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSizes.spaceBtwItems),

                    Expanded(
                      child: TextFormField(
                        validator:
                            (value) =>
                                ValidatorFields.validatePhoneNumber(value),
                        decoration: const InputDecoration(
                          hintText: 'Phone Number',
                          label: Text('Phone Number'),
                          prefixIcon: Icon(Iconsax.mobile),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: AppSizes.spaceBtwItems),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('Update Profile'),
            ),
          ),
        ],
      ),
    );
  }
}
