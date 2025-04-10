import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/core/shared/widgets/containers/rounded_container.dart';
import 'package:t_store_admin_panel/core/shared/widgets/images/t_rounded_image.dart';
import 'package:t_store_admin_panel/core/utils/device/device_utility.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/colors.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/enums.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/images_strings.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/core/utils/utils/helpers/pricing_calculator.dart';
import 'package:t_store_admin_panel/data/models/order_model.dart';

class OrderItemsSection extends StatelessWidget {
  const OrderItemsSection({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    final subTotal = order.cartItems!.fold(
      0.0,
      (previousValue, element) =>
          previousValue + (element.price * element.quantity),
    );
    return RoundedContainer(
      padding: const EdgeInsets.all(AppSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order Information',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: AppSizes.spaceBtwSections),

          // Items
          ListView.separated(
            shrinkWrap: true,
            itemCount: order.cartItems!.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final orderItem = order.cartItems![index];
              return Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        TRoundedImage(
                          imageType:
                              orderItem.imageUrl != null
                                  ? ImageType.network
                                  : ImageType.asset,
                          image:
                              orderItem.imageUrl ?? TImages.defaultProductImage,
                        ),
                        const SizedBox(width: AppSizes.spaceBtwItems),

                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                orderItem.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),

                              if (orderItem.selectedVariation != null)
                                Text(
                                  orderItem.selectedVariation!.entries
                                      .map((e) => '${e.key}: ${e.value}')
                                      .toString(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: AppSizes.spaceBtwItems),
                  SizedBox(
                    width: AppSizes.xl * 2,
                    child: Text(
                      '\$${orderItem.price.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  SizedBox(
                    width:
                        DeviceUtility.isMobileScreen(context)
                            ? AppSizes.xl * 1.4
                            : AppSizes.xl * 2,
                    child: Text(
                      '${orderItem.quantity}',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  SizedBox(
                    width:
                        DeviceUtility.isMobileScreen(context)
                            ? AppSizes.xl * 1.4
                            : AppSizes.xl * 2,
                    child: Text(
                      '\$${orderItem.price * orderItem.quantity}',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ],
              );
            },
            separatorBuilder:
                (context, index) =>
                    const SizedBox(height: AppSizes.spaceBtwItems),
          ),
          const SizedBox(height: AppSizes.spaceBtwSections),

          // Item Total
          RoundedContainer(
            padding: const EdgeInsets.all(AppSizes.defaultSpace),
            backgroundColor: AppColors.primaryBackground,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'SubTotal',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      '\$${subTotal.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
                const SizedBox(height: AppSizes.spaceBtwItems),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Discount',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      '\$0.00',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
                const SizedBox(height: AppSizes.spaceBtwItems),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Shipping',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      '\$${TPricingCalculator.calculateShippingCost(subTotal, '')}',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
                const SizedBox(height: AppSizes.spaceBtwItems),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Tax', style: Theme.of(context).textTheme.titleLarge),
                    Text(
                      '\$${TPricingCalculator.calculateTax(subTotal, '')}',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
                const SizedBox(height: AppSizes.spaceBtwItems),
                const Divider(),
                const SizedBox(height: AppSizes.spaceBtwItems),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      '\$${TPricingCalculator.calculateTotalPrice(subTotal, '')}',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
