import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/config/routes/routes.dart';
import 'package:t_store_admin_panel/core/shared/widgets/breadcrumb/breadcrumb_with_heading.dart' show BreadcrumbWithHeading;
import 'package:t_store_admin_panel/core/utils/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/features/categories/cubits/category/category_cubit.dart';
import 'package:t_store_admin_panel/features/categories/presentation/screens/create_category/widgets/create_category_form.dart';

class CreateCategoryMobileScreen extends StatelessWidget {
  const CreateCategoryMobileScreen({super.key, required this.categoryCubit});
  final CategoryCubit categoryCubit;

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
                heading: 'Create Category',
                breadcrumbs: [Routes.categories, 'Create Category'],
              ),
              const SizedBox(height: AppSizes.spaceBtwSections),

              // Form
              CreateCategoryForm(categoryCubit: categoryCubit),
            ],
          ),
        ),
      ),
    );
  }
}