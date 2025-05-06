import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store_admin_panel/features/dashboard/presentation/cubits/cubit/dashboard_cubit.dart';
import 'package:t_store_admin_panel/features/dashboard/presentation/screens/responsive_screen/dashboard_desktop_screen.dart';
import 'package:t_store_admin_panel/features/dashboard/presentation/screens/responsive_screen/dashboard_mobile_screen.dart';
import 'package:t_store_admin_panel/features/dashboard/presentation/screens/responsive_screen/dashboard_tablet_screen.dart';
import 'package:t_store_admin_panel/layouts/responsive_screens.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DashboardCubit(),
      child: const ResponsiveScreens(
        mobile: DashboardMobileScreen(),
        tablet: DashboardTabletScreen(),
        desktop: DashboardDesktopScreen(),
      ),
    );
  }
}



// class DashboardScreen extends StatelessWidget {
//   const DashboardScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => DashboardCubit(),
//       child: const SiteTemplate(
//         desktop: DashboardDesktopScreen(),
//         tablet: DashboardTabletScreen(),
//         mobile: DashboardMobileScreen(),
//       ),
//     );
//   }
// }