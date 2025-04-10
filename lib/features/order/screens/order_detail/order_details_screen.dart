import 'package:flutter/widgets.dart';
import 'package:t_store_admin_panel/core/shared/widgets/layouts/templates/site_layout.dart';
import 'package:t_store_admin_panel/data/models/order_model.dart';
import 'package:t_store_admin_panel/features/order/screens/order_detail/responsive_screens/order_details_desktop_screen.dart';
import 'package:t_store_admin_panel/features/order/screens/order_detail/responsive_screens/order_details_mobile_screen.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final order = ModalRoute.of(context)!.settings.arguments as OrderModel;
    return SiteTemplate(
      desktop: OrderDetailsDesktopScreen(order: order),
      mobile: OrderDetailsMobileScreen(order: order),
    );
  }
}
