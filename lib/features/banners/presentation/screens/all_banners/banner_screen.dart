import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store_admin_panel/config/service_locator/service_locator.dart';
import 'package:t_store_admin_panel/core/shared/widgets/layouts/templates/site_layout.dart';
import 'package:t_store_admin_panel/features/banners/cubits/banners/banner_cubit.dart';
import 'package:t_store_admin_panel/features/banners/presentation/screens/all_banners/responsive_screens/banner_desktop_screen.dart';
import 'package:t_store_admin_panel/features/banners/presentation/screens/all_banners/responsive_screens/banner_mobile_screen.dart';
import 'package:t_store_admin_panel/features/banners/presentation/screens/all_banners/responsive_screens/banner_tablet_screen.dart';

class BannerScreen extends StatelessWidget {
  const BannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<BannerCubit>()..fetchItems(),
      child: const SiteTemplate(
        desktop: BannerDesktopScreen(),
        tablet: BannerTabletScreen(),
        mobile: BannerMobileScreen(),
      ),
    );
  }
}
