import 'package:flutter/widgets.dart';
import 'package:t_store_admin_panel/core/shared/widgets/layouts/templates/site_layout.dart';
import 'package:t_store_admin_panel/features/products/presentation/screens/edit_product/responsive_screens/edit_product_desktop_screen.dart';
import 'package:t_store_admin_panel/features/products/presentation/screens/edit_product/responsive_screens/edit_product_mobile_screen.dart';

class EditProductScreen extends StatelessWidget {
  const EditProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SiteTemplate(
      desktop: EditProductDesktopScreen(),
      mobile: EditProductMobileScreen(),
    );
  }
}
