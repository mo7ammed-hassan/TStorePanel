import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/config/routes/routes.dart';
import 'package:t_store_admin_panel/core/shared/widgets/breadcrumb/breadcrumb_with_heading.dart';
import 'package:t_store_admin_panel/core/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/data/models/order_model.dart';
import 'package:t_store_admin_panel/features/order/widgets/billing_address.dart';
import 'package:t_store_admin_panel/features/order/widgets/contact_section.dart';
import 'package:t_store_admin_panel/features/order/widgets/order_customer.dart';
import 'package:t_store_admin_panel/features/order/widgets/order_info_section.dart';
import 'package:t_store_admin_panel/features/order/widgets/order_items_section.dart';
import 'package:t_store_admin_panel/features/order/widgets/shipping_address.dart';
import 'package:t_store_admin_panel/features/order/widgets/transaction_section.dart';

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

              // Order Info
              OrderInfoSection(order: order),
              const SizedBox(height: AppSizes.spaceBtwSections),

              // Order Items
              OrderItemsSection(order: order),
              const SizedBox(height: AppSizes.spaceBtwSections),

              // transactions
              TransactionSection(order: order),
              const SizedBox(height: AppSizes.spaceBtwSections),

              OrderCustomer(order: order),
              const SizedBox(height: AppSizes.spaceBtwSections),

              // contact person info
              const ContactSection(),
              const SizedBox(height: AppSizes.spaceBtwSections),

              // shipping address
              const ShippingAddress(),
              const SizedBox(height: AppSizes.spaceBtwSections),

              // billing address
              const BillingAddress(),
              const SizedBox(height: AppSizes.spaceBtwSections),
            ],
          ),
        ),
      ),
    );
  }
}
