import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/core/shared/widgets/layouts/headers/header.dart';
import 'package:t_store_admin_panel/core/shared/widgets/layouts/sidebars/sidebar.dart';

class GlobalTabletLayout extends StatelessWidget {
  const GlobalTabletLayout({super.key, this.body});
  final Widget? body;

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldKey,
      drawer: const Sidebar(),
      appBar: Header(scaffoldKey: scaffoldKey),
      body: body ?? const SizedBox(),
    );
  }
}
