import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/core/shared/widgets/responsive/responsive_layouts.dart';
import 'package:t_store_admin_panel/core/shared/widgets/responsive/screens/desktop_layout.dart';
import 'package:t_store_admin_panel/core/shared/widgets/responsive/screens/mobile_layout.dart';
import 'package:t_store_admin_panel/core/shared/widgets/responsive/screens/tablet_layout.dart';

class SiteTemplate extends StatelessWidget {
  const SiteTemplate({
    super.key,
    this.desktop,
    this.tablet,
    this.mobile,
    this.useLayout = true,
    this.backgroundColor,
  });

  /// Widget for desktop
  final Widget? desktop;

  /// Widget for tablet
  final Widget? tablet;

  /// Widget for mobile
  final Widget? mobile;

  /// Flag to determine whether to use layout
  /// like when user login or signup
  final bool useLayout;

  /// Background color
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: ResponsiveLayouts(
        desktop:
            useLayout
                ? DesktopLayout(body: desktop)
                : desktop ?? const SizedBox(),
        tablet:
            useLayout
                ? TabletLayout(body: tablet ?? desktop)
                : tablet ?? desktop ?? const SizedBox(),
        mobile:
            useLayout
                ? MobileLayout(body: mobile ?? desktop)
                : mobile ?? desktop ?? const SizedBox(),
      ),
    );
  }
}
