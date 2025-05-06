import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store_admin_panel/config/routes/routes.dart';
import 'package:t_store_admin_panel/core/utils/device/device_utility.dart';
import 'package:t_store_admin_panel/core/utils/helpers/navigation.dart';
import 'package:t_store_admin_panel/features/categories/presentation/screens/all_categories/category_screen.dart';
import 'package:t_store_admin_panel/features/dashboard/presentation/screens/dashboard_screen.dart';

class SidebarCubit extends Cubit<String> {
  SidebarCubit() : super(Routes.dashboard);

  String activeItem = Routes.dashboard;
  String hoverItem = '';


  void changeActiveItem(String route) {
    activeItem = route;
    emit(route);
  }

  void changeHoverItem(String route) {
    if (!isActive(route)) {
      hoverItem = route;
      emit(route);
    }
  }

  bool isActive(String route) => activeItem == route;

  bool isHovering(String route) => hoverItem == route;

  void menuOnTap(BuildContext context, String route) {
    if (!isActive(route)) {
      changeActiveItem(route);
      changeHoverItem('');

      if (DeviceUtilities.isMobileScreen(context)) context.popPage(context);
      if (DeviceUtilities.isTabletScreen(context)) context.popPage(context);

      //context.pushNamedPage(route);
      //getCurrentScreen();
    }
  }

  Widget getCurrentScreen() {
    switch (activeItem) {
      case Routes.dashboard:
        return const DashboardScreen(); // inside LayoutBuilder
      case Routes.categories:
        return const CategoryScreen();

      default:
        return const Center(child: Text('Page Not Found'));
    }
  }
}
