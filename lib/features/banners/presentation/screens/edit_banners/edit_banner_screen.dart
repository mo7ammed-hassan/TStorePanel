import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/core/shared/widgets/layouts/templates/site_layout.dart';
import 'package:t_store_admin_panel/data/models/banners/banner_model.dart';
import 'package:t_store_admin_panel/features/banners/cubits/banners/banner_cubit.dart';
import 'package:t_store_admin_panel/features/banners/presentation/screens/edit_banners/responsive_screens/edit_banner_desktop_screen.dart';
import 'package:t_store_admin_panel/features/banners/presentation/screens/edit_banners/responsive_screens/edit_banner_mobile_screen.dart';
import 'package:t_store_admin_panel/features/banners/presentation/screens/edit_banners/responsive_screens/edit_banner_tablet_screen.dart';

class EditBannerScreen extends StatelessWidget {
  const EditBannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final banner = arguments['bannerModel'] as BannerModel;
    final bannerCubit = arguments['bannerCubit'] as BannerCubit;

    return SiteTemplate(
      desktop: EditBannerDesktopScreen(
        banner: banner,
        bannerCubit: bannerCubit,
      ),
      tablet: EditBannerTabletScreen(banner: banner, bannerCubit: bannerCubit),
      mobile: EditBannerMobileScreen(banner: banner, bannerCubit: bannerCubit),
    );
  }
}
