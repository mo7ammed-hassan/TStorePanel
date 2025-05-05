import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store_admin_panel/config/routes/routes.dart';
import 'package:t_store_admin_panel/core/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/core/utils/constants/text_strings.dart';
import 'package:t_store_admin_panel/core/utils/helpers/navigation.dart';

class HeaderAndFormForgetPassword extends StatelessWidget {
  const HeaderAndFormForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Header
        IconButton(
          onPressed: () => context.popPage(context),
          icon: const Icon(Iconsax.arrow_left),
        ),
        const SizedBox(height: AppSizes.spaceBtwItems),
        Text(
          TTexts.forgetPassword,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: AppSizes.spaceBtwItems),
        Text(
          TTexts.forgetPasswordSubTitle,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        const SizedBox(height: AppSizes.spaceBtwSections * 2),

        /// Form
        Form(
          child: TextFormField(
            decoration: const InputDecoration(
              labelText: TTexts.email,
              prefixIcon: Icon(Iconsax.direct_right),
            ),
          ),
        ),
        const SizedBox(height: AppSizes.spaceBtwSections),

        /// Submit Button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed:
                () => context.pushNamedPage(
                  '${Routes.resetPassword}/users?email=some@gmail.com',
                ),
            child: const Text(TTexts.submit),
          ),
        ),
        const SizedBox(height: AppSizes.spaceBtwSections * 2),
      ],
    );
  }
}
