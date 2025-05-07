import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/config/routes/routes.dart';
import 'package:t_store_admin_panel/core/shared/widgets/breadcrumb/breadcrumb_with_heading.dart';
import 'package:t_store_admin_panel/core/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/features/banners/cubits/banners/banner_cubit.dart';
import 'package:t_store_admin_panel/features/banners/presentation/screens/create_banners/responsive_screens/widgets/create_banner_form.dart';

class CreateBannerTabletScreen extends StatelessWidget {
  const CreateBannerTabletScreen({super.key, required this.bannerCubit});
  final BannerCubit bannerCubit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.spaceBtwItems),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumb
              const BreadcrumbWithHeading(
                returnToPreviousScreen: true,
                heading: 'Create Banner',
                breadcrumbs: [Routes.banners, 'Create Banner'],
              ),
              const SizedBox(height: AppSizes.spaceBtwSections),

              // Form
              CreateBannerForm(bannerCubit: bannerCubit),
            ],
          ),
        ),
      ),
    );
  }
}
