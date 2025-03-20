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

class CategoryRows extends DataTableSource {
  @override
  DataRow? getRow(int index) {
    return DataRow2(
      cells: [
        DataCell(
          Row(
            children: [
              const TRoundedImage(
                image: TImages.acerlogo,
                width: 50,
                height: 50,
                imageType: ImageType.asset,
                borderRadius: AppSizes.borderRadiusMd,
                backgroundColor: AppColors.primaryBackground,
              ),
              const SizedBox(width: AppSizes.spaceBtwItems),
              Expanded(
                child: Text(
                  'Name',
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
        const DataCell(Text('Parent')),
        const DataCell(Icon(Iconsax.heart5, color: AppColors.primary)),
        DataCell(Text(DateTime.now().toString())),
        DataCell(
          TTableActionButtons(
            onEditPressed:
                () => AppContext.context.pushNamedPage(
                  Routes.editCategory,
                  arguments: CategoryModel.empty(),
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
  int get rowCount => 5;

  @override
  int get selectedRowCount => 0;
}
