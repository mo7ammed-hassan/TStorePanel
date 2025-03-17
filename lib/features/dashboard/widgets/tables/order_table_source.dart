// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';

import 'package:t_store_admin_panel/core/shared/widgets/containers/rounded_container.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/colors.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/core/utils/utils/helpers/app_context.dart';
import 'package:t_store_admin_panel/core/utils/utils/helpers/helper_functions.dart';
import 'package:t_store_admin_panel/features/dashboard/presentation/cubits/cubit/dashboard_cubit.dart';

class OrderTableSource extends DataTableSource {
  final DashboardCubit dashboardCubit;
  OrderTableSource({required this.dashboardCubit});
  @override
  DataRow? getRow(int index) {
    final order = dashboardCubit.orders[index];
    return DataRow2(
      cells: [
        DataCell(
          Text(
            '${order.id}',
            style: Theme.of(
              AppContext.context,
            ).textTheme.bodyLarge!.apply(color: AppColors.primary),
          ),
        ),
        DataCell(Text(order.formattedOrderDate)),
        const DataCell(Text('5 Items')),
        DataCell(
          RoundedContainer(
            raduis: AppSizes.cardRadiusSm,
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.md,
              vertical: AppSizes.xs,
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
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => dashboardCubit.orders.length;

  @override
  int get selectedRowCount => 0;
}
