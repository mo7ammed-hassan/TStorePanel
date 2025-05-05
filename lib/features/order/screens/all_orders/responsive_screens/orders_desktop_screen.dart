import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/core/shared/widgets/breadcrumb/breadcrumb_with_heading.dart';
import 'package:t_store_admin_panel/core/shared/widgets/containers/rounded_container.dart';
import 'package:t_store_admin_panel/core/shared/widgets/data_table/table_header.dart';
import 'package:t_store_admin_panel/core/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/features/order/screens/all_orders/table/data_table.dart';

class OrdersDesktopScreen extends StatelessWidget {
  const OrdersDesktopScreen({super.key});

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
                heading: 'Orders',
                breadcrumbs: ['Orders'],
                // returnToPreviousScreen: true,
              ),

              SizedBox(height: AppSizes.spaceBtwSections),

              RoundedContainer(
                child: Column(
                  children: [
                    TableHeader(showLeftWidget: false),
                    SizedBox(height: AppSizes.spaceBtwItems),

                    // table
                    OrderDataTable(),
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
