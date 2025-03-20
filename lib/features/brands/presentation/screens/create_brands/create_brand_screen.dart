import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/core/shared/widgets/layouts/templates/site_layout.dart';
import 'package:t_store_admin_panel/features/brands/presentation/screens/create_brands/responsive_screens/create_brand_desktop_screen.dart';
import 'package:t_store_admin_panel/features/brands/presentation/screens/create_brands/responsive_screens/create_brand_mobile_screen.dart';
import 'package:t_store_admin_panel/features/brands/presentation/screens/create_brands/responsive_screens/create_brand_tablet_screen.dart';

class CreateBrandScreen extends StatelessWidget {
  const CreateBrandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SiteTemplate(
      desktop: CreateBrandDesktopScreen(),
      tablet: CreateBrandTabletScreen(),
      mobile: CreateBrandMobileScreen(),
    );
  }
}
