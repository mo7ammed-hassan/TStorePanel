import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/core/utils/constants/enums.dart';
import 'package:t_store_admin_panel/core/utils/constants/sizes.dart';

class ProductTypeWidget extends StatelessWidget {
  const ProductTypeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            'Product Type',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        const SizedBox(width: AppSizes.spaceBtwItems),
        Flexible(
          child: FittedBox(
            child: RadioMenuButton(
              value: ProductType.single,
              groupValue: ProductType.single,
              onChanged: (value) {},
              child: const Text('Single'),
            ),
          ),
        ),
        Flexible(
          child: FittedBox(
            child: RadioMenuButton(
              value: ProductType.variable,
              groupValue: ProductType.variable,
              onChanged: (value) {},
              child: const Text('Variable'),
            ),
          ),
        ),
      ],
    );
  }
}
