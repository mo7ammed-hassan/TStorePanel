import 'package:flutter/widgets.dart';
import 'package:t_store_admin_panel/core/shared/widgets/layouts/templates/site_layout.dart';
import 'package:t_store_admin_panel/features/customers/presentation/screens/customer_detail/responsive_screens/customer_details_desktop_screen.dart';
import 'package:t_store_admin_panel/features/customers/presentation/screens/customer_detail/responsive_screens/customer_details_mobile_screen.dart';

class CustomerDetailScreen extends StatelessWidget {
  const CustomerDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final customer =
    //     ModalRoute.of(context)!.settings.arguments as CustomerModel;
    return const SiteTemplate(
      desktop: CustomerDetailsDesktopScreen(),
      mobile: CustomerDetailsMobileScreen(),
    );
  }
}
