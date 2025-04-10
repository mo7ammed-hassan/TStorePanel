import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/config/routes/routes.dart';
import 'package:t_store_admin_panel/core/shared/widgets/breadcrumb/breadcrumb_with_heading.dart';
import 'package:t_store_admin_panel/core/shared/widgets/containers/rounded_container.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/data/models/order_model.dart';

class OrderDetailsMobileScreen extends StatelessWidget {
  const OrderDetailsMobileScreen({super.key, required this.order});
  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.spaceBtwItems),
          child: Column(
            children: [
              // Breadcrumbs
             BreadcrumbWithHeading(
                heading: '#[${order.id}]',
                breadcrumbs: const [Routes.orders, 'Details'],
                returnToPreviousScreen: true,
              ),

              const SizedBox(height: AppSizes.spaceBtwSections),

              const RoundedContainer(),
              const SizedBox(height: AppSizes.spaceBtwSections),

              // Order Items
              const RoundedContainer(),
              const SizedBox(height: AppSizes.spaceBtwSections),

              // transactions
              const RoundedContainer(),
              const SizedBox(height: AppSizes.spaceBtwSections),
              const SizedBox(width: AppSizes.spaceBtwSections),

              const RoundedContainer(),
              const SizedBox(height: AppSizes.spaceBtwSections),

              // contact person info
              const RoundedContainer(),
              const SizedBox(height: AppSizes.spaceBtwSections),

              // shipping address
              const RoundedContainer(),
              const SizedBox(height: AppSizes.spaceBtwSections),

              // billing address
              const RoundedContainer(),
              const SizedBox(height: AppSizes.spaceBtwSections),
            ],
          ),
        ),
      ),
    );
  }
}
