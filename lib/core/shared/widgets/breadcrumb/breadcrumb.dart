import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store_admin_panel/config/routes/routes.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/core/utils/utils/helpers/navigation.dart';

class Breadcrumb extends StatelessWidget {
  const Breadcrumb({super.key, required this.breadcrumbs});
  final List<String> breadcrumbs;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () => context.pushNamedAndRemoveUntilPage(Routes.dashboard),
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
        for (int i = 0; i < breadcrumbs.length; i++)
          Row(
            children: [
              const Text('/'), // Separator
              InkWell(
                onTap:
                    () =>
                        i == breadcrumbs.length - 1
                            ? null
                            : context.pushNamedPage(breadcrumbs[i]),
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
      ],
    );
  }

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
}
