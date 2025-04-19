import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/config/routes/routes.dart';
import 'package:t_store_admin_panel/core/shared/widgets/breadcrumb/breadcrumb_with_heading.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/data/models/banners/banner_model.dart';
import 'package:t_store_admin_panel/features/banners/cubits/banners/banner_cubit.dart';
import 'package:t_store_admin_panel/features/banners/presentation/screens/edit_banners/responsive_screens/widgets/edit_banner_form.dart';

class EditBannerTabletScreen extends StatelessWidget {
  const EditBannerTabletScreen({
    super.key,
    required this.bannerCubit,
    required this.banner,
  });

  final BannerCubit bannerCubit;
  final BannerModel banner;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppSizes.spaceBtwItems),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumb
              BreadcrumbWithHeading(
                returnToPreviousScreen: true,
                heading: 'Update Banner',
                breadcrumbs: [Routes.banners, 'Update Banner'],
              ),
              SizedBox(height: AppSizes.spaceBtwSections),

              // Form
              EditBannerForm(),
            ],
          ),
        ),
      ),
    );
  }
}
