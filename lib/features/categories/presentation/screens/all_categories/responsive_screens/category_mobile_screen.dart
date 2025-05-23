import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store_admin_panel/config/routes/routes.dart';
import 'package:t_store_admin_panel/core/shared/widgets/breadcrumb/breadcrumb_with_heading.dart';
import 'package:t_store_admin_panel/core/shared/widgets/containers/rounded_container.dart';
import 'package:t_store_admin_panel/core/shared/widgets/data_table/table_header.dart';
import 'package:t_store_admin_panel/core/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/core/utils/helpers/navigation.dart';
import 'package:t_store_admin_panel/features/categories/cubits/category/category_cubit.dart';
import 'package:t_store_admin_panel/features/categories/presentation/screens/all_categories/table/data_table.dart';

class CategoryMobileScreen extends StatelessWidget {
  const CategoryMobileScreen({super.key});

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
                heading: 'Categories',
                breadcrumbs: ['Categories'],
              ),
              const SizedBox(height: AppSizes.spaceBtwSections),

              // Table Body
              RoundedContainer(
                child: Column(
                  children: [
                    TableHeader(
                      buttonText: 'Create New Category',
                      onPressed:
                          () => context.pushNamedPage(
                            Routes.createCategory,
                            arguments: context.read<CategoryCubit>(),
                          ),
                           searchOnChanged:
                          (quary) =>
                              context.read<CategoryCubit>().filterData(quary),
                    ),
                    const SizedBox(height: AppSizes.spaceBtwItems),

                    // table
                    const CategoryDataTable(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
