import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store_admin_panel/core/shared/widgets/containers/rounded_container.dart';
import 'package:t_store_admin_panel/core/shared/widgets/images/uploader_image.dart';
import 'package:t_store_admin_panel/core/utils/device/device_utility.dart';
import 'package:t_store_admin_panel/core/utils/constants/enums.dart';
import 'package:t_store_admin_panel/core/utils/constants/images.dart';
import 'package:t_store_admin_panel/core/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/core/utils/validators/validation.dart';
import 'package:t_store_admin_panel/data/models/category/category_model.dart';
import 'package:t_store_admin_panel/features/categories/cubits/category/category_cubit.dart';
import 'package:t_store_admin_panel/features/categories/cubits/create_category/create_category_cubit.dart';
import 'package:t_store_admin_panel/features/categories/cubits/create_category/create_category_state.dart';

class CreateCategoryForm extends StatelessWidget {
  const CreateCategoryForm({super.key, required this.categoryCubit});
  final CategoryCubit categoryCubit;

  @override
  Widget build(BuildContext context) {
    final createCategoryCubit = context.read<CreateCategoryCubit>();
    return BlocListener<CreateCategoryCubit, CreateCategoryState>(
      listener: (context, state) {
        if (state is CreateCategorySuccessState) {
          categoryCubit.addNewItem(state.category);
          createCategoryCubit.resetForm();
        }
      },
      child: RoundedContainer(
        width: DeviceUtility.isMobileScreen(context) ? double.infinity : 500,
        padding: const EdgeInsets.all(AppSizes.defaultSpace),
        child: Form(
          key: createCategoryCubit.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Heading
              const SizedBox(height: AppSizes.sm),

              Text(
                'Create New Category',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: AppSizes.spaceBtwSections),

              TextFormField(
                validator:
                    (value) => ValidatorFields.validateEmptyText('Name', value),
                controller: createCategoryCubit.nameController,
                decoration: const InputDecoration(
                  labelText: 'Category Name',
                  prefixIcon: Icon(Iconsax.category),
                ),
              ),
              const SizedBox(height: AppSizes.spaceBtwInputFields),

              DropdownButtonFormField<CategoryModel>(
                decoration: const InputDecoration(
                  labelText: 'Parent Category',
                  hintText: 'Parent Category',
                  prefixIcon: Icon(Iconsax.bezier),
                ),
                onChanged:
                    (value) => createCategoryCubit.selectedParent = value!,
                items:
                    categoryCubit.allItems
                        .map(
                          (item) => DropdownMenuItem<CategoryModel>(
                            value: item,
                            child: Row(children: [Text(item.name)]),
                          ),
                        )
                        .toList(),
              ),

              const SizedBox(height: AppSizes.spaceBtwInputFields * 2),

              UploaderImage(
                width: 80,
                height: 80,
                image:
                    createCategoryCubit.imageUrl.isNotEmpty
                        ? createCategoryCubit.imageUrl
                        : AppImages.defaultProductImage,
                imageType:
                    createCategoryCubit.imageUrl.isNotEmpty
                        ? ImageType.network
                        : ImageType.asset,
                onIconButtonPressed: () => createCategoryCubit.pickImage(),
              ),

              const SizedBox(height: AppSizes.spaceBtwInputFields),

              BlocSelector<CreateCategoryCubit, CreateCategoryState, bool>(
                selector: (state) {
                  return state is ToggleFeatured
                      ? state.isFeatured
                      : createCategoryCubit.isFeatured;
                },
                builder: (context, state) {
                  return CheckboxMenuButton(
                    value: state,
                    onChanged:
                        (value) => createCategoryCubit.toggleIsFeatured(value),
                    child: const Text('Featured'),
                  );
                },
              ),

              const SizedBox(height: AppSizes.spaceBtwInputFields * 2),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => createCategoryCubit.createCategory(),
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
