import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store_admin_panel/core/shared/widgets/layouts/templates/site_layout.dart';
import 'package:t_store_admin_panel/features/categories/cubits/cubit/category_cubit.dart';
import 'package:t_store_admin_panel/features/categories/presentation/screens/all_categories/responsive_screens/category_desktop_screen.dart';
import 'package:t_store_admin_panel/features/categories/presentation/screens/all_categories/responsive_screens/category_mobile_screen.dart';
import 'package:t_store_admin_panel/features/categories/presentation/screens/all_categories/responsive_screens/category_tablet_screen.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoryCubit(),
      child: const SiteTemplate(
        desktop: CategoryDesktopScreen(),
        mobile: CategoryMobileScreen(),
        tablet: CategoryTabletScreen(),
      ),
    );
  }
}
