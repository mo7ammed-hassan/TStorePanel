import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store_admin_panel/config/routes/routes.dart';
import 'package:t_store_admin_panel/core/shared/widgets/breadcrumb/breadcrumb_with_heading.dart';
import 'package:t_store_admin_panel/core/shared/widgets/containers/rounded_container.dart';
import 'package:t_store_admin_panel/core/shared/widgets/data_table/table_header.dart';
import 'package:t_store_admin_panel/core/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/core/utils/helpers/navigation.dart';
import 'package:t_store_admin_panel/features/brands/presentation/cubits/brand_cubit.dart';
import 'package:t_store_admin_panel/features/brands/presentation/screens/all_brands/table/data_table.dart';

class BrandTabletScreen extends StatelessWidget {
  const BrandTabletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.spaceBtwItems),
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
                          () => context.pushNamedPage(
                            Routes.createBrand,
                            arguments: context.read<BrandCubit>(),
                          ),
                      searchOnChanged:
                          (query) =>
                              context.read<BrandCubit>().filterData(query),
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
