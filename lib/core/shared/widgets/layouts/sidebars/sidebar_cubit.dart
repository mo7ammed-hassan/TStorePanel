import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store_admin_panel/core/shared/widgets/layouts/sidebars/sidebar_states.dart';
import 'package:t_store_admin_panel/core/utils/constants/enums.dart';
import 'package:t_store_admin_panel/core/utils/device/device_utility.dart';
import 'package:t_store_admin_panel/core/utils/extensions/sidebar_extension.dart';
import 'package:t_store_admin_panel/core/utils/helpers/navigation.dart';

class SidebarCubit extends Cubit<SidebarStates> {
  SidebarCubit() : super(SidebarInitial());

  SidebarRoutes activeItem = SidebarRoutes.dashboard;
  SidebarRoutes? hoverItem;

  void changeActiveItem(SidebarRoutes route) {
    if (activeItem != route) {
      activeItem = route;
      emit(ChangeActiveItemState(route));
    }
  }

  void changeHoverItem(SidebarRoutes? route) {
    if (route != null && hoverItem != route && !isActive(route)) {
      hoverItem = route;
      emit(ChangeHoverItemState(route));
    } else {
      hoverItem = null;
      emit(ChangeHoverItemState(null));
    }
  }

  bool isActive(SidebarRoutes route) => activeItem == route;

  bool isHovering(SidebarRoutes route) => hoverItem == route;

  void menuOnTap(BuildContext context, SidebarRoutes route) {
    if (route == SidebarRoutes.login) {
      context.pushNamedAndRemoveUntilPage(route.path);
      return;
    }

    if (!isActive(route)) {
      changeActiveItem(route);
      changeHoverItem(null);

      if (DeviceUtilities.isMobileScreen(context) ||
          DeviceUtilities.isTabletScreen(context)) {
        context.popPage(context);
      }

      context.pushNamedPage(route.path);
    }
  }

  /// extension to return screen depend on route that passed from sidebar
  Widget getCurrentScreen() => activeItem.screen;
}
