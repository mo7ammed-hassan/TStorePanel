import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/core/utils/device/device_utility.dart';
import 'package:t_store_admin_panel/features/dashboard/widgets/tables/custom_paginated_table.dart';
import 'package:t_store_admin_panel/features/order/screens/all_orders/table/table_scource.dart';

class OrderDataTable extends StatelessWidget {
  const OrderDataTable({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaginatedTable(
      minWidth: 700,
      columns: [
        const DataColumn2(label: Text('Order ID')),
        const DataColumn2(label: Text('Date')),
        const DataColumn2(label: Text('Items')),
        DataColumn2(
          label: const Text('Status'),
          fixedWidth: DeviceUtility.isMobileScreen(context) ? 120 : null,
        ),
        const DataColumn2(label: Text('Amount')),
        const DataColumn2(label: Text('Action'), fixedWidth: 100),
      ],
      source: AllOrdersRows(),
    );
  }
}
