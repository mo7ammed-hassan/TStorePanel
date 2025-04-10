import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/core/shared/widgets/breadcrumb/breadcrumb_with_heading.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/features/personalization/presentation/screens/profile/widgets/profile_form.dart';
import 'package:t_store_admin_panel/features/personalization/presentation/screens/profile/widgets/profile_image_section.dart';

class ProfileDesktopScreen extends StatelessWidget {
  const ProfileDesktopScreen({super.key});

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

              // Body
              Row(
                children: [
                  // Profile Image
                  Expanded(child: ProfileImageSection()),
                  SizedBox(width: AppSizes.spaceBtwSections),

                  // Profile Details
                  Expanded(flex: 2, child: ProfileForm(),),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
