import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/config/routes/routes.dart';
import 'package:t_store_admin_panel/core/shared/widgets/breadcrumb/breadcrumb_with_heading.dart';
import 'package:t_store_admin_panel/core/shared/widgets/containers/rounded_container.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/data/models/order_model.dart';

class OrderDetailsDesktopScreen extends StatelessWidget {
  const OrderDetailsDesktopScreen({super.key, required this.order});
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

              const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        // Order Info
                        RoundedContainer(),
                        SizedBox(height: AppSizes.spaceBtwSections),

                        // Order Items
                        RoundedContainer(),
                        SizedBox(height: AppSizes.spaceBtwSections),

                        // transactions
                        RoundedContainer(),
                      ],
                    ),
                  ),
                  SizedBox(width: AppSizes.spaceBtwSections),
                  Expanded(
                    child: Column(
                      children: [
                        // customer info
                        RoundedContainer(),
                        SizedBox(height: AppSizes.spaceBtwSections),

                        // contact person info
                        RoundedContainer(),
                        SizedBox(height: AppSizes.spaceBtwSections),

                        // shipping address
                        RoundedContainer(),
                        SizedBox(height: AppSizes.spaceBtwSections),

                        // billing address
                        RoundedContainer(),
                        SizedBox(height: AppSizes.spaceBtwSections),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
