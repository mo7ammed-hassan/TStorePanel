import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/core/utils/device/device_utility.dart';

class MainGlobalResponsiveLayout extends StatelessWidget {
  const MainGlobalResponsiveLayout({
    super.key,
    required this.globalMobileLayout,
    required this.globalTabletLayout,
    required this.globalDesktopLayout,
  });

  final Widget globalMobileLayout;
  final Widget globalTabletLayout;
  final Widget globalDesktopLayout;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        if (constraints.maxWidth < DeviceUtilities.tablet) {
          return globalMobileLayout;
        } else if (constraints.maxWidth < DeviceUtilities.desktop &&
            constraints.maxWidth >= DeviceUtilities.tablet) {
          return globalTabletLayout;
        } else {
          return globalDesktopLayout;
        }
      },
    );
  }
}
