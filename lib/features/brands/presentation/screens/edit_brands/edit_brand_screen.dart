import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/core/shared/widgets/layouts/templates/site_layout.dart';
import 'package:t_store_admin_panel/features/brands/presentation/screens/edit_brands/responsive_screens/edit_brand_desktop_screen.dart';
import 'package:t_store_admin_panel/features/brands/presentation/screens/edit_brands/responsive_screens/edit_brand_mobile_screen.dart';
import 'package:t_store_admin_panel/features/brands/presentation/screens/edit_brands/responsive_screens/edit_brand_tablet_screen.dart';

class EditBrandScreen extends StatelessWidget {
  const EditBrandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SiteTemplate(
      desktop: EditBrandDesktopScreen(),
      tablet: EditBrandTabletScreen(),
      mobile: EditBrandMobileScreen(),
    );
  }
}
