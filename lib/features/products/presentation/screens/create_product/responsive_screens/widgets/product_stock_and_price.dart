import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/core/shared/widgets/containers/rounded_container.dart';
import 'package:t_store_admin_panel/core/utils/device/device_utility.dart';
import 'package:t_store_admin_panel/features/products/presentation/screens/create_product/responsive_screens/widgets/product_stok_and_price/product_stok_and_price_larg_screen.dart';
import 'package:t_store_admin_panel/features/products/presentation/screens/create_product/responsive_screens/widgets/product_stok_and_price/product_stok_and_price_mobile_app.dart';

class ProductStockAndPricing extends StatelessWidget {
  const ProductStockAndPricing({super.key});

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      child: Form(
        child:
            DeviceUtilities.isMobileScreen(context)
                ? const ProductStockAndPricingMobile()
                : const ProductStockAndPricingLargScreen(),
      ),
    );
  }
}
