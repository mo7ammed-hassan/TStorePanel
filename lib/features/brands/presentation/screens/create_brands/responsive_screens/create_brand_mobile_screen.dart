import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/config/routes/routes.dart';
import 'package:t_store_admin_panel/core/shared/widgets/breadcrumb/breadcrumb_with_heading.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/features/brands/presentation/cubits/brand_cubit.dart';
import 'package:t_store_admin_panel/features/brands/presentation/screens/create_brands/responsive_screens/widgets/create_brand_form.dart';

class CreateBrandMobileScreen extends StatelessWidget {
  const CreateBrandMobileScreen({super.key, required this.brandCubit});
 final BrandCubit brandCubit;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.spaceBtwItems),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumb
              const BreadcrumbWithHeading(
                returnToPreviousScreen: true,
                heading: 'Create Brand',
                breadcrumbs: [Routes.brands, 'Create Brand'],
              ),
              const SizedBox(height: AppSizes.spaceBtwSections),

              // Form
              CreateBrandForm(brandCubit: brandCubit),
            ],
          ),
        ),
      ),
    );
  }
}
