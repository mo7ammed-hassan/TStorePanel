import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store_admin_panel/config/routes/routes.dart';
import 'package:t_store_admin_panel/core/shared/widgets/breadcrumb/breadcrumb_with_heading.dart';
import 'package:t_store_admin_panel/core/shared/widgets/containers/rounded_container.dart';
import 'package:t_store_admin_panel/core/shared/widgets/data_table/table_header.dart';
import 'package:t_store_admin_panel/core/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/core/utils/helpers/navigation.dart';
import 'package:t_store_admin_panel/features/products/cubits/cubit/product_cubit.dart';
import 'package:t_store_admin_panel/features/products/presentation/screens/all_products/table/data_table.dart';

class ProductMobileScreen extends StatelessWidget {
  const ProductMobileScreen({super.key});

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
                heading: 'Products',
                breadcrumbs: ['Products'],
              ),
              const SizedBox(height: AppSizes.spaceBtwSections),

              RoundedContainer(
                child: Column(
                  children: [
                    TableHeader(
                      buttonText: 'Add Product',
                      onPressed:
                          () => context.pushNamedPage(Routes.createProduct),
                      searchOnChanged:
                          (query) =>
                              context.read<ProductCubit>().searchQuary(query),
                    ),
                    const SizedBox(height: AppSizes.spaceBtwItems),

                    // table
                    const ProductDataTable(),
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
