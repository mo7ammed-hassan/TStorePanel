import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/core/shared/widgets/layouts/sidebars/sidebar_cubit.dart';
import 'package:t_store_admin_panel/core/utils/constants/enums.dart';
import 'package:t_store_admin_panel/core/utils/extensions/sidebar_extension.dart';

class CustomRouteObserver extends NavigatorObserver {
  CustomRouteObserver(this.sidebarCubit);
  final SidebarCubit sidebarCubit;

  static final Map<String, SidebarRoutes> _routeMap = {
    for (var route in SidebarRoutes.values) route.path: route,
  };

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    _updateSidebarRoute(previousRoute);
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    _updateSidebarRoute(route);
  }

  void _updateSidebarRoute(Route? route) {
    final routeName = route?.settings.name;
    if (routeName == null) return;
    
    final sidebarRoute = _routeMap[routeName];
    if (sidebarRoute != null) {
      sidebarCubit.changeActiveItem(sidebarRoute);
    }
  }
}
