import 'package:flutter/widgets.dart';
import 'package:t_store_admin_panel/core/shared/widgets/layouts/templates/site_layout.dart';
import 'package:t_store_admin_panel/features/order/screens/all_orders/responsive_screens/orders_desktop_screen.dart';
import 'package:t_store_admin_panel/features/order/screens/all_orders/responsive_screens/orders_mobile_screen.dart';
import 'package:t_store_admin_panel/features/order/screens/all_orders/responsive_screens/orders_tablet_screen.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SiteTemplate(
      desktop: OrdersDesktopScreen(),
      tablet: OrdersTabletScreen(),
      mobile: OrdersMobileScreen(),
    );
  }
}
