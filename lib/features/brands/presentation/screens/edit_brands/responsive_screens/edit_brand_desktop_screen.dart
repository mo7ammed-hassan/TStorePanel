import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/config/routes/routes.dart';
import 'package:t_store_admin_panel/core/shared/widgets/breadcrumb/breadcrumb_with_heading.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/data/models/brands/brand_model.dart';
import 'package:t_store_admin_panel/features/brands/presentation/cubits/brand_cubit.dart';
import 'package:t_store_admin_panel/features/brands/presentation/screens/edit_brands/responsive_screens/widgets/edit_brand_form.dart';

class EditBrandDesktopScreen extends StatelessWidget {
  const EditBrandDesktopScreen({super.key, required this.brandModel, required this.brandCubit});
  final BrandModel brandModel;
  final BrandCubit brandCubit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.spaceBtwItems),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumb
              const BreadcrumbWithHeading(
                returnToPreviousScreen: true,
                heading: 'Update Brand',
                breadcrumbs: [Routes.brands, 'Update Brand'],
              ),
              const SizedBox(height: AppSizes.spaceBtwSections),

              // Form
              EditBrandForm(brandModel: brandModel, brandCubit: brandCubit),
            ],
          ),
        ),
      ),
    );
  }
}
