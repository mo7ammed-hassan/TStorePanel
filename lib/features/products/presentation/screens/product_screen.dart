import 'package:flutter/widgets.dart';
import 'package:t_store_admin_panel/core/shared/widgets/layouts/templates/site_layout.dart';
import 'package:t_store_admin_panel/features/products/presentation/screens/responsive_screens/product_desktop_screen.dart';
import 'package:t_store_admin_panel/features/products/presentation/screens/responsive_screens/product_mobile_screen.dart';
import 'package:t_store_admin_panel/features/products/presentation/screens/responsive_screens/product_tablet_screen.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SiteTemplate(
      desktop: ProductDesktopScreen(),
      tablet: ProductTabletScreen(),
      mobile: ProductMobileScreen(),
    );
  }
}
