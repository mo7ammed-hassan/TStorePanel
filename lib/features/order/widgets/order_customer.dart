// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/core/shared/widgets/containers/rounded_container.dart';
import 'package:t_store_admin_panel/core/shared/widgets/images/t_rounded_image.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/colors.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/enums.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/images_strings.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/data/models/order_model.dart';

class OrderCustomer extends StatelessWidget {
  const OrderCustomer({super.key, required this.order});
  final OrderModel order;
  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      padding: const EdgeInsets.all(AppSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Customer', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: AppSizes.spaceBtwSections),

          Row(
            children: [
              const TRoundedImage(
                padding: 0,
                backgroundColor: AppColors.primaryBackground,
                imageType: ImageType.asset,
                image: TImages.user,
              ),
              const SizedBox(height: AppSizes.spaceBtwItems),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Mohamed H.',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const Text(
                      'mohamedh7h@gmail.com',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
