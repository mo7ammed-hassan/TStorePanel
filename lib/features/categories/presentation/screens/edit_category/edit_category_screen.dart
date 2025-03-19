import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/core/shared/widgets/layouts/templates/site_layout.dart';
import 'package:t_store_admin_panel/data/models/category/category_model.dart';
import 'package:t_store_admin_panel/features/categories/presentation/screens/edit_category/responsive_screens/edit_category_desktop_screen.dart';
import 'package:t_store_admin_panel/features/categories/presentation/screens/edit_category/responsive_screens/edit_category_mobile_screen.dart';
import 'package:t_store_admin_panel/features/categories/presentation/screens/edit_category/responsive_screens/edit_category_tablet_screen.dart';

class EditCategoryScreen extends StatelessWidget {
  const EditCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final category = ModalRoute.of(context)!.settings.arguments as CategoryModel;
    return SiteTemplate(
      desktop: EditCategoryDesktopScreen(category: category),
      tablet: EditCategoryTabletScreen(category: category),
      mobile: EditCategoryMobileScreen(category: category),
    );
  }
}
