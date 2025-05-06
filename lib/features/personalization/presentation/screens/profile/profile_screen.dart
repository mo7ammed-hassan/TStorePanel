import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/features/personalization/presentation/screens/profile/responsive_screens/profile_desktop_screen.dart';
import 'package:t_store_admin_panel/features/personalization/presentation/screens/profile/responsive_screens/profile_mobile_screen.dart';
import 'package:t_store_admin_panel/features/personalization/presentation/screens/profile/responsive_screens/profile_tablet_screen.dart';
import 'package:t_store_admin_panel/layouts/responsive_screens.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveScreens(
      desktop: ProfileDesktopScreen(),
      tablet: ProfileTabletScreen(),
      mobile: ProfileMobileScreen(),
    );
  }
}
