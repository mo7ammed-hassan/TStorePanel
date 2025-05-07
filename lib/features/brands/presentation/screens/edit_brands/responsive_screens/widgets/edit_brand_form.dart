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
import 'package:t_store_admin_panel/data/models/brands/brand_model.dart';
import 'package:t_store_admin_panel/features/brands/presentation/cubits/brand_cubit.dart';
import 'package:t_store_admin_panel/features/brands/presentation/screens/edit_brands/cubit/edit_brand_cubit.dart';
import 'package:t_store_admin_panel/features/brands/presentation/screens/edit_brands/cubit/edit_brand_states.dart';

class EditBrandForm extends StatelessWidget {
  const EditBrandForm({
    super.key,
    required this.brandModel,
    required this.brandCubit,
  });
  final BrandModel brandModel;
  final BrandCubit brandCubit;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EditBrandCubit>();
    return RoundedContainer(
      width: DeviceUtilities.isMobileScreen(context) ? double.infinity : 500,
      padding: const EdgeInsets.all(AppSizes.defaultSpace),
      child: BlocListener<EditBrandCubit, EditBrandStates>(
        listener: (context, state) {
          if (state is EditBrandCompletedState) {
            brandCubit.editItem(state.brand);
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
                'Update Brand',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: AppSizes.spaceBtwSections),

              TextFormField(
                validator:
                    (value) => ValidatorFields.validateEmptyText('Name', value),
                controller: cubit.brandNameController,
                decoration: const InputDecoration(
                  labelText: 'Brand Name',
                  prefixIcon: Icon(Iconsax.box),
                ),
              ),
              const SizedBox(height: AppSizes.spaceBtwInputFields),

              Text(
                'Select Categories',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: AppSizes.spaceBtwSections),

              Wrap(
                spacing: AppSizes.sm,
                children:
                    brandCubit.categories.map((category) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: AppSizes.sm),
                        child: BlocSelector<
                          EditBrandCubit,
                          EditBrandStates,
                          bool
                        >(
                          selector: (state) {
                            return state is ToggleBrandSelectionState
                                ? cubit.selectedCategories.contains(category)
                                : cubit.selectedCategories.contains(category);
                          },
                          builder: (context, state) {
                            return TChoiceChip(
                              text: category.name,
                              isSelected: state,
                              onSelected:
                                  (select) =>
                                      cubit.toggleSelectedCategory(category),
                            );
                          },
                        ),
                      );
                    }).toList(),
              ),

              const SizedBox(height: AppSizes.spaceBtwInputFields * 2),

              UploaderImage(
                width: 80,
                height: 80,
                image: cubit.imageUrl ?? AppImages.defaultProductImage,
                imageType:
                    cubit.imageUrl != null
                        ? ImageType.network
                        : ImageType.asset,
                onIconButtonPressed: () => cubit.pickImage(),
              ),

              const SizedBox(height: AppSizes.spaceBtwInputFields),

              BlocSelector<EditBrandCubit, EditBrandStates, bool>(
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
                  onPressed: () => cubit.updateBrand(brandModel),
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
