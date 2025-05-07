import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store_admin_panel/core/shared/widgets/layouts/sidebars/sidebar_cubit.dart';
import 'package:t_store_admin_panel/core/shared/widgets/layouts/sidebars/sidebar_states.dart';
import 'package:t_store_admin_panel/core/utils/constants/enums.dart';
import 'package:t_store_admin_panel/core/utils/extensions/sidebar_extension.dart';
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
      create: (context) => SidebarCubit(),
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: BlocBuilder<SidebarCubit, SidebarStates>(
          buildWhen: (previous, current) => current is ChangeActiveItemState,
          builder: (context, state) {
            final route =
                state is ChangeActiveItemState
                    ? state.route
                    : SidebarRoutes.dashboard;
            return MainGlobalResponsiveLayout(
              globalMobileLayout: GlobalMobileLayout(body: route.screen),
              globalTabletLayout: GlobalTabletLayout(body: route.screen),
              globalDesktopLayout: GlobalDesktopLayout(body: route.screen),
            );
          },
        ),
      ),
    );
  }
}
