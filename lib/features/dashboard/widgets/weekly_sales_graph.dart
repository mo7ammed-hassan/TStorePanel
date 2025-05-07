import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store_admin_panel/core/shared/widgets/containers/rounded_container.dart';
import 'package:t_store_admin_panel/core/utils/device/device_utility.dart';
import 'package:t_store_admin_panel/core/utils/constants/colors.dart';
import 'package:t_store_admin_panel/core/utils/constants/sizes.dart';
import 'package:t_store_admin_panel/features/dashboard/presentation/cubits/cubit/dashboard_cubit.dart';

class WeeklySalesGraph extends StatelessWidget {
  const WeeklySalesGraph({super.key});

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Weekly Sales',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: AppSizes.spaceBtwSections),

          SizedBox(
            height: 400,
            child: BarChart(
              BarChartData(
                titlesData: buildTitleData(),
                borderData: FlBorderData(show: true, border: const Border()),
                gridData: const FlGridData(
                  // drawVerticalLine: false,
                  horizontalInterval: 200,
                  // drawHorizontalLine: true,
                ),

                barGroups:
                    context
                        .read<DashboardCubit>()
                        .weeklySales
                        .asMap()
                        .entries
                        .map(
                          (entry) => BarChartGroupData(
                            x: entry.key,
                            barRods: [
                              BarChartRodData(
                                width: 30,
                                toY: entry.value,
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(
                                  AppSizes.sm,
                                ),
                              ),
                            ],
                          ),
                        )
                        .toList(),

                groupsSpace: AppSizes.spaceBtwItems,

                barTouchData: BarTouchData(
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipColor: (group) => AppColors.secondary,
                  ),
                  touchCallback:
                      DeviceUtilities.isDesktopScreen(context)
                          ? (barTouchEvent, barTouchResponse) => {}
                          : null,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  buildTitleData() {
    return FlTitlesData(
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: (value, meta) {
            final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

            final index = value.toInt() % days.length;

            final day = days[index];

            return SideTitleWidget(meta: meta, space: 0, child: Text(day));
          },
        ),
      ),
      leftTitles: const AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          interval: 200,
          reservedSize: 50,
        ),
      ),
      topTitles: const AxisTitles(),
      rightTitles: const AxisTitles(),
    );
  }
}
