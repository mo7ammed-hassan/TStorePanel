import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/config/routes/routes.dart';
import 'package:t_store_admin_panel/core/shared/widgets/breadcrumb/breadcrumb_with_heading.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/features/banners/presentation/screens/create_brands/responsive_screens/widgets/create_brand_form.dart';

class CreateBrandMobileScreen extends StatelessWidget {
  const CreateBrandMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumb
              BreadcrumbWithHeading(
                returnToPreviousScreen: true,
                heading: 'Create Brand',
                breadcrumbs: [Routes.categories, 'Create Brand'],
              ),
              SizedBox(height: AppSizes.spaceBtwSections),

              // Form
              CreateBrandForm(),
            ],
          ),
        ),
      ),
    );
  }
}
