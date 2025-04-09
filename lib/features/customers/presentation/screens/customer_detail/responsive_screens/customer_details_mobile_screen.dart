import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/core/shared/widgets/breadcrumb/breadcrumb_with_heading.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/features/customers/presentation/widgets/customer_info_section.dart';
import 'package:t_store_admin_panel/features/customers/presentation/widgets/customer_order_section.dart';
import 'package:t_store_admin_panel/features/customers/presentation/widgets/shipping_address_section.dart';

class CustomerDetailsMobileScreen extends StatelessWidget {
  const CustomerDetailsMobileScreen({super.key});

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
                heading: 'Mohamed H.',
                breadcrumbs: ['Customers/Details'],
                returnToPreviousScreen: true,
              ),

              SizedBox(height: AppSizes.spaceBtwSections),
              // Customer Info Section
              CustomerInfoSection(),
              SizedBox(height: AppSizes.spaceBtwSections),

              // Shipping Address Section
              ShippingAddressSection(),
              SizedBox(height: AppSizes.spaceBtwSections),

              // Customer Order Section
              CustomerOrderSection(),
            ],
          ),
        ),
      ),
    );
  }
}
