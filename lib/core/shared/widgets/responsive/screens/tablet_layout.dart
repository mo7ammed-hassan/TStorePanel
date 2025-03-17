import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/core/shared/widgets/layouts/headers/header.dart';
import 'package:t_store_admin_panel/core/shared/widgets/layouts/sidebars/sidebar.dart';

class TabletLayout extends StatelessWidget {
  TabletLayout({super.key, this.body});

  final Widget? body;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: const Sidebar(),
      appBar: Header(scaffoldKey: scaffoldKey),
      body: body ?? const SizedBox(),
    );
  }
}
