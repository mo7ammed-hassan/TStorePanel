import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/config/routes/routes.dart';
import 'package:t_store_admin_panel/core/shared/widgets/breadcrumb/breadcrumb_with_heading.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/features/categories/presentation/screens/edit_category/widgets/edit_category_form.dart';

class EditCategoryTabletScreen extends StatelessWidget {
  const EditCategoryTabletScreen({super.key, required this.category});
  final String category;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumb
              const BreadcrumbWithHeading(
                returnToPreviousScreen: true,
                heading: 'Update Category',
                breadcrumbs: [Routes.categories, 'Update Category'],
              ),
              const SizedBox(height: AppSizes.spaceBtwSections),

              // Form
              EditCategoryForm(category: category),
            ],
          ),
        ),
      ),
    );
  }
}
