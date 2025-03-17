import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store_admin_panel/core/shared/widgets/containers/rounded_container.dart';
import 'package:t_store_admin_panel/core/shared/widgets/sections/section_heading.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/colors.dart';
import 'package:t_store_admin_panel/core/utils/utils/constants/sizes.dart';

class DashboardCard extends StatelessWidget {
  const DashboardCard({
    super.key,
    required this.title,
    required this.subtitle,
    this.icon = Iconsax.arrow_up_3,
    this.color = AppColors.success,
    required this.stats,
    this.onTap,
  });
  final String title, subtitle;
  final IconData icon;
  final Color color;
  final int stats;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      onTap: onTap,
      padding: const EdgeInsets.all(AppSizes.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Heading
          SectionHeading(title: title, textColor: AppColors.textSecondary),
          const SizedBox(height: AppSizes.spaceBtwSections),
          // Subheading
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(subtitle, style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(width: AppSizes.sm),
              // Right side stats
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Indicator
                    SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(icon, color: color, size: AppSizes.iconSm),
                          Text(
                            '$stats%',
                            style: Theme.of(
                              context,
                            ).textTheme.titleLarge!.apply(
                              color: color,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 135,
                      child: FittedBox(
                        child: Text(
                          'Compared to Dec 2025',
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
