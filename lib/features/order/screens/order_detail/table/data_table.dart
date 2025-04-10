import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/core/utils/device/device_utility.dart';
import 'package:t_store_admin_panel/features/customers/presentation/screens/customer_detail/table/table_scource.dart';
import 'package:t_store_admin_panel/features/dashboard/widgets/tables/custom_paginated_table.dart';

class CustomOrderTable extends StatelessWidget {
  const CustomOrderTable({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaginatedTable(
      minWidth: 550,
      tableheight: 640,
      dataRowHeight: kMinInteractiveDimension,
      columns: [
        const DataColumn2(label: Text('Order ID')),
        const DataColumn2(label: Text('Date')),
        const DataColumn2(label: Text('Items')),
        DataColumn2(
          label: const Text('Status'),
          fixedWidth: DeviceUtility.isMobileScreen(context) ? 100 : null,
        ),
        const DataColumn2(label: Text('Amount'), numeric: true),
      ],
      source: CustomOrdersRows(),
    );
  }
}
