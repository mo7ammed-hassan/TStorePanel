import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/images_strings.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/text_strings.dart';
import 'package:t_store_admin_panel/core/utils/utils/helpers/helper_functions.dart'
    show HelperFunctions;

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image(
            width: 100,
            height: 100,
            image: AssetImage(
              isDark ? TImages.lightAppLogo : TImages.darkAppLogo,
            ),
          ),
          const SizedBox(height: AppSizes.spaceBtwSections),
          Text(
            TTexts.loginTitle,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: AppSizes.sm),
          Text(
            TTexts.loginSubTitle,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
