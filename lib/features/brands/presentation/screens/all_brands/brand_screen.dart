import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store_admin_panel/config/service_locator/service_locator.dart';
import 'package:t_store_admin_panel/features/brands/presentation/cubits/brand_cubit.dart';
import 'package:t_store_admin_panel/features/brands/presentation/screens/all_brands/responsive_screens/brand_desktop_screen.dart';
import 'package:t_store_admin_panel/features/brands/presentation/screens/all_brands/responsive_screens/brand_mobile_screen.dart';
import 'package:t_store_admin_panel/features/brands/presentation/screens/all_brands/responsive_screens/brand_tablet_screen.dart';
import 'package:t_store_admin_panel/core/shared/widgets/layouts/templates/site_layout.dart';

class BrandScreen extends StatelessWidget {
  const BrandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<BrandCubit>()..fetcCategories(),
      child: const SiteTemplate(
        desktop: BrandDesktopScreen(),
        tablet: BrandTabletScreen(),
        mobile: BrandMobileScreen(),
      ),
    );
  }
}
