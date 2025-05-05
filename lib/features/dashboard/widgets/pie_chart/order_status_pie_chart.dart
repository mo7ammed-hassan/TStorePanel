import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store_admin_panel/core/shared/widgets/containers/circular_container.dart';
import 'package:t_store_admin_panel/core/shared/widgets/containers/rounded_container.dart';
import 'package:t_store_admin_panel/core/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/core/utils/helpers/helper_functions.dart';
import 'package:t_store_admin_panel/features/dashboard/presentation/cubits/cubit/dashboard_cubit.dart';

class OrderStatusPieChart extends StatelessWidget {
  const OrderStatusPieChart({super.key});

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order Status',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: AppSizes.spaceBtwSections),

          // Graph
          Center(
            child: SizedBox(
              height: 380,
              child: PieChart(
                PieChartData(
                  centerSpaceRadius: 80,
                  sections:
                      context
                          .read<DashboardCubit>()
                          .ordersStatsData
                          .entries
                          .map((entry) {
                            final status = entry.key;
                            final count = entry.value;
                            return PieChartSectionData(
                              value: count.toDouble(),
                              radius: 70,
                              color: HelperFunctions.getOrderStatusColor(
                                status,
                              ),
                              title: count.toString(),
                              titleStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            );
                          })
                          .toList(),
                ),
              ),
            ),
          ),

          // show stats and color meta
          const SizedBox(height: AppSizes.spaceBtwItems),
          SizedBox(
            width: double.infinity,
            child: FittedBox(
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Status')),
                  DataColumn(label: Text('Orders')),
                  DataColumn(label: Text('Total')),
                ],
                rows:
                    context.read<DashboardCubit>().ordersStatsData.entries.map((
                      entry,
                    ) {
                      final status = entry.key;
                      final count = entry.value;
                      final total =
                          context.read<DashboardCubit>().totalAmount[status]!;
                      return DataRow(
                        cells: [
                          DataCell(
                            Row(
                              children: [
                                CircularContainer(
                                  width: 20,
                                  height: 20,
                                  backgroundColor:
                                      HelperFunctions.getOrderStatusColor(
                                        status,
                                      ),
                                ),

                                Expanded(child: Text(' ${status.name}')),
                              ],
                            ),
                          ),
                          DataCell(Text(count.toString())),
                          DataCell(Text('\$${total.toStringAsFixed(2)}')),
                        ],
                      );
                    }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
