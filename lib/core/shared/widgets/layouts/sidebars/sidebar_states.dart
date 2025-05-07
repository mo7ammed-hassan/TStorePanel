import 'package:t_store_admin_panel/core/utils/constants/enums.dart';

abstract class SidebarStates {}

class SidebarInitial extends SidebarStates {}

class ChangeHoverItemState extends SidebarStates {
  final SidebarRoutes? route;
  ChangeHoverItemState(this.route);
}

class ChangeActiveItemState extends SidebarStates {
  final SidebarRoutes route;
  ChangeActiveItemState(this.route);
}