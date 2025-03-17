import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/core/shared/widgets/layouts/templates/site_layout.dart';
import 'package:t_store_admin_panel/features/authentiacation/presentation/screens/reset_password/responsive_screens/reset_password_desktop_tablet_screen.dart';
import 'package:t_store_admin_panel/features/authentiacation/presentation/screens/reset_password/responsive_screens/reset_password_mobile_screen.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SiteTemplate(
      useLayout: false,
      desktop: ResetPasswordDesktopTabletScreen(),
      mobile: ResetPasswordMobileScreen(),
    );
  }
}