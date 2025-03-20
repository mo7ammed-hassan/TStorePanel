import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/core/shared/widgets/layouts/templates/site_layout.dart';
import 'package:t_store_admin_panel/features/brands/presentation/screens/all_brands/responsive_screens/brand_desktop_screen.dart';
import 'package:t_store_admin_panel/features/brands/presentation/screens/all_brands/responsive_screens/brand_mobile_screen.dart';
import 'package:t_store_admin_panel/features/brands/presentation/screens/all_brands/responsive_screens/brand_tablet_screen.dart';

class BrandScreen extends StatelessWidget {
  const BrandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SiteTemplate(
      desktop: BrandDesktopScreen(),
      tablet: BrandTabletScreen(),
      mobile: BrandMobileScreen(),
    );
  }
}
