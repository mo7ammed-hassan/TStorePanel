import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/core/utils/device/device_utility.dart';
import 'package:t_store_admin_panel/features/dashboard/widgets/tables/custom_paginated_table.dart';
import 'package:t_store_admin_panel/features/products/presentation/screens/all_products/table/table_source.dart';

class ProductDataTable extends StatelessWidget {
  const ProductDataTable({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaginatedTable(
      tableheight: DeviceUtility.isDesktopScreen(context) ? 760 : 600,
      columns: [
        DataColumn2(
          label: const Text('product'),
          fixedWidth: !DeviceUtility.isDesktopScreen(context) ? 300 : 400,
        ),
        const DataColumn2(label: Text('Stock')),
        const DataColumn2(label: Text('Brand')),
        const DataColumn2(label: Text('Price')),
        const DataColumn2(label: Text('Date')),
        const DataColumn2(label: Text('Action'), fixedWidth: 100),
      ],
      source: ProductRows(),
    );
  }
}
