import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store_admin_panel/core/shared/widgets/containers/rounded_container.dart';
import 'package:t_store_admin_panel/core/shared/widgets/images/uploader_image.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/enums.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/images_strings.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/core/utils/utils/validators/validation.dart';
import 'package:t_store_admin_panel/data/models/category/category_model.dart';
import 'package:t_store_admin_panel/features/categories/cubits/category/category_cubit.dart';
import 'package:t_store_admin_panel/features/categories/cubits/edit_category/edit_category_cubit.dart';
import 'package:t_store_admin_panel/features/categories/cubits/edit_category/edit_category_state.dart';

class EditCategoryForm extends StatelessWidget {
  const EditCategoryForm({
    super.key,
    this.category,
    required this.categoryCubit,
  });

  final CategoryModel? category;
  final CategoryCubit categoryCubit;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EditCategoryCubit>();
    return BlocListener<EditCategoryCubit, EditCategoryState>(
      listener: (context, state) {
        if (state is EditCategorySuccessState) {
          final index = categoryCubit.categories.indexWhere(
            (element) => element.id == category!.id,
          );

          // index != -1
          categoryCubit.categories[index] = state.category;
          categoryCubit.filteredCategories[index] = state.category;
          categoryCubit.selectedCategories[index] = false;
          categoryCubit.updateCategoriesState();
        }
      },
      child: RoundedContainer(
        width: 500,
        padding: const EdgeInsets.all(AppSizes.defaultSpace),
        child: Form(
          key: cubit.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Heading
              const SizedBox(height: AppSizes.sm),

              Text(
                'Edit Category',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: AppSizes.spaceBtwSections),

              TextFormField(
                validator:
                    (value) => TValidator.validateEmptyText('Name', value),
                decoration: const InputDecoration(
                  labelText: 'Category Name',
                  prefixIcon: Icon(Iconsax.category),
                ),
                controller: cubit.nameController,
              ),
              const SizedBox(height: AppSizes.spaceBtwInputFields),

              DropdownButtonFormField<CategoryModel>(
                decoration: const InputDecoration(
                  labelText: 'Parent Category',
                  hintText: 'Parent Category',
                  prefixIcon: Icon(Iconsax.bezier),
                ),
                onChanged: (value) => cubit.selectedParent = value!,
                items:
                    categoryCubit.categories
                        .map(
                          (item) => DropdownMenuItem(
                            value: item,
                            child: Row(children: [Text(item.name)]),
                          ),
                        )
                        .toList(),
                value:
                    cubit.selectedParent.id.isNotEmpty
                        ? cubit.selectedParent
                        : null,
              ),

              const SizedBox(height: AppSizes.spaceBtwInputFields * 2),

              UploaderImage(
                width: 80,
                height: 80,
                image: cubit.imageUrl ?? TImages.defaultProductImage,
                imageType:
                    cubit.imageUrl != null
                        ? ImageType.network
                        : ImageType.asset,
                onIconButtonPressed: () => cubit.pickImage(),
              ),

              const SizedBox(height: AppSizes.spaceBtwInputFields),

              BlocSelector<EditCategoryCubit, EditCategoryState, bool>(
                selector: (state) {
                  return state is ToggleFeatured
                      ? state.isFeatured
                      : cubit.isFeatured;
                },
                builder: (context, state) {
                  return CheckboxMenuButton(
                    value: cubit.isFeatured,
                    onChanged:
                        (value) => context
                            .read<EditCategoryCubit>()
                            .toggleIsFeatured(value),
                    child: const Text('Featured'),
                  );
                },
              ),

              const SizedBox(height: AppSizes.spaceBtwInputFields * 2),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => cubit.updateCategory(category!),
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
