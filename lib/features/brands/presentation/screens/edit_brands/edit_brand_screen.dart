import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store_admin_panel/config/service_locator/service_locator.dart';
import 'package:t_store_admin_panel/core/shared/widgets/layouts/templates/site_layout.dart';
import 'package:t_store_admin_panel/data/models/brands/brand_model.dart';
import 'package:t_store_admin_panel/features/brands/presentation/cubits/brand_cubit.dart';
import 'package:t_store_admin_panel/features/brands/presentation/screens/edit_brands/cubit/edit_brand_cubit.dart';
import 'package:t_store_admin_panel/features/brands/presentation/screens/edit_brands/responsive_screens/edit_brand_desktop_screen.dart';
import 'package:t_store_admin_panel/features/brands/presentation/screens/edit_brands/responsive_screens/edit_brand_mobile_screen.dart';
import 'package:t_store_admin_panel/features/brands/presentation/screens/edit_brands/responsive_screens/edit_brand_tablet_screen.dart';

class EditBrandScreen extends StatelessWidget {
  const EditBrandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final data =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final brandCubit = data['brandCubit'] as BrandCubit;
    final brandModel = data['brandModel'] as BrandModel;
    return BlocProvider(
      create: (context) => getIt<EditBrandCubit>()..initData(brandModel),
      child: SiteTemplate(
        desktop: EditBrandDesktopScreen(brandModel: brandModel, brandCubit: brandCubit),
        tablet: EditBrandTabletScreen(brandModel: brandModel, brandCubit: brandCubit),
        mobile: EditBrandMobileScreen(brandModel: brandModel, brandCubit: brandCubit),
      ),
    );
  }
}
