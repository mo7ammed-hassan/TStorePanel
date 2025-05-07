import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/core/shared/widgets/breadcrumb/breadcrumb_with_heading.dart';
import 'package:t_store_admin_panel/core/shared/widgets/containers/rounded_container.dart';
import 'package:t_store_admin_panel/core/shared/widgets/data_table/table_header.dart';
import 'package:t_store_admin_panel/core/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/features/customers/presentation/screens/all_customers/table/data_table.dart';

class CustomersDesktopScreen extends StatelessWidget {
  const CustomersDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppSizes.spaceBtwItems),
          child: Column(
            children: [
              // Breadcrumbs
              BreadcrumbWithHeading(
                heading: 'Customers',
                breadcrumbs: ['Customers'],
                // returnToPreviousScreen: true,
              ),

              SizedBox(height: AppSizes.spaceBtwSections),

              RoundedContainer(
                child: Column(
                  children: [
                    TableHeader(showLeftWidget: false),
                    SizedBox(height: AppSizes.spaceBtwItems),

                    // table
                    CustomerDataTable(),
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
