import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/config/routes/routes.dart';
import 'package:t_store_admin_panel/core/shared/widgets/breadcrumb/breadcrumb_with_heading.dart'
    show BreadcrumbWithHeading;
import 'package:t_store_admin_panel/core/utils/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/features/categories/presentation/screens/create_category/widgets/create_category_form.dart';

class CreateCategoryTabletScreen extends StatelessWidget {
  const CreateCategoryTabletScreen({super.key});

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
                heading: 'Create Category',
                breadcrumbs: [Routes.categories, 'Create Category'],
              ),
              SizedBox(height: AppSizes.spaceBtwSections),

              // Form
              CreateCategoryForm(),
            ],
          ),
        ),
      ),
    );
  }
}
