import 'package:flutter/material.dart';

/// Widget display different layouts based on screen size
class ResponsiveLayouts extends StatelessWidget {
  const ResponsiveLayouts({
    super.key,
    required this.desktop,
    required this.tablet,
    required this.mobile,
  });

  /// Widget for desktop
  final Widget desktop;

  /// Widget for tablet
  final Widget tablet;

  /// Widget for mobile
  final Widget mobile;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        if (constraints.maxWidth < 768) {
          return mobile;
        } else if (constraints.maxWidth < 1366 && constraints.maxWidth >= 768) {
          return tablet;
        } else {
          return desktop;
        }
      },
    );
  }
}
