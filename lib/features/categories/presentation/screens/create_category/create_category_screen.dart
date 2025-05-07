import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store_admin_panel/config/service_locator/service_locator.dart';
import 'package:t_store_admin_panel/core/shared/widgets/responsive/responsive_layouts.dart';
import 'package:t_store_admin_panel/features/categories/cubits/category/category_cubit.dart';
import 'package:t_store_admin_panel/features/categories/cubits/create_category/create_category_cubit.dart';
import 'package:t_store_admin_panel/features/categories/presentation/screens/create_category/responsive_screens/create_category_desktop_screen.dart';
import 'package:t_store_admin_panel/features/categories/presentation/screens/create_category/responsive_screens/create_category_mobile_screen.dart';

class CreateCategoryScreen extends StatelessWidget {
  const CreateCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryCubit =
        ModalRoute.of(context)!.settings.arguments as CategoryCubit;
    return BlocProvider(
      create: (context) => getIt<CreateCategoryCubit>(),
      child: ResponsiveLayouts(
        desktop: CreateCategoryDesktopScreen(categoryCubit: categoryCubit),
        tablet: CreateCategoryMobileScreen(categoryCubit: categoryCubit),
        mobile: CreateCategoryMobileScreen(categoryCubit: categoryCubit),
      ),
    );
  }
}
