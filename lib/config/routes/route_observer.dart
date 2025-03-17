import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/config/routes/routes.dart';
import 'package:t_store_admin_panel/config/service_locator/service_locator.dart';
import 'package:t_store_admin_panel/core/shared/widgets/layouts/sidebars/sidebar_cubit.dart';

class CustomRouteObserver extends NavigatorObserver {
  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    final menuCubit = getIt<SidebarCubit>();

    if (previousRoute != null) {
      for (var routeName in Routes.sidebarMenuRoutes) {
        if (previousRoute.settings.name == routeName) {
          menuCubit.changeActiveItem(routeName);
        }
      }
    }
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    final menuCubit = getIt<SidebarCubit>();
    for (var routeName in Routes.sidebarMenuRoutes) {
      if (route.settings.name == routeName) {
        menuCubit.changeActiveItem(routeName);
      }
    }
  }
}
