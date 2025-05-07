import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store_admin_panel/config/service_locator/service_locator.dart';
import 'package:t_store_admin_panel/core/shared/widgets/images/rounded_image.dart';
import 'package:t_store_admin_panel/core/shared/widgets/shimmer/shimmer_widget.dart';
import 'package:t_store_admin_panel/core/utils/device/device_utility.dart';
import 'package:t_store_admin_panel/core/utils/constants/colors.dart';
import 'package:t_store_admin_panel/core/utils/constants/images.dart';
import 'package:t_store_admin_panel/core/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/core/utils/helpers/helper_functions.dart';
import 'package:t_store_admin_panel/features/authentiacation/presentation/cubit/user/cubit/user_cubit.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  const Header({super.key, this.scaffoldKey});

  final GlobalKey<ScaffoldState>? scaffoldKey;
  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    final userCubit = getIt<UserCubit>();
    return BlocProvider.value(
      value: userCubit,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.md,
          vertical: AppSizes.sm,
        ),
        decoration: BoxDecoration(
          color: isDark ? Colors.black : AppColors.white,
          border: Border(
            bottom: BorderSide(
              color: isDark ? AppColors.darkerGrey : AppColors.grey,
            ),
          ),
        ),
        child: AppBar(
          automaticallyImplyLeading: false,

          /// Mobile Menu
          leading:
              !DeviceUtilities.isDesktopScreen(context)
                  ? IconButton(
                    onPressed: () => scaffoldKey?.currentState?.openDrawer(),
                    icon: const Icon(Iconsax.menu),
                  )
                  : null,

          /// Search Field
          titleSpacing: 0,
          title:
              DeviceUtilities.isDesktopScreen(context)
                  ? SizedBox(
                    width: 400,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Iconsax.search_normal),
                        hintText: 'Search anything...',
                      ),
                    ),
                  )
                  : null,

          /// Actions
          actions: [
            // Search icon on mobile
            if (!DeviceUtilities.isDesktopScreen(context))
              IconButton(
                onPressed: () {},
                icon: const Icon(Iconsax.search_normal),
              ),
            // Notification icon
            IconButton(
              onPressed: () {},
              icon: const Icon(Iconsax.notification),
            ),
            const SizedBox(width: AppSizes.spaceBtwItems / 2),

            // UserData
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BlocBuilder<UserCubit, UserState>(
                  builder: (context, state) {
                    if (state is UserLoadingState) {
                      return _buildUserLoading();
                    }
                    if (state is UserLoadedState) {
                      return RoundedImage(
                        width: 40,
                        padding: const EdgeInsets.all(2),
                        height: 40,
                        imageUrl:
                            userCubit.userData.profilePicture!.isNotEmpty
                                ? userCubit.userData.profilePicture!
                                : AppImages.user,
                        isNetworkImage:
                            userCubit.userData.profilePicture!.isNotEmpty
                                ? true
                                : false,
                      );
                    }
                    return _buildUserLoading();
                  },
                ),
                const SizedBox(width: AppSizes.sm),
                if (!DeviceUtilities.isMobileScreen(context))
                  BlocBuilder<UserCubit, UserState>(
                    builder: (context, state) {
                      if (state is UserLoadingState) {
                        return _buildLoading();
                      }
                      if (state is UserLoadedState) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              getIt<UserCubit>().userData.fullName,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            Text(
                              getIt<UserCubit>().userData.email,
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          ],
                        );
                      } else {
                        return _buildLoading();
                      }
                    },
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoading() {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShimmerWidget(width: 90, height: 13),
        SizedBox(height: AppSizes.xs),
        ShimmerWidget(width: 90, height: 13),
      ],
    );
  }

  Widget _buildUserLoading() {
    return const ShimmerAvatar(width: 40, height: 40);
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(DeviceUtilities.getAppBarHeight() + 15);
}
