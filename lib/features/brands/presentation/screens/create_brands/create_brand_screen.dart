import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store_admin_panel/config/service_locator/service_locator.dart';
import 'package:t_store_admin_panel/core/shared/widgets/layouts/templates/site_layout.dart';
import 'package:t_store_admin_panel/features/brands/presentation/cubits/brand_cubit.dart';
import 'package:t_store_admin_panel/features/brands/presentation/screens/create_brands/cubits/create_brand_cubit.dart';
import 'package:t_store_admin_panel/features/brands/presentation/screens/create_brands/responsive_screens/create_brand_desktop_screen.dart';
import 'package:t_store_admin_panel/features/brands/presentation/screens/create_brands/responsive_screens/create_brand_mobile_screen.dart';
import 'package:t_store_admin_panel/features/brands/presentation/screens/create_brands/responsive_screens/create_brand_tablet_screen.dart';

class CreateBrandScreen extends StatelessWidget {
  const CreateBrandScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    final brandCubit = ModalRoute.of(context)!.settings.arguments as BrandCubit;
    return BlocProvider(
      create: (context) => getIt<CreateBrandCubit>()..fetchCategories(),
      child:  SiteTemplate(
        desktop: CreateBrandDesktopScreen(brandCubit: brandCubit),
        tablet: CreateBrandTabletScreen(brandCubit: brandCubit),
        mobile: CreateBrandMobileScreen(brandCubit: brandCubit),
      ),
    );
  }
}
