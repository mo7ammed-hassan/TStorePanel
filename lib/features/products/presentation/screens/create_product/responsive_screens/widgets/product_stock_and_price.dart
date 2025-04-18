import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:t_store_admin_panel/core/shared/widgets/containers/rounded_container.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/core/utils/utils/validators/validation.dart';

class ProductStockAndPricing extends StatelessWidget {
  const ProductStockAndPricing({super.key});

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FractionallySizedBox(
              widthFactor: 0.45,
              child: TextFormField(
                validator:
                    (value) => TValidator.validateEmptyText('Stock', value),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
                  labelText: 'Stock',
                  hintText: 'Add Stock, only numbers are allowed',
                ),
              ),
            ),
            const SizedBox(height: AppSizes.spaceBtwInputFields),

            // Pricing
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    validator:
                        (value) => TValidator.validateEmptyText('Price', value),
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(r'^\d+\.?\d{0,2}'),
                      ),
                    ],
                    decoration: const InputDecoration(
                      labelText: 'Price',
                      hintText: 'Price with up-to 2 decimals',
                    ),
                  ),
                ),
                const SizedBox(width: AppSizes.spaceBtwItems),
                Expanded(
                  child: TextFormField(
                    validator:
                        (value) => TValidator.validateEmptyText('Price', value),
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: const InputDecoration(
                      labelText: 'Discounted Price',
                      hintText: 'Price with up-to 2 decimals',
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
