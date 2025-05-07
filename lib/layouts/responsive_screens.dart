import 'package:flutter/material.dart';

class ResponsiveScreens extends StatelessWidget {
  const ResponsiveScreens({
    super.key,
    required this.desktop,
    this.tablet,
    this.mobile,
  });

  final Widget? desktop;
  final Widget? tablet;
  final Widget? mobile;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 768) {
          return mobile ?? desktop ?? const SizedBox();
        } else if (constraints.maxWidth < 1366 && constraints.maxWidth >= 768) {
          return tablet ?? desktop ?? const SizedBox();
        } else {
          return desktop ?? const SizedBox();
        }
      },
    );
  }
}
