import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store_admin_panel/config/service_locator/service_locator.dart';
import 'package:t_store_admin_panel/core/shared/widgets/layouts/sidebars/sidebar_cubit.dart';
import 'package:t_store_admin_panel/layouts/responsive_layouts/global_desktop_layout.dart';
import 'package:t_store_admin_panel/layouts/responsive_layouts/global_mobile_layout.dart';
import 'package:t_store_admin_panel/layouts/responsive_layouts/global_tablet_layout.dart';
import 'package:t_store_admin_panel/layouts/main_global_responsive_layout.dart';

class AdminLayout extends StatelessWidget {
  const AdminLayout({super.key, this.backgroundColor});
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SidebarCubit>(),
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: BlocBuilder<SidebarCubit, String>(
          builder: (context, state) {
            final screen = context.read<SidebarCubit>().getCurrentScreen();
            return MainGlobalResponsiveLayout(
              globalMobileLayout: GlobalMobileLayout(body: screen),
              globalTabletLayout: GlobalTabletLayout(body: screen),
              globalDesktopLayout: GlobalDesktopLayout(body: screen),
            );
          },
        ),
      ),
    );
  }
}
