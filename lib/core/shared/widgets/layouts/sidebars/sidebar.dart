import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store_admin_panel/config/service_locator/service_locator.dart';
import 'package:t_store_admin_panel/core/shared/widgets/images/circular_image.dart';
import 'package:t_store_admin_panel/core/shared/widgets/layouts/sidebars/menu/menu_item.dart';
import 'package:t_store_admin_panel/core/utils/constants/colors.dart';
import 'package:t_store_admin_panel/core/utils/constants/enums.dart';
import 'package:t_store_admin_panel/core/utils/constants/images.dart';
import 'package:t_store_admin_panel/core/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/core/utils/helpers/helper_functions.dart';
import 'package:t_store_admin_panel/features/authentiacation/presentation/cubit/user/cubit/user_cubit.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    print('============================');
    print('======SideBar build========');
    print('============================');
    final isDark = HelperFunctions.isDarkMode(context);
    return Drawer(
      shape: const BeveledRectangleBorder(),
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? Colors.black : AppColors.white,
          border: Border(
            right: BorderSide(
              color: isDark ? AppColors.darkerGrey : AppColors.grey,
            ),
          ),
        ),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                CircularImage(
                  image:
                      isDark ? AppImages.lightAppLogo : AppImages.darkAppLogo,
                  width: 100,
                  height: 100,
                  backgroundColor: Colors.transparent,
                ),
                const SizedBox(height: AppSizes.spaceBtwSections),
                Padding(
                  padding: const EdgeInsets.all(AppSizes.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'MENU',
                        style: Theme.of(
                          context,
                        ).textTheme.bodySmall!.apply(letterSpacingDelta: 1.2),
                      ),

                      // MENU ITEMS
                      const MenuItem(
                        itemName: 'Dashboard',
                        icon: Iconsax.status,
                        route: SidebarRoutes.dashboard,
                      ),
                      const MenuItem(
                        itemName: 'Media',
                        icon: Iconsax.image,
                        route: SidebarRoutes.media,
                      ),
                      const MenuItem(
                        itemName: 'Categories',
                        icon: Iconsax.category,
                        route: SidebarRoutes.categories,
                      ),
                      const MenuItem(
                        itemName: 'Brands',
                        icon: Iconsax.dcube,
                        route: SidebarRoutes.brands,
                      ),
                      const MenuItem(
                        itemName: 'Products',
                        icon: Iconsax.shopping_bag,
                        route: SidebarRoutes.products,
                      ),
                      const MenuItem(
                        itemName: 'Banners',
                        icon: Iconsax.picture_frame,
                        route: SidebarRoutes.banners,
                      ),
                      const MenuItem(
                        itemName: 'Customers',
                        icon: Iconsax.profile_2user,
                        route: SidebarRoutes.customers,
                      ),
                      const MenuItem(
                        itemName: 'Orders',
                        icon: Iconsax.box,
                        route: SidebarRoutes.orders,
                      ),

                      // Other Menu Items
                      Text(
                        'OTHER',
                        style: Theme.of(
                          context,
                        ).textTheme.bodySmall!.apply(letterSpacingDelta: 1.2),
                      ),

                      const MenuItem(
                        itemName: 'Profile',
                        icon: Iconsax.user,
                        route: SidebarRoutes.profile,
                      ),
                      const MenuItem(
                        itemName: 'Settings',
                        icon: Iconsax.setting_2,
                        route: SidebarRoutes.settings,
                      ),

                      GestureDetector(
                        onTap: () => getIt<UserCubit>().signOut(),
                        child: const MenuItem(
                          itemName: 'Logout',
                          icon: Iconsax.logout,
                          route: SidebarRoutes.login,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
