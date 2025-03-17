import 'package:flutter/material.dart';
import 'package:t_store_admin_panel/core/shared/widgets/containers/rounded_container.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/features/dashboard/widgets/pie_chart/order_status_pie_chart.dart';
import 'package:t_store_admin_panel/features/dashboard/widgets/tables/data_table.dart';
import 'package:t_store_admin_panel/features/dashboard/widgets/weekly_sales_graph.dart';
import 'package:t_store_admin_panel/features/dashboard/widgets/dashboard_card.dart';

class DashboardDesktopScreen extends StatelessWidget {
  const DashboardDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Dashboard',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: AppSizes.spaceBtwSections),

              // Cards
              const Row(
                children: [
                  Expanded(
                    child: DashboardCard(
                      title: 'Sales total',
                      subtitle: '\$1200.6',
                      stats: 25,
                    ),
                  ),
                  SizedBox(width: AppSizes.spaceBtwItems),
                  Expanded(
                    child: DashboardCard(
                      title: 'Average Order Value',
                      subtitle: '\$25',
                      stats: 15,
                    ),
                  ),
                  SizedBox(width: AppSizes.spaceBtwItems),
                  Expanded(
                    child: DashboardCard(
                      title: 'Total Orders',
                      subtitle: '36',
                      stats: 44,
                    ),
                  ),
                  SizedBox(width: AppSizes.spaceBtwItems),
                  Expanded(
                    child: DashboardCard(
                      title: 'Visitors',
                      subtitle: '25,035',
                      stats: 2,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: AppSizes.spaceBtwSections),

              // GRAPHS
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        // Bar Graph
                        const WeeklySalesGraph(),

                        const SizedBox(height: AppSizes.spaceBtwItems),

                        // Orders
                        RoundedContainer(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Recent Orders',
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                              const SizedBox(height: AppSizes.spaceBtwSections),
                              const DashboardOrdersTable(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: AppSizes.spaceBtwSections),

                  // Pie Chart
                  const Expanded(child: OrderStatusPieChart()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// // Dummy data
// class MyData extends DataTableSource {
//   final LocalDataSource localDataSource;
//   final List<bool> selectedRows;

//   MyData(this.selectedRows, this.localDataSource);

//   @override
//   DataRow? getRow(int index) {
//     final data = localDataSource.data[index];
//     return DataRow2(
//       selected: selectedRows[index],
//       onSelectChanged: (value) {
//         localDataSource.selectRow(index, value ?? false);
//       },
//       cells: [
//         DataCell(Text(data['Column1'] ?? '')),
//         DataCell(Text(data['Column2'] ?? '')),
//         DataCell(Text(data['Column3'] ?? '')),
//         DataCell(Text(data['Column4'] ?? '')),
//       ],
//     );
//   }

//   @override
//   bool get isRowCountApproximate => false;

//   @override
//   int get rowCount => localDataSource.data.length;

//   @override
//   int get selectedRowCount => selectedRows.where((e) => e).length;
// }

// class LocalDataSource extends Cubit<List<bool>> {
//   List<Map<String, dynamic>> data = [];
//   List<Map<String, dynamic>> fliteredData = [];

//   List<bool> selectedRows = [];

//   int? sortedColumnIndex;
//   bool sortAscending = true;

//   TextEditingController searchController = TextEditingController();

//   LocalDataSource() : super([]) {
//     fetchData();
//   }

//   void fetchData() {
//     data = List.generate(
//       36,
//       (index) => {
//         'Column1': 'Data ${index + 1} - 1',
//         'Column2': 'Data ${index + 1} - 2',
//         'Column3': 'Data ${index + 1} - 3',
//         'Column4': 'Data ${index + 1} - 4',
//       },
//     );

//     selectedRows = List.generate(data.length, (index) => false);
//     emit(List.from(selectedRows));
//   }

//   void selectRow(int index, bool value) {
//     selectedRows[index] = value;
//     emit(List.from(selectedRows));
//   }

//   void sortById(int columnIndex, bool ascending) {
//     sortedColumnIndex = columnIndex;
//     sortAscending = ascending;

//     data.sort((a, b) {
//       int result = a['Column1'].toString().toLowerCase().compareTo(
//         b['Column1'].toString().toLowerCase(),
//       );

//       return ascending ? result : -result;
//     });

//     emit(List.from(selectedRows));
//   }

//   @override
//   Future<void> close() {
//     searchController.dispose();
//     return super.close();
//   }

//   void searchQuery(String query) {
//     fliteredData.assignAll(
//       data.where((element) => element['Column1'].contains(query.toLowerCase())),
//     );
//     selectedRows = List.generate(fliteredData.length, (index) => false);
//     emit(List.from(selectedRows));
//   }
// }
