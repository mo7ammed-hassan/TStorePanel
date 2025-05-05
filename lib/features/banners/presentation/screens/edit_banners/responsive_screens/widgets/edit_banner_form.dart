import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store_admin_panel/core/shared/widgets/containers/rounded_container.dart';
import 'package:t_store_admin_panel/core/shared/widgets/images/t_rounded_image.dart';
import 'package:t_store_admin_panel/core/utils/device/device_utility.dart';
import 'package:t_store_admin_panel/core/utils/constants/app_screens.dart';
import 'package:t_store_admin_panel/core/utils/constants/colors.dart';
import 'package:t_store_admin_panel/core/utils/constants/enums.dart';
import 'package:t_store_admin_panel/core/utils/constants/images.dart';
import 'package:t_store_admin_panel/core/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/core/utils/helpers/helper_functions.dart';
import 'package:t_store_admin_panel/features/banners/cubits/banners/banner_cubit.dart';
import 'package:t_store_admin_panel/features/banners/cubits/edit_banner/edit_banner_cubit.dart';
import 'package:t_store_admin_panel/features/banners/cubits/edit_banner/edit_banner_states.dart';

class EditBannerForm extends StatelessWidget {
  const EditBannerForm({super.key, required this.bannerCubit});
  final BannerCubit bannerCubit;
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EditBannerCubit>();
    final isDark = HelperFunctions.isDarkMode(context);
    return BlocListener<EditBannerCubit, EditBannerStates>(
      listener: (context, state) {
        if (state is EditBannerSuccessState) {
          bannerCubit.editItem(state.banner);
        }
      },
      child: RoundedContainer(
        width: DeviceUtility.isMobileScreen(context) ? double.infinity : 500,
        padding: const EdgeInsets.all(AppSizes.defaultSpace),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Heading
              const SizedBox(height: AppSizes.sm),

              Text(
                'Update Banner',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: AppSizes.spaceBtwSections),

              Column(
                children: [
                  BlocBuilder<EditBannerCubit, EditBannerStates>(
                    buildWhen:
                        (previous, current) => current is SelectedImageState,
                    builder: (context, state) {
                      return TRoundedImage(
                        width: 350,
                        height: 200,

                        backgroundColor:
                            isDark
                                ? AppColors.darkerGrey
                                : AppColors.primaryBackground,
                        fit: BoxFit.cover,
                        imageType:
                            cubit.imageUrl != null && cubit.imageUrl!.isNotEmpty
                                ? ImageType.network
                                : ImageType.asset,
                        image:
                            cubit.imageUrl != null && cubit.imageUrl!.isNotEmpty
                                ? cubit.imageUrl
                                : AppImages.defaultProductImage,
                      );
                    },
                  ),
                  const SizedBox(height: AppSizes.spaceBtwItems),
                  TextButton(
                    onPressed: () => cubit.pickImage(),
                    child: const Text('Select Image'),
                  ),
                ],
              ),
              const SizedBox(height: AppSizes.spaceBtwInputFields),

              Text(
                'Make your Banner Active or Inactive',
                style: Theme.of(context).textTheme.bodyMedium,
              ),

              BlocSelector<EditBannerCubit, EditBannerStates, bool>(
                selector: (state) {
                  return state is ToggleActiveState
                      ? state.isActive
                      : cubit.active;
                },
                builder: (context, state) {
                  return CheckboxMenuButton(
                    value: cubit.active,
                    onChanged: (value) => cubit.toggleActive(value!),
                    child: const Text('Active'),
                  );
                },
              ),

              const SizedBox(height: AppSizes.spaceBtwInputFields),

              BlocSelector<EditBannerCubit, EditBannerStates, String>(
                selector: (state) {
                  return state is TargetScreenState
                      ? state.targetScreen
                      : cubit.targetScreen;
                },
                builder: (context, state) {
                  return DropdownButton(
                    value: cubit.targetScreen,
                    items:
                        AppScreens.allAppScreens
                            .map(
                              (screen) => DropdownMenuItem(
                                value: screen,
                                child: Text(screen),
                              ),
                            )
                            .toList(),
                    onChanged: (value) => cubit.setTargetScreen(value!),
                  );
                },
              ),

              const SizedBox(height: AppSizes.spaceBtwInputFields * 2),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async => await cubit.editBanner(),
                  child: const Text('Update'),
                ),
              ),

              const SizedBox(height: AppSizes.spaceBtwInputFields * 2),
            ],
          ),
        ),
      ),
    );
  }
}
