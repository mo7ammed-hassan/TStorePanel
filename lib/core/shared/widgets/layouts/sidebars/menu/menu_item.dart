import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store_admin_panel/core/shared/widgets/layouts/sidebars/sidebar_cubit.dart';
import 'package:t_store_admin_panel/core/shared/widgets/layouts/sidebars/sidebar_states.dart';
import 'package:t_store_admin_panel/core/utils/constants/colors.dart';
import 'package:t_store_admin_panel/core/utils/constants/enums.dart';
import 'package:t_store_admin_panel/core/utils/constants/sizes.dart';

class MenuItem extends StatelessWidget {
  const MenuItem({
    super.key,
    required this.itemName,
    required this.icon,
    required this.route,
  });
  final String itemName;
  final IconData icon;
  final SidebarRoutes route;

  @override
  Widget build(BuildContext context) {
    final menuCubit = context.read<SidebarCubit>();
    return InkWell(
      onTap: () => menuCubit.menuOnTap(context, route),
      onHover:
          (hovering) =>
              hovering
                  ? menuCubit.changeHoverItem(route)
                  : menuCubit.changeHoverItem(null),
      child: BlocBuilder<SidebarCubit, SidebarStates>(
        buildWhen: (previous, current) => current is ChangeHoverItemState,
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSizes.sm),
            child: Container(
              decoration: BoxDecoration(
                color:
                    menuCubit.isHovering(route) || menuCubit.isActive(route)
                        ? AppColors.primary
                        : Colors.transparent,
                borderRadius: BorderRadius.circular(AppSizes.cardRadiusMd),
              ),
              child: Row(
                children: [
                  //Icon
                  Padding(
                    padding: const EdgeInsets.only(
                      left: AppSizes.lg,
                      top: AppSizes.md,
                      bottom: AppSizes.md,
                      right: AppSizes.md,
                    ),
                    child:
                        menuCubit.isActive(route)
                            ? Icon(icon, size: 22, color: AppColors.white)
                            : Icon(
                              icon,
                              size: 22,
                              color:
                                  menuCubit.isHovering(route)
                                      ? AppColors.white
                                      : AppColors.darkGrey,
                            ),
                  ),

                  // Text
                  if (menuCubit.isHovering(route) || menuCubit.isActive(route))
                    Flexible(
                      // if the text is too long, it will be wrapped to multiple lines
                      child: Text(
                        itemName,
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium!.apply(color: AppColors.white),
                      ),
                    )
                  else
                    Flexible(
                      // if the text is too long, it will be wrapped to multiple lines
                      child: Text(
                        itemName,
                        style: Theme.of(context).textTheme.bodyMedium!.apply(
                          color: AppColors.darkGrey,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
