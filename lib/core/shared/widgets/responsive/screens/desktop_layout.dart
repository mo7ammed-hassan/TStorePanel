import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/core/shared/widgets/layouts/headers/header.dart';
import 'package:t_store_admin_panel/core/shared/widgets/layouts/sidebars/sidebar.dart';

class DesktopLayout extends StatelessWidget {
  const DesktopLayout({super.key, this.body});
  final Widget? body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const Expanded(child: Sidebar()),
          Expanded(
            flex: 5,
            child: Column(
              children: [
                // HEADER
                const Header(),

                // BODY
                Expanded(child: body ?? const SizedBox()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
