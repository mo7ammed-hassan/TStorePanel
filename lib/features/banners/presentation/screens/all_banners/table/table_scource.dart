// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'package:t_store_admin_panel/config/routes/routes.dart';
import 'package:t_store_admin_panel/core/shared/widgets/data_table/table_action.dart';
import 'package:t_store_admin_panel/core/shared/widgets/images/t_rounded_image.dart';
import 'package:t_store_admin_panel/core/utils/constants/colors.dart';
import 'package:t_store_admin_panel/core/utils/constants/enums.dart';
import 'package:t_store_admin_panel/core/utils/constants/images.dart';
import 'package:t_store_admin_panel/core/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/core/utils/helpers/app_context.dart';
import 'package:t_store_admin_panel/core/utils/helpers/helper_functions.dart';
import 'package:t_store_admin_panel/core/utils/helpers/navigation.dart';
import 'package:t_store_admin_panel/data/models/banners/banner_model.dart';
import 'package:t_store_admin_panel/features/banners/cubits/banners/banner_cubit.dart';

class BannerRows extends DataTableSource {
  final List<BannerModel> banners;
  final BannerCubit bannerCubit;
  BannerRows(this.bannerCubit, {required this.banners});

  final isDark = HelperFunctions.isDarkMode(AppContext.context);

  @override
  DataRow? getRow(int index) {
    //print(banners[index].id);
    final banner = banners[index];
    if (banners.isEmpty) {
      return null;
    }
    return DataRow2(
      selected: bannerCubit.selectedItems[index],
      onSelectChanged: (value) => bannerCubit.toggleSelection(index, value),
      cells: [
        DataCell(
          TRoundedImage(
            image: banner.image ?? AppImages.defaultProductImage,
            width: 180,
            height: 100,
            imageType:
                banner.image != null ? ImageType.network : ImageType.asset,
            fit: BoxFit.cover,
            borderRadius: AppSizes.borderRadiusMd,
            backgroundColor:
                isDark ? AppColors.darkerGrey : AppColors.primaryBackground,
          ),
        ),
        DataCell(Text(banner.targetScreen)),
        DataCell(
          banner.active
              ? const Icon(Iconsax.eye, color: AppColors.primary)
              : const Icon(Iconsax.eye, color: Colors.grey),
        ),
        DataCell(
          TTableActionButtons(
            onEditPressed:
                () => AppContext.context.pushNamedPage(
                  Routes.editBanner,
                  arguments: {
                    'bannerModel': banner,
                    'bannerCubit': bannerCubit,
                  },
                ),
            onDeletePressed: () => bannerCubit.deleteOnConfirmation(banner),
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => banners.length;

  @override
  int get selectedRowCount =>
      bannerCubit.selectedItems.where((e) => e == true).length;
}
