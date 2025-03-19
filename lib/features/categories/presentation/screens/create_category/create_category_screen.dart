import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/core/shared/widgets/layouts/templates/site_layout.dart';
import 'package:t_store_admin_panel/features/categories/presentation/screens/create_category/responsive_screens/create_category_desktop_screen.dart';
import 'package:t_store_admin_panel/features/categories/presentation/screens/create_category/responsive_screens/create_category_mobile_screen.dart';

class CreateCategoryScreen extends StatelessWidget {
  const CreateCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SiteTemplate(
      desktop: CreateCategoryDesktopScreen(),
      tablet: CreateCategoryMobileScreen(),
      mobile: CreateCategoryMobileScreen(),
    );
  }
}
