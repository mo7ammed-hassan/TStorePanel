import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/features/dashboard/presentation/cubits/cubit/dashboard_cubit.dart';
import 'package:t_store_admin_panel/features/dashboard/widgets/tables/custom_paginated_table.dart';
import 'package:t_store_admin_panel/features/dashboard/widgets/tables/order_table_source.dart';

class DashboardOrdersTable extends StatelessWidget {
  const DashboardOrdersTable({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaginatedTable(
      minWidth: 700,
      tableheight: 500,
      dataRowHeight: AppSizes.xl * 1.2,
      columns: const [
        DataColumn2(label: Text('Order ID')),
        DataColumn2(label: Text('Date')),
        DataColumn2(label: Text('Items')),
        DataColumn2(label: Text('Status')),
        DataColumn2(label: Text('Amount')),
      ],
      source: OrderTableSource(dashboardCubit: context.read<DashboardCubit>()),
    );
  }
}
