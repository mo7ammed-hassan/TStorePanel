import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/core/shared/widgets/layouts/templates/site_layout.dart';
import 'package:t_store_admin_panel/features/banners/presentation/screens/edit_banners/responsive_screens/edit_banner_desktop_screen.dart';
import 'package:t_store_admin_panel/features/banners/presentation/screens/edit_banners/responsive_screens/edit_banner_mobile_screen.dart';
import 'package:t_store_admin_panel/features/banners/presentation/screens/edit_banners/responsive_screens/edit_banner_tablet_screen.dart';

class EditBannerScreen extends StatelessWidget {
  const EditBannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SiteTemplate(
      desktop: EditBannerDesktopScreen(),
      tablet: EditBannerTabletScreen(),
      mobile: EditBannerMobileScreen(),
    );
  }
}
