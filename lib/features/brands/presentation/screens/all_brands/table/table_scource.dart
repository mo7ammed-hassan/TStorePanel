import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store_admin_panel/config/routes/routes.dart';
import 'package:t_store_admin_panel/core/shared/widgets/data_table/table_action.dart';
import 'package:t_store_admin_panel/core/shared/widgets/images/t_rounded_image.dart';
import 'package:t_store_admin_panel/core/utils/device/device_utility.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/colors.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/enums.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/images_strings.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/core/utils/utils/helpers/app_context.dart';
import 'package:t_store_admin_panel/core/utils/utils/helpers/navigation.dart';
import 'package:t_store_admin_panel/data/models/brands/brand_model.dart';
import 'package:t_store_admin_panel/features/brands/presentation/cubits/brand_cubit.dart';

class BrandRows extends DataTableSource {
  final List<BrandModel> brands;
  final BrandCubit brandCubit;
  BrandRows(this.brands, this.brandCubit);
  @override
  DataRow? getRow(int index) {
    if (index >= brands.length) return null;
    final BrandModel brand = brands[index];
    return DataRow2(
      selected: brandCubit.selectedItems[index],
      onSelectChanged: (value) => brandCubit.toggleSelection(index, value!),
      cells: [
        DataCell(
          Row(
            children: [
              TRoundedImage(
                image: brand.image ?? TImages.defaultProductImage,
                width: 50,
                height: 50,
                imageType: ImageType.asset,
                //brand.image != null ? ImageType.network : ImageType.asset,
                borderRadius: AppSizes.borderRadiusMd,
                backgroundColor: AppColors.primaryBackground,
              ),
              const SizedBox(width: AppSizes.spaceBtwItems),
              Flexible(
                child: Text(
                  brand.name,
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
        DataCell(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSizes.sm),
            child: SingleChildScrollView(
              child: Wrap(
                spacing: AppSizes.xs,
                direction:
                    DeviceUtility.isMobileScreen(AppContext.context)
                        ? Axis.vertical
                        : Axis.horizontal,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      bottom:
                          DeviceUtility.isMobileScreen(AppContext.context)
                              ? 0
                              : AppSizes.xs,
                    ),

                    child: const Chip(
                      label: Text('Shoes'),
                      padding: EdgeInsets.all(AppSizes.xs),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom:
                          DeviceUtility.isMobileScreen(AppContext.context)
                              ? 0
                              : AppSizes.xs,
                    ),

                    child: const Chip(
                      label: Text('tracksuits'),
                      padding: EdgeInsets.all(AppSizes.xs),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom:
                          DeviceUtility.isMobileScreen(AppContext.context)
                              ? 0
                              : AppSizes.xs,
                    ),

                    child: const Chip(
                      label: Text('joggers'),
                      padding: EdgeInsets.all(AppSizes.xs),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        DataCell(
          brand.isFeatured ?? false
              ? const Icon(Iconsax.heart5, color: AppColors.primary)
              : const Icon(Iconsax.heart, color: Colors.grey),
        ),
        DataCell(Text(brand.formattedCreatedAt ?? '')),
        DataCell(
          TTableActionButtons(
            onEditPressed:
                () => AppContext.context.pushNamedPage(
                  Routes.editBrand,
                  arguments: brand,
                ),
            onDeletePressed: () {},
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => brands.length;

  @override
  int get selectedRowCount =>
      brandCubit.selectedItems.where((e) => e == true).length;
}
