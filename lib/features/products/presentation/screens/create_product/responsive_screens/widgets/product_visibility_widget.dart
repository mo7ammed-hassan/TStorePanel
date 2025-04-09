import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/core/shared/widgets/containers/rounded_container.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/enums.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/sizes.dart';

class ProductVisibilityWidget extends StatelessWidget {
  const ProductVisibilityWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Visibility', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: AppSizes.spaceBtwItems),

          // Radio buttons for visibility options
          Column(
            children: [
              _buildVisibilityRadioButton(
                ProductVisibility.pubblished,
                'Published',
              ),
              _buildVisibilityRadioButton(ProductVisibility.hidden, 'Hidden'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildVisibilityRadioButton(ProductVisibility value, String label) {
    return RadioMenuButton<ProductVisibility>(
      value: value,
      groupValue: ProductVisibility.pubblished,
      onChanged: (value) {},
      child: Text(label),
    );
  }
}
