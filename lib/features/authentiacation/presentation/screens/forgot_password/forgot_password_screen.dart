import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/core/shared/widgets/layouts/templates/site_layout.dart';
import 'package:t_store_admin_panel/features/authentiacation/presentation/screens/forgot_password/responsive_screens/forgot_password_desktop_tablet_screen.dart';
import 'package:t_store_admin_panel/features/authentiacation/presentation/screens/forgot_password/responsive_screens/forgot_password_mobile_screen.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SiteTemplate(
      useLayout: false,
      desktop: ForgotPasswordDesktopTabletScreen(),
      mobile: ForgotPasswordMobileScreen(),
    );
  }
}
