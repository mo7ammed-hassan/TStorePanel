import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/config/routes/routes.dart';
import 'package:t_store_admin_panel/core/utils/constants/images.dart';
import 'package:t_store_admin_panel/core/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/core/utils/constants/text_strings.dart';
import 'package:t_store_admin_panel/core/utils/helpers/navigation.dart';

class ResetPasswordWidget extends StatelessWidget {
  const ResetPasswordWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final uri = Uri.parse(ModalRoute.of(context)?.settings.name ?? '');
    final email = uri.queryParameters['email'] ?? '';

    return Column(
      children: [
        // Headers
        Align(
          alignment: Alignment.centerLeft,
          child: IconButton(
            onPressed: () => context.pushNamedAndRemoveUntilPage(Routes.login),
            icon: const Icon(CupertinoIcons.clear),
          ),
        ),
        const SizedBox(height: AppSizes.spaceBtwItems),

        /// Image
        const Image(
          image: AssetImage(AppImages.deliveredEmailIllustration),
          width: 300,
          height: 300,
        ),
        const SizedBox(height: AppSizes.spaceBtwItems),

        /// Title & subTitle
        Text(
          TTexts.changeYourPasswordTitle,
          textAlign: TextAlign.center,

          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: AppSizes.spaceBtwItems),
        Text(
          email,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const SizedBox(height: AppSizes.spaceBtwItems),
        Text(
          TTexts.changeYourPasswordSubTitle,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.labelMedium,
        ),

        const SizedBox(height: AppSizes.spaceBtwSections),

        /// Buttons
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              context.pushNamedAndRemoveUntilPage(Routes.dashboard);
            },
            child: const Text(TTexts.done),
          ),
        ),
        const SizedBox(height: AppSizes.spaceBtwItems),
        SizedBox(
          width: double.infinity,
          child: TextButton(
            onPressed: () {},
            child: const Text(TTexts.resendEmail),
          ),
        ),
      ],
    );
  }
}
