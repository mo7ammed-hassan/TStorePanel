import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store_admin_panel/config/routes/routes.dart';
import 'package:t_store_admin_panel/config/service_locator/service_locator.dart';
import 'package:t_store_admin_panel/core/shared/widgets/containers/rounded_container.dart';
import 'package:t_store_admin_panel/core/shared/widgets/data_table/table_action.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/colors.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/core/utils/utils/helpers/app_context.dart';
import 'package:t_store_admin_panel/core/utils/utils/helpers/helper_functions.dart';
import 'package:t_store_admin_panel/core/utils/utils/helpers/navigation.dart';
import 'package:t_store_admin_panel/features/dashboard/presentation/cubits/cubit/dashboard_cubit.dart';

class AllOrdersRows extends DataTableSource {
  final isDark = HelperFunctions.isDarkMode(AppContext.context);
  @override
  DataRow? getRow(int index) {
    final order = getIt<DashboardCubit>().orders[index];
    return DataRow2(
      onTap:
          () => AppContext.context.pushNamedPage(
            Routes.orderDetail,
            arguments: order,
          ),
      cells: [
        DataCell(
          Text(
            '[#${order.id.toString()}]',
            style: Theme.of(
              AppContext.context,
            ).textTheme.bodyLarge!.apply(color: AppColors.primary),
          ),
        ),
        DataCell(Text(order.formattedOrderDate)),
        const DataCell(Text('${5} Items')),

        DataCell(
          RoundedContainer(
            raduis: AppSizes.cardRadiusSm,
            padding: const EdgeInsets.symmetric(
              vertical: AppSizes.sm,
              horizontal: AppSizes.md,
            ),
            backgroundColor: HelperFunctions.getOrderStatusColor(
              order.status!,
            ).withValues(alpha: 0.1),
            child: Text(
              order.status!.name.capitalize.toString(),
              style: TextStyle(
                color: HelperFunctions.getOrderStatusColor(order.status!),
              ),
            ),
          ),
        ),

        DataCell(Text('\$${order.totalAmount}')),
        DataCell(
          TTableActionButtons(
            view: true,
            edit: false,
            onViewPressed:
                () => AppContext.context.pushNamedPage(
                  Routes.orderDetail,
                  arguments: order,
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
  int get rowCount => getIt<DashboardCubit>().orders.length;

  @override
  int get selectedRowCount => 0;
}
