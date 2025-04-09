import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/core/shared/widgets/layouts/templates/site_layout.dart';
import 'package:t_store_admin_panel/features/products/presentation/screens/create_product/responsive_screens/create_product_desktop_screen.dart';
import 'package:t_store_admin_panel/features/products/presentation/screens/create_product/responsive_screens/create_product_mobile_screen.dart';

class CreateProductScreen extends StatelessWidget {
  const CreateProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SiteTemplate(
      desktop: CreateProductDesktopScreen(),
      mobile: CreateProductMobileScreen(),
    );
  }
}
