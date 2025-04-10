import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/core/shared/widgets/breadcrumb/breadcrumb_with_heading.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/features/personalization/presentation/screens/settings/widgets/image_and_meta_data.dart';
import 'package:t_store_admin_panel/features/personalization/presentation/screens/settings/widgets/settings_form.dart';

class SettingsDesktopScreen extends StatelessWidget {
  const SettingsDesktopScreen({super.key});

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
              Row(
                children: [
                  // Profile Image
                  Expanded(child: ImageAndMetaData()),
                  SizedBox(width: AppSizes.spaceBtwSections),

                  // Profile Details
                  Expanded(flex: 2, child: SettingsForm()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
