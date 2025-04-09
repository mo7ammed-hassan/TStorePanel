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
import 'package:t_store_admin_panel/core/utils/utils/helpers/helper_functions.dart';
import 'package:t_store_admin_panel/core/utils/utils/helpers/navigation.dart';

class CustomerRows extends DataTableSource {
  final isDark = HelperFunctions.isDarkMode(AppContext.context);
  @override
  DataRow? getRow(int index) {
    return DataRow2(
      cells: [
        DataCell(
          Row(
            children: [
              TRoundedImage(
                image: TImages.user,
                width: 50,
                height: 50,
                imageType: ImageType.asset,
                fit: BoxFit.cover,
                borderRadius: AppSizes.borderRadiusMd,
                backgroundColor:
                    isDark ? AppColors.darkerGrey : AppColors.primaryBackground,
              ),
              const SizedBox(width: AppSizes.spaceBtwItems),
              Expanded(
                child: Text(
                  'Mohamed.H',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(
                    AppContext.context,
                  ).textTheme.bodyLarge!.copyWith(color: AppColors.primary),
                ),
              ),
            ],
          ),
        ),
        const DataCell(Text('Mohamed.H@gmail.com')),
        const DataCell(Text('+201096493188')),
        DataCell(Text(DateTime.now().toString())),
        DataCell(
          TTableActionButtons(
            edit: false,
            view: true,
            onViewPressed:
                () => AppContext.context.pushNamedPage(
                  Routes.customerDetails,
                  arguments: 'UserModel',
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
  int get rowCount => 8;

  @override
  int get selectedRowCount => 0;
}
