import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/core/shared/widgets/breadcrumb/breadcrumb_with_heading.dart';
import 'package:t_store_admin_panel/core/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/features/personalization/presentation/screens/settings/responsive_screens/widgets/settings_mobile_form.dart';
import 'package:t_store_admin_panel/features/personalization/presentation/screens/settings/widgets/image_and_meta_data.dart';

class SettingsMobileScreen extends StatelessWidget {
  const SettingsMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppSizes.spaceBtwItems),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumb
              BreadcrumbWithHeading(
                heading: 'Settings',
                breadcrumbs: ['Settings'],
              ),
              SizedBox(height: AppSizes.spaceBtwSections),

              // Body
              ImageAndMetaData(),
              SizedBox(height: AppSizes.spaceBtwSections),

              // Profile Details
              SettingsMobileForm(),
            ],
          ),
        ),
      ),
    );
  }
}
