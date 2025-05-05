import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store_admin_panel/core/shared/widgets/chip/choice_chip.dart';
import 'package:t_store_admin_panel/core/shared/widgets/containers/rounded_container.dart';
import 'package:t_store_admin_panel/core/shared/widgets/images/uploader_image.dart';
import 'package:t_store_admin_panel/core/utils/device/device_utility.dart';
import 'package:t_store_admin_panel/core/utils/constants/enums.dart';
import 'package:t_store_admin_panel/core/utils/constants/images.dart';
import 'package:t_store_admin_panel/core/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/core/utils/validators/validation.dart';
import 'package:t_store_admin_panel/features/brands/presentation/cubits/brand_cubit.dart';
import 'package:t_store_admin_panel/features/brands/presentation/screens/create_brands/cubits/create_brand_cubit.dart';
import 'package:t_store_admin_panel/features/brands/presentation/screens/create_brands/cubits/create_brand_states.dart';

class CreateBrandForm extends StatelessWidget {
  const CreateBrandForm({super.key, required this.brandCubit});
  final BrandCubit brandCubit;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CreateBrandCubit>();
    return RoundedContainer(
      width: DeviceUtility.isMobileScreen(context) ? double.infinity : 500,
      padding: const EdgeInsets.all(AppSizes.defaultSpace),
      child: BlocListener<CreateBrandCubit, CreateBrandStates>(
        listener: (context, state) {
          if (state is CreateBrandSuccessState) {
            brandCubit.addNewItem(state.brand);
            cubit.resetForm();
          }
        },
        child: Form(
          key: cubit.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Heading
              const SizedBox(height: AppSizes.sm),

              Text(
                'Create New Brand',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: AppSizes.spaceBtwSections),

              TextFormField(
                controller: cubit.brandNameController,
                validator:
                    (value) => ValidatorFields.validateEmptyText('Name', value),
                decoration: const InputDecoration(
                  labelText: 'Brand Name',
                  prefixIcon: Icon(Iconsax.box),
                ),
              ),
              const SizedBox(height: AppSizes.spaceBtwInputFields),

              Text(
                'Select Categories',
                style: Theme.of(context).textTheme.headlineSmall,
              ),

              const SizedBox(height: AppSizes.spaceBtwInputFields / 2),

              Wrap(
                spacing: AppSizes.sm,
                children:
                    brandCubit.categories
                        .map(
                          (category) => Padding(
                            padding: const EdgeInsets.only(bottom: AppSizes.sm),
                            child: BlocSelector<
                              CreateBrandCubit,
                              CreateBrandStates,
                              bool
                            >(
                              selector: (state) {
                                return state is ToggleCategorySelectionState
                                    ? cubit.selectedBrandCategories.contains(
                                      category,
                                    )
                                    : cubit.selectedBrandCategories.contains(
                                      category,
                                    );
                              },
                              builder: (context, state) {
                                return TChoiceChip(
                                  text: category.name,
                                  isSelected: cubit.selectedBrandCategories
                                      .contains(category),
                                  onSelected:
                                      (select) => cubit.toggleCategorySelection(
                                        category,
                                      ),
                                );
                              },
                            ),
                          ),
                        )
                        .toList(),
              ),

              const SizedBox(height: AppSizes.spaceBtwInputFields * 2),

              UploaderImage(
                width: 80,
                height: 80,
                image:
                    cubit.imageUrl != null && cubit.imageUrl!.isNotEmpty
                        ? cubit.imageUrl
                        : AppImages.defaultProductImage,
                imageType:
                    cubit.imageUrl != null && cubit.imageUrl!.isNotEmpty
                        ? ImageType.network
                        : ImageType.asset,
                onIconButtonPressed: () => cubit.pickImage(),
              ),

              const SizedBox(height: AppSizes.spaceBtwInputFields),

              BlocSelector<CreateBrandCubit, CreateBrandStates, bool>(
                selector: (state) {
                  return state is ToggleFeatured
                      ? state.isFeatured
                      : cubit.isFeatured;
                },
                builder: (context, state) {
                  return CheckboxMenuButton(
                    value: cubit.isFeatured,
                    onChanged: (value) => cubit.toggleIsFeatured(value),
                    child: const Text('Featured'),
                  );
                },
              ),

              const SizedBox(height: AppSizes.spaceBtwInputFields * 2),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => cubit.createBrand(),
                  child: const Text('Create'),
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
