import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/config/routes/routes.dart';
import 'package:t_store_admin_panel/core/shared/widgets/breadcrumb/breadcrumb_with_heading.dart';
import 'package:t_store_admin_panel/core/shared/widgets/containers/rounded_container.dart';
import 'package:t_store_admin_panel/core/shared/widgets/data_table/table_header.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/core/utils/utils/helpers/navigation.dart';
import 'package:t_store_admin_panel/features/banners/presentation/screens/all_brands/table/data_table.dart';

class BrandTabletScreen extends StatelessWidget {
  const BrandTabletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const BreadcrumbWithHeading(
                heading: 'Brands',
                breadcrumbs: ['Brands'],
              ),
              const SizedBox(height: AppSizes.spaceBtwSections),

              RoundedContainer(
                child: Column(
                  children: [
                    TableHeader(
                      buttonText: 'Create New Brand',
                      onPressed:
                          () => context.pushNamedPage(Routes.createBrand),
                    ),
                    const SizedBox(height: AppSizes.spaceBtwItems),

                    // table
                    const BrandDataTable(),
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
