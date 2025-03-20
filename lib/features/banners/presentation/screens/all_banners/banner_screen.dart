import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/core/shared/widgets/layouts/templates/site_layout.dart';
import 'package:t_store_admin_panel/features/banners/presentation/screens/all_banners/responsive_screens/banner_desktop_screen.dart';
import 'package:t_store_admin_panel/features/banners/presentation/screens/all_banners/responsive_screens/banner_mobile_screen.dart';
import 'package:t_store_admin_panel/features/banners/presentation/screens/all_banners/responsive_screens/banner_tablet_screen.dart';

class BannerScreen extends StatelessWidget {
  const BannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SiteTemplate(
      desktop: BannerDesktopScreen(),
      tablet: BannerTabletScreen(),
      mobile: BannerMobileScreen(),
    );
  }
}
