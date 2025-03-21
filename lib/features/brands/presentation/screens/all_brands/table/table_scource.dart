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

class BrandRows extends DataTableSource {
  @override
  DataRow? getRow(int index) {
    return DataRow2(
      cells: [
        DataCell(
          Row(
            children: [
              const TRoundedImage(
                image: TImages.adidasLogo,
                width: 50,
                height: 50,
                imageType: ImageType.asset,
                borderRadius: AppSizes.borderRadiusMd,
                backgroundColor: AppColors.primaryBackground,
              ),
              const SizedBox(width: AppSizes.spaceBtwItems),
              Flexible(
                child: Text(
                  'Adidas',
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
        const DataCell(Icon(Iconsax.heart5, color: AppColors.primary)),
        DataCell(Text(DateTime.now().toString())),
        DataCell(
          TTableActionButtons(
            onEditPressed:
                () => AppContext.context.pushNamedPage(
                  Routes.editBrand,
                  //arguments: 'Brand',
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
  int get rowCount => 20;

  @override
  int get selectedRowCount => 0;
}
