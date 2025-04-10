import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/core/shared/widgets/layouts/templates/site_layout.dart';
import 'package:t_store_admin_panel/features/personalization/presentation/screens/settings/responsive_screens/settings_desktop_screen.dart';
import 'package:t_store_admin_panel/features/personalization/presentation/screens/settings/responsive_screens/settings_mobile_screen.dart';
import 'package:t_store_admin_panel/features/personalization/presentation/screens/settings/responsive_screens/settings_tablet_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SiteTemplate(
      desktop: SettingsDesktopScreen(),
      tablet: SettingsTabletScreen(),
      mobile: SettingsMobileScreen(),
    );
  }
}
