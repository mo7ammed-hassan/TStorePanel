import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store_admin_panel/core/shared/widgets/header/page_heading.dart';
import 'package:t_store_admin_panel/core/shared/widgets/layouts/sidebars/sidebar_cubit.dart';
import 'package:t_store_admin_panel/core/utils/constants/enums.dart';
import 'package:t_store_admin_panel/core/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/core/utils/helpers/navigation.dart';

/// A widget that displays a breadcrumb trail and a heading of the screen
class BreadcrumbWithHeading extends StatelessWidget {
  const BreadcrumbWithHeading({
    super.key,
    required this.heading,
    required this.breadcrumbs,
    this.returnToPreviousScreen = false,
  });

  /// The heading of the screen
  final String heading;

  /// List of breadcrumbs items representing the navigation path
  final List<String> breadcrumbs;

  /// flag to indicating whether to include a button to navigate back "Previous Screen"
  final bool returnToPreviousScreen;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Breadcrumb trail
        Row(
          children: [
            FittedBox(
              child: InkWell(
                onTap:
                    () => context.read<SidebarCubit>().menuOnTap(
                      context,
                      SidebarRoutes.dashboard,
                    ),
                child: Padding(
                  padding: const EdgeInsets.all(AppSizes.xs),
                  child: Text(
                    'Dashboard',
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall!.apply(fontWeightDelta: -1),
                  ),
                ),
              ),
            ),
            for (int i = 0; i < breadcrumbs.length; i++)
              FittedBox(
                child: Row(
                  children: [
                    const Text('/'), // Separator
                    InkWell(
                      onTap:
                          i == breadcrumbs.length - 1
                              ? null
                              : () => context.pushNamedPage(breadcrumbs[i]),

                      child: Padding(
                        padding: const EdgeInsets.all(AppSizes.xs),
                        // Format the breadcrumb item capitalize and remove leading '/'
                        child: Text(
                          i == breadcrumbs.length - 1
                              ? breadcrumbs[i].capitalize.toString()
                              : capitalize(breadcrumbs[i].substring(1)),
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall!.apply(fontWeightDelta: -1),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
        const SizedBox(height: AppSizes.sm),
        // Heading of the screen
        Row(
          children: [
            if (returnToPreviousScreen)
              IconButton(
                onPressed: () => context.popPage(context),
                icon: const Icon(Iconsax.arrow_left),
              ),
            if (returnToPreviousScreen)
              const SizedBox(width: AppSizes.spaceBtwItems),
            PageHeading(heading: heading),
          ],
        ),
      ],
    );
  }

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
}
