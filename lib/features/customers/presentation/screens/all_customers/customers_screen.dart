import 'package:flutter/widgets.dart';
import 'package:t_store_admin_panel/core/shared/widgets/layouts/templates/site_layout.dart';
import 'package:t_store_admin_panel/features/customers/presentation/screens/all_customers/responsive_screens/customers_desktop_screen.dart';
import 'package:t_store_admin_panel/features/customers/presentation/screens/all_customers/responsive_screens/customers_mobile_screen.dart';
import 'package:t_store_admin_panel/features/customers/presentation/screens/all_customers/responsive_screens/custromer_tablet_screen.dart';

class CustomersScreen extends StatelessWidget {
  const CustomersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SiteTemplate(
      desktop: CustomersDesktopScreen(),
      tablet: CustromerTabletScreen(),
      mobile: CustomersMobileScreen(),
    );
  }
}
