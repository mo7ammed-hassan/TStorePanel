import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/core/shared/widgets/layouts/templates/site_layout.dart';
import 'package:t_store_admin_panel/features/banners/presentation/screens/create_banners/responsive_screens/create_banner_desktop_screen.dart';
import 'package:t_store_admin_panel/features/banners/presentation/screens/create_banners/responsive_screens/create_brand_mobile_screen.dart';
import 'package:t_store_admin_panel/features/banners/presentation/screens/create_banners/responsive_screens/create_banner_tablet_screen.dart';

class CreateBannerScreen extends StatelessWidget {
  const CreateBannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SiteTemplate(
      desktop: CreateBannerDesktopScreen(),
      tablet: CreateBannerTabletScreen(),
      mobile: CreateBannerMobileScreen(),
    );
  }
}
