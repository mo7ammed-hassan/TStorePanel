import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store_admin_panel/config/routes/routes.dart';
import 'package:t_store_admin_panel/config/service_locator/service_locator.dart';
import 'package:t_store_admin_panel/core/shared/widgets/images/circular_image.dart';
import 'package:t_store_admin_panel/core/shared/widgets/layouts/sidebars/menu/menu_item.dart';
import 'package:t_store_admin_panel/core/utils/constants/colors.dart';
import 'package:t_store_admin_panel/core/utils/constants/images.dart';
import 'package:t_store_admin_panel/core/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/core/utils/helpers/helper_functions.dart';
import 'package:t_store_admin_panel/features/authentiacation/presentation/cubit/user/cubit/user_cubit.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
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
                        route: Routes.dashboard,
                      ),
                      const MenuItem(
                        itemName: 'Media',
                        icon: Iconsax.image,
                        route: Routes.media,
                      ),
                      const MenuItem(
                        itemName: 'Categories',
                        icon: Iconsax.category,
                        route: Routes.categories,
                      ),
                      const MenuItem(
                        itemName: 'Brands',
                        icon: Iconsax.dcube,
                        route: Routes.brands,
                      ),
                      const MenuItem(
                        itemName: 'Products',
                        icon: Iconsax.shopping_bag,
                        route: Routes.products,
                      ),
                      const MenuItem(
                        itemName: 'Banners',
                        icon: Iconsax.picture_frame,
                        route: Routes.banners,
                      ),
                      const MenuItem(
                        itemName: 'Customers',
                        icon: Iconsax.profile_2user,
                        route: Routes.customers,
                      ),
                      const MenuItem(
                        itemName: 'Orders',
                        icon: Iconsax.box,
                        route: Routes.orders,
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
                        route: Routes.profile,
                      ),
                      const MenuItem(
                        itemName: 'Settings',
                        icon: Iconsax.setting_2,
                        route: Routes.settings,
                      ),

                      GestureDetector(
                        onTap: () => getIt<UserCubit>().signOut(),
                        child: const MenuItem(
                          itemName: 'Logout',
                          icon: Iconsax.logout,
                          route: Routes.login,
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
