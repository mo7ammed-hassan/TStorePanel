import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store_admin_panel/config/routes/routes.dart';
import 'package:t_store_admin_panel/core/shared/widgets/breadcrumb/breadcrumb_with_heading.dart';
import 'package:t_store_admin_panel/core/shared/widgets/containers/rounded_container.dart';
import 'package:t_store_admin_panel/core/shared/widgets/data_table/table_header.dart';
import 'package:t_store_admin_panel/core/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/core/utils/helpers/navigation.dart';
import 'package:t_store_admin_panel/features/banners/cubits/banners/banner_cubit.dart';
import 'package:t_store_admin_panel/features/banners/presentation/screens/all_banners/table/data_table.dart';

class BannerDesktopScreen extends StatelessWidget {
  const BannerDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.spaceBtwItems),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const BreadcrumbWithHeading(
                heading: 'Banners',
                breadcrumbs: ['Banners'],
              ),
              const SizedBox(height: AppSizes.spaceBtwSections),

              RoundedContainer(
                child: Column(
                  children: [
                    TableHeader(
                      buttonText: 'Create New Banner',
                      onPressed:
                          () => context.pushNamedPage(
                            Routes.createBanner,
                            arguments: context.read<BannerCubit>(),
                          ),
                      searchOnChanged:
                          (query) =>
                              context.read<BannerCubit>().filterData(query),
                    ),
                    const SizedBox(height: AppSizes.spaceBtwItems),

                    // table
                    const BannerDataTable(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
