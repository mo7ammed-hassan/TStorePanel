import 'package:collection/collection.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store_admin_panel/config/routes/routes.dart';
import 'package:t_store_admin_panel/core/shared/widgets/data_table/table_action.dart';
import 'package:t_store_admin_panel/core/shared/widgets/images/t_rounded_image.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/colors.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/enums.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/images_strings.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/core/utils/utils/helpers/app_context.dart';
import 'package:t_store_admin_panel/core/utils/utils/helpers/navigation.dart';
import 'package:t_store_admin_panel/data/models/category/category_model.dart';
import 'package:t_store_admin_panel/features/categories/cubits/category/category_cubit.dart';

class CategoryRows extends DataTableSource {
  final List<CategoryModel> categories;
  final CategoryCubit categoryCubit;

  CategoryRows(this.categories, this.categoryCubit);
  @override
  DataRow? getRow(int index) {
    final category = categories[index];
    final parentCategory = categories.firstWhereOrNull(
      (element) => element.id == category.parentId,
    );

    return DataRow2(
      selected: categoryCubit.selectedCategories[index],
      onSelectChanged: (value) {
        categoryCubit.toggleSelection(index, value);
      },
      cells: [
        DataCell(
          Row(
            children: [
              TRoundedImage(
                image: category.image ?? TImages.defaultProductImage,
                width: 50,
                height: 50,
                imageType:
                    category.image != null
                        ? ImageType.network
                        : ImageType.asset,
                borderRadius: AppSizes.borderRadiusMd,
                backgroundColor: AppColors.primaryBackground,
              ),
              const SizedBox(width: AppSizes.spaceBtwItems),
              Flexible(
                child: Text(
                  category.name,
                  style: Theme.of(
                    AppContext.context,
                  ).textTheme.bodyLarge!.apply(color: AppColors.primary),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        DataCell(Text(parentCategory != null ? parentCategory.name : '')),
        DataCell(
          category.isFeatured!
              ? const Icon(Iconsax.heart5, color: AppColors.primary)
              : const Icon(Iconsax.heart, color: Colors.grey),
        ),
        DataCell(
          Text(
            category.formattedCreatedAt!.isEmpty
                ? DateTime.now().toString()
                : category.formattedCreatedAt!,
          ),
        ),
        DataCell(
          TTableActionButtons(
            onEditPressed:
                () => AppContext.context.pushNamedPage(
                  Routes.editCategory,
                  arguments: category,
                ),
            onDeletePressed:
                () => categoryCubit.showDeleteConfirmationDialog(category),
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => categories.length;

  @override
  int get selectedRowCount => categoryCubit.selectedCategories.length;
}
