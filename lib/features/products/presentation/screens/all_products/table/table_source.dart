import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/config/routes/routes.dart';
import 'package:t_store_admin_panel/core/shared/widgets/data_table/table_action.dart';
import 'package:t_store_admin_panel/core/shared/widgets/images/t_rounded_image.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/colors.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/enums.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/images_strings.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/core/utils/utils/helpers/app_context.dart';
import 'package:t_store_admin_panel/core/utils/utils/helpers/navigation.dart';

class ProductRows extends DataTableSource {
  @override
  DataRow2? getRow(int index) {
    return DataRow2(
      cells: [
        DataCell(
          Row(
            children: [
              const TRoundedImage(
                image: TImages.productImage1,
                width: 50,
                height: 50,
                imageType: ImageType.asset,
                borderRadius: AppSizes.borderRadiusMd,
                backgroundColor: AppColors.primaryBackground,
              ),
              const SizedBox(width: AppSizes.spaceBtwItems),
              Flexible(
                child: Text(
                  'Addidas Shoes',
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
        const DataCell(Text('256')),
        DataCell(
          Row(
            children: [
              const TRoundedImage(
                image: TImages.adidasLogo,
                width: 35,
                height: 35,
                imageType: ImageType.asset,
                borderRadius: AppSizes.borderRadiusMd,
                backgroundColor: AppColors.primaryBackground,
              ),
              const SizedBox(width: AppSizes.spaceBtwItems),
              Flexible(
                child: Text(
                  'Addidas',
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
        const DataCell(Text('\$200 - \$534')),
        DataCell(Text(DateTime.now().toString())),
        DataCell(
          TTableActionButtons(
            onEditPressed:
                () => AppContext.context.pushNamedPage(
                  Routes.editProduct,
                  arguments: 'ProductModel',
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
  int get rowCount => 100;

  @override
  int get selectedRowCount => 0;
}
