import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/core/shared/widgets/breadcrumb/breadcrumb_with_heading.dart';
import 'package:t_store_admin_panel/core/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/features/personalization/presentation/screens/profile/responsive_screens/widgets/profile_mobile_form.dart';
import 'package:t_store_admin_panel/features/personalization/presentation/screens/profile/widgets/profile_image_section.dart';

class ProfileMobileScreen extends StatelessWidget {
  const ProfileMobileScreen({super.key});

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
                heading: 'Profile',
                breadcrumbs: ['Profile'],
              ),
              SizedBox(height: AppSizes.spaceBtwSections),

              // Profile Image
              ProfileImageSection(),
              SizedBox(height: AppSizes.spaceBtwSections),

              // Profile Details
              ProfileMobileForm(),
            ],
          ),
        ),
      ),
    );
  }
}
